import ballerina/io;
import ballerinax/slack;


public function companySurvey() returns error?{
    slack:Client cl = check new({
    auth: {
        token: value
    }
    });

    json response1 = check cl->/conversations\.create.post({name : "survey-coordination"});
    io:println(response1);

    json response2 = check cl->/chat\.postEphemeral.post({channel : "survey-coordination" , user : "sample-user"});
    io:println(response2);

    json response3 = check cl->/conversations\.replies({channel : "survey-coordination", ts : "1234567890.123456"});
    io:println(response3);
}