import ballerina/test;
import ballerina/io;


configurable string value = "";


@test:Config{}
function testGetPresence() returns error?{//has to indicate that there is a possibility of an error if we have to have "check"
    Client cl = check new({
        auth: {
            token: value
        }
    });

    json response = check cl->/users\.getPresence();//the response is stored in a variable
    io:println(response);

    var b = {"ok":true,"presence":"away","online":false,"auto_away":false,"manual_away":false,"connection_count":0}; //expected response

    boolean ok_attribute = check response.ok;

    test:assertTrue(ok_attribute, "The ok attribute was not equal to true");//testing responses

}

@test:Config{}
function testConversationsList() returns error?{
    Client cl = check new({
        auth: {
            token: value
        }
    });

    json response = check cl->/conversations\.list();

    boolean ok_attribute = check response.ok;

    test:assertFalse(ok_attribute, "The ok attribute was not equal to false");
}

@test:Config{}
function testMeMessage1() returns error?{
    Client cl = check new({
        auth: {
            token: value
        }
    });

    json response = check cl->/chat\.meMessage.post({ channel : "general", text : "This is a Test" });

    boolean ok_attribute = check response.ok;

    test:assertFalse(ok_attribute, "The ok attribute was not equal to false");
}

@test:Config{}
function testMeMessage2() returns error?{
    Client cl = check new({
        auth: {
            token: value
        }
    });

    json response = check cl->/chat\.postMessage.post({ channel : "general", text: "This is a Test" });

    string text = check response.message.text;

    test:assertEquals(text, "This is a Test", "The two texts were not the same");
}

@test:Config{}
function testScheduledMessages() returns error?{
    Client cl = check new({
        auth: {
            token: value
        }
    });

    json response = check cl->/chat\.scheduledMessages\.list();

    boolean ok_attribute = check response.ok;

    test:assertTrue(ok_attribute, "The ok attribute was not equal to true");
}

@test:Config{}
function testPostMessage1() returns error?{
    Client cl = check new({
        auth: {
            token: value
        }
    });

    json response = check cl->/chat\.postMessage.post({ channel : "general", text : "This is a Test" });

    boolean ok_attribute = check response.ok;

    test:assertTrue(ok_attribute, "The ok attribute was not equal to true");
}

@test:Config{}
function testPostMessage2() returns error?{
    Client cl = check new({
        auth: {
            token: value
        }
    });

    json response = check cl->/chat\.postMessage.post({ channel : "general", text: "This is a Test" });

    string text = check response.message.text;

    test:assertEquals(text, "This is a Test", "The two texts were not the same");
}