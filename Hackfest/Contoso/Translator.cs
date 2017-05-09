using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Xml;
using Microsoft.ApplicationInsights;

namespace UoAHackdayBot.Translate
{
    public class Translator
    {

        public async Task<string> Translate(string input, string languageTo)
        {
            string detectedLanguage = await DetectLanguage(input);
            if (detectedLanguage == languageTo || languageTo == null)
            {
                return input;
            }
            //else if (languageTo == "en")
            //{
            //    return input;
            //}
            else
            {
                var accessToken = await new AzureAuthToken().GetAccessTokenAsync();
                string uri = "http://api.microsofttranslator.com/v2/Http.svc/Translate?text=" + System.Web.HttpUtility.UrlEncode(input.Replace("*", "")) + "&from=" + detectedLanguage + "&to=" + languageTo;
                HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create(uri);
                httpWebRequest.Headers.Add("Authorization", accessToken);
                WebResponse response = httpWebRequest.GetResponse();
                using (Stream stream = response.GetResponseStream())
                {
                    System.Runtime.Serialization.DataContractSerializer dcs = new System.Runtime.Serialization.DataContractSerializer(Type.GetType("System.String"));
                    string translation = (string)dcs.ReadObject(stream);
                    return translation;
                }
            }
        }

        public async Task<string> DetectLanguage(string input)
        {
            var accessToken = await new AzureAuthToken().GetAccessTokenAsync();
            string uri = "http://api.microsofttranslator.com/v2/Http.svc/Detect?text=" + input;
            HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create(uri);
            httpWebRequest.Headers.Add("Authorization", accessToken);
            WebResponse response = null;
            try
            {
                response = httpWebRequest.GetResponse();
                using (Stream stream = response.GetResponseStream())
                {
                    System.Runtime.Serialization.DataContractSerializer dcs = new System.Runtime.Serialization.DataContractSerializer(Type.GetType("System.String"));
                    string languageDetected = (string)dcs.ReadObject(stream);
                    return languageDetected;
                }
            }
            catch
            {
                throw;
            }
            finally
            {
                if (response != null)
                {
                    response.Close();
                    response = null;
                }
            }
        }

    }
}