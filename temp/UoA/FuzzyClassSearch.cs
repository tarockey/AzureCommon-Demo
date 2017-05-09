using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using Newtonsoft.Json;

namespace UoAHackdayBot.Logic
{
    public class FuzzyClassSearch
    {

        public class Rootobject
        {
            public string odatacontext { get; set; }
            public Value[] value { get; set; }
        }

        public class Value
        {
            public string searchtext { get; set; }
            public string SUBJECT_CODE { get; set; }
        }

        public async static Task<List<string>> MakeFuzzyClassSearch(string text)
        {
            var client = new HttpClient();
            var queryString = HttpUtility.ParseQueryString(string.Empty);

            client.DefaultRequestHeaders.Add("api-Key", "");

            queryString["search"] = text;
            queryString["suggesterName"] = "sug";
            queryString["mkt"] = "en-us";

            var uri = "https://uoahackweel.search.windows.net/indexes/temp/docs/suggest?search=" + text + "&fuzzy=true&suggesterName=sug&api-version=2016-09-01";

            var response = await client.GetAsync(uri);
            using (HttpContent content = response.Content)
            {

                string result = await content.ReadAsStringAsync();

                var jsonResults = JsonConvert.DeserializeObject<Rootobject>(result);

                return jsonResults.value.Select(v => v.SUBJECT_CODE).ToList();
            }

            return null;

        }
    }
}