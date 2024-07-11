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

import ballerina/log;
import ballerina/os;
import ballerina/test;

configurable boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
configurable string token = isLiveServer ? os:getEnv("SLACK_TOKEN") : "test";
configurable string serviceUrl = isLiveServer ? "https://slack.com/api" : "http://localhost:9090/";

ConnectionConfig slackConfig = {
    auth: {
        token
    }
};

Client slack = test:mock(Client);

@test:BeforeSuite
function setup() returns error? {
    if (isLiveServer) {
        log:printInfo("Running tests on actual server");
    } else {
        log:printInfo("Running tests on mock server");
    }

    slack = check new (slackConfig, serviceUrl);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetPresence() returns error? {
    APIMethodUsersGetPresence response = check slack->/users\.getPresence();
    test:assertTrue(response.ok, "The ok attribute was not equal to true");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testPostMessage_1() returns error? {
    ChatPostMessageResponse response = check slack->/chat\.postMessage.post({channel: "general", text: "This is a Test"});
    test:assertTrue(response.ok, "The ok attribute should be true");
    test:assertEquals(response.message.text, "This is a Test", "The message text is not equal to the expected value");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUsersList() returns error? {
    UsersListResponse response = check slack->/users\.list();
    test:assertTrue(response.ok, "The ok attribute should be true");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testUsersProfileGet() returns error? {
    UsersProfileGetResponse response = check slack->/users\.profile\.get();
    test:assertTrue(response.ok, "The ok attribute should be true");
}
