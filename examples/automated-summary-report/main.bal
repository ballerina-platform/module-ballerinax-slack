import ballerina/io;
import ballerina/log;
import ballerinax/slack;

configurable string token = ?;

# Holds slack channel information.
type ChannelType record {
    string id;
};

# Holds response struture of the channels list.
type Channels record {|
    boolean ok;
    ChannelType[] channels;
|};

# Holds information of each text 
type TextType record {
    string text;
};

# Holds the response structure of the conversation history.
type History record {
    boolean ok;
    TextType[] texts;
};

// Initialize the Slack client with the provided token.
final slack:Client slack = check new Client({
    auth: {
        token: value
    }
});

public function main() returns error? {
    // Fetch the list of channels.
    json channelResponse = check slack->/conversations\.list();
    Channels channels = check channelResponse.cloneWithType();

    // Array to store the latest text messages from each channel.
    string[] latestText;

    // Iterate through each channel to get the latest message.
    foreach ChannelType channel in channels.channels {
        // Fetch the conversation history for the current channel.
        json historyResponse = check slack->/conversations\.history({channel: channel.id});
        History history = check historyResponse.cloneWithType();

        // Get the latest text message from the conversation history.
        TextType[] texts = history.texts;
        latestText.push(texts[0].text);
    }

    // Construct the stand-up report message.
    string textMessage = string `Automated Stand Up Report: ${"\n"}${
        <string>from [int, string] [index, text] in latestText.enumerate()
        select string `${index + 1}. ${text}${"\n"}`
    }`;

    // Post the stand-up report message to the "general" channel.
    json|error postMessageResult = slack->/chat\.postMessage.post({channel: "general", text: textMessage});

    if postMessageResult is error {
        log:printError("Failed to post message to Slack", postMessageResult);
    } else {
        log:printInfo("Message posted successfully");
    }
}