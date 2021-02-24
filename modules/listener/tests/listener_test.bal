// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
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

import ballerina/http;
import ballerina/log;
import ballerina/os;
import ballerina/test;

boolean msgReceived = false;

string token = os:getEnv("VERIFICATION_TOKEN");
int port = check 'int:fromString(os:getEnv("PORT"));

ListenerConfiguration config = {verificationToken: token};

listener SlackEventListener slackListener = new (port, config);

service /slack on slackListener {
    resource function post events(http:Caller caller, http:Request request) returns error? {
        var event = check slackListener.getEventData(caller, request);
        if (event is MessageEvent) {
            msgReceived = true;
            log:print("Message Event Triggered. Event Data : " + event.toString());
        } else if (event is AppEvent) {
            log:print("App Mention Event Triggered. Event Data : " + event.toString());
        } else if (event is FileEvent) {
            log:print("File Event Triggered. Event Data : " + event.toString());
        } else {
            log:print("Slack Event Occured. Event Data : " + event.toString());
        }
    }
}

@test:Config {enable: false}
function testMessageEvent() {
    test:assertTrue(msgReceived, msg = "Message Event Trigger Failed");
}
