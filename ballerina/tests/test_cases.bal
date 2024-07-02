// Copyright (c) 2024 WSO2 LLC. (http://www.wso2.org).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/os;
import ballerina/test;

configurable boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
configurable string value = "token";

Client cl = check new ({
    auth: {
        token: value
    }
});

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetPresence() returns error? { //has to indicate that there is a possibility of an error if we have to have "check"

    json response = check cl->/users\.getPresence(); //the response is stored in a variable
    io:println(response);

    boolean ok_attribute = check response.ok;

    test:assertTrue(ok_attribute, "The ok attribute was not equal to true"); //testing responses

}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testPostMessage_1() returns error? {
    json response = check cl->/chat\.postMessage.post({channel: "general", text: "This is a Test"});

    boolean ok_attribute = check response.ok;

    test:assertTrue(ok_attribute, "The ok attribute was not equal to true");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testPostMessage_2() returns error? {
    json response = check cl->/chat\.postMessage.post({channel: "general", text: "This is a Test"});

    string text = check response.message.text;

    test:assertEquals(text, "This is a Test", "The two texts were not the same");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUsersList() returns error? {
    json response = check cl->/users\.list();

    boolean ok_attribute = check response.ok;

    test:assertTrue(ok_attribute, "The ok attribute was not equal to true");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUsersProfileGet() returns error? {
    json response = check cl->/users\.profile\.get();

    boolean ok_attribute = check response.ok;

    test:assertTrue(ok_attribute, "The ok attribute was not equal to true");
}
