import ballerina/io;
import ballerinax/slack;


configurable string value = "";

    public function productLaunch() returns error?{
        slack:Client cl = check new({
        auth: {
            token: value
        }
        });

        json response1 = check cl->/conversations\.create.post({name : "product-launch"});
        io:println(response1);

        json response2 = check cl->/conversations\.invite.post({channel: "product-launch", users: "sample-user"});
        io:println(response2);

        json response3 = check cl->/chat\.scheduleMessage.post({channel : "product-launch", text : "Merry Christmas!", post_at : "1735110000"});
        io:println(response3);
    }