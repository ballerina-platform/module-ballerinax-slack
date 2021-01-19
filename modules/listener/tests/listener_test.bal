// Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
import ballerina/test;
import ballerina/config;

boolean msgReceived = false;

string token = config:getAsString("VERIFICATION_TOKEN");

listener Listener slackListener = new(9090, token);

service /slack on slackListener {
    resource function post events(http:Caller caller, http:Request request) returns error?{
           
        var event = slackListener.getEventData(caller, request);
        if(event is SlackEvent){
            
            string eventType = event.'type;
            if(eventType == APP_MENTION_EVENT){
                log:print("App Mention Event Triggered");
            }
            else if (eventType == APP_HOME_OPENED_EVENT){
                log:print("App Home Opened Event Triggered");
            }
            else if (eventType == MESSAGE_EVENT){
                //triggered when messaged to a app home 
                msgReceived = true;
                log:print("Message Event Triggered");
            }
        }
        else{
            log:print("Error occured : " + event.toString());
        }
    
    }
}

@test:Config { 
    enable:false
}
function testAssertTrue() {
    test:assertTrue(msgReceived, msg = "AssertTrue failed");
    log:print(msgReceived.toString());
}

