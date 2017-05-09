using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using Microsoft.Bot.Builder.Dialogs.Internals;
using Microsoft.Bot.Builder.Internals.Fibers;
using Microsoft.Bot.Connector;

namespace UoAHackdayBot.Translate
{
    public sealed class InterceptBotToUser : IBotToUser
    {
        private readonly IMessageActivity _toBot;
        private readonly IConnectorClient _client;

        public InterceptBotToUser(IMessageActivity toBot, IConnectorClient client)
        {
            SetField.NotNull(out _toBot, nameof(toBot), toBot);
            SetField.NotNull(out _client, nameof(client), client);
        }

        IMessageActivity IBotToUser.MakeMessage()
        {
            var toBotActivity = (Activity)_toBot;
            return toBotActivity.CreateReply();
        }

        async Task IBotToUser.PostAsync(IMessageActivity message, CancellationToken cancellationToken)
        {
            await _client.Conversations.ReplyToActivityAsync((Activity)message, cancellationToken);
        }
    }

    public sealed class BotToUserTextWriter : IBotToUser
    {
        private readonly IBotToUser _inner;

        public BotToUserTextWriter(IBotToUser inner)
        {
            SetField.NotNull(out _inner, nameof(inner), inner);
        }

        IMessageActivity IBotToUser.MakeMessage()
        {
            return _inner.MakeMessage();
        }
        async Task IBotToUser.PostAsync(IMessageActivity message, CancellationToken cancellationToken)
        {
            //StateClient sc = activity.GetStateClient();
            //BotData data = await sc.BotState.GetUserDataAsync(activity.ChannelId, activity.Recipient.Id, cancellationToken: cancellationToken);


            var activity = (Activity) message;
            var stateClient = activity.GetStateClient();

            var userdata = await stateClient.BotState.GetUserDataAsync(activity.ChannelId, activity.Recipient.Id, cancellationToken: cancellationToken);
            var userLanguage = userdata.GetProperty<string>("lang");

            var translator = new Translator();
            
            // work out this part, how to assign language the user wants
            var translatedText = await translator.Translate(activity.Text, userLanguage);
            message.Text = translatedText;
            await _inner.PostAsync(message);
        }
    }

}