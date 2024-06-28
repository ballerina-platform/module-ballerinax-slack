import ballerina/io;
import ballerinax/slack;


public function securityIncident() returns error?{
    slack:Client cl = check new({
    auth: {
        token: value
    }
    });

    json response1 = check cl->/conversations\.create.post({name : "incident-response"});
    io:println(response1);

    var response2 = check cl->/admin\.conversations\.restrictAccess\.addGroup.post({channel_id: "C123" , group_id: "123",token: value});
    io:println(response2);

    json response3 = check cl->/chat\.postMessage.post({channel : "incident-response" , text : "There has been a security incident"});
    io:println(response3);
    
}