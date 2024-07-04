import ballerina/io; //importing the io module 
import ballerinax/slack; //importing the slack connector module

configurable string value = ?; //initializing of the configurable token value variable

final slack:Client slack = check new ({ //the initialization of the slack client at module variable
    auth: {
        token: value
    }
});

public function companySurvey() returns error? {

    json conversationsResponse = check slack->/conversations\.create.post({name: "survey-coordination"});
    io:println(conversationsResponse); //creation of a channel to coordinate surveys

    json messageResponse = check slack->/chat\.postMessage.post({channel: "survey-coordination", text: "Reply to this survey message to give input on the company"});
    io:println(messageResponse); //posting a message to the newly-created conversation

    string timestamp_value = check messageResponse.message.ts; //the message response is used to extract the timestamp of the posted message

    json replyResponse = check slack->/conversations\.replies({channel: "survey-coordination", ts: timestamp_value});
    io:println(replyResponse); //the timestamp is used to extract the replies to the posted message
}
