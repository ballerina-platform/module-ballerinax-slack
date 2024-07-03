import ballerina/io;
import ballerinax/slack;

string token = ?;

type ChannelType record {
    string id;    
};

type Channels record {|
    boolean ok;
    ChannelType[] channels;
|};

type TextType record{
    string text;
};

type History record{
    boolean ok;
    TextType[] texts;
};


public function automatedStandUpReport() returns error?{
    slack:Client cl = check new({
    auth: {
        token: value
    }
    });

    json response = check cl->/conversations\.list();
    Channels castedResponse = check response.cloneWithType(Channels);

    string[] latestText; 

    foreach ChannelType channel in castedResponse.channels{
        json response1 = check cl->/conversations\.history({channel: channel.id});
        History castedResponse1 = check response1.cloneWithType(History);

        TextType[] texts = castedResponse1.texts;
        latestText.push(texts[0].text);
    }

    string textMessage = "Automated Stand Up Report: ";
    int i = 1;
    foreach string text in latestText{
        string number = i.toString();
        textMessage = textMessage.join(number + ". " + text + "\n");
        i = i + 1;
    }

    json response3 = check cl->/chat\.postMessage.post({channel: "general", text:textMessage});

}