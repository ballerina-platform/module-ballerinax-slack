import ballerina/io;
import ballerinax/slack;

public function companySurvey() returns error? {
    slack:Client cl = check new ({
        auth: {
            token: value
        }
    });

    json response1 = check cl->/conversations\.create.post({name: "survey-coordination"});
    io:println(response1);

    json response2 = check cl->/chat\.postMessage.post({channel: "survey-coordination", text: "Reply to this survey message to give input on the company"});
    io:println(response2);

    string ts_value = check response2.message.ts;

    json response3 = check cl->/conversations\.replies({channel: "survey-coordination", ts: ts_value});
    io:println(response3);
}
