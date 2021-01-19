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
import ballerina/time;

//Verify by signing secret

public class Listener {
    private http:Listener httpListener;
    private string token;

    public isolated function init(int port, string token) {
        self.httpListener = new (port);
        self.token = token;
    }

    public isolated function attach(http:Service s, string[]|string? name) returns error? {
        return self.httpListener.attach(s, name);
    }

    public isolated function detach(http:Service s) returns error? {
        return self.httpListener.detach(s);
    }

    public isolated function 'start() returns error? {
        return self.httpListener.'start();
    }

    public isolated function gracefulStop() returns error? {
        return ();
    }

    public isolated function immediateStop() returns error? {
        return self.httpListener.immediateStop();
    }

    public isolated function getEventData(http:Caller caller, http:Request request) returns @untainted error|SlackEvent {
        error|json rqstJson = request.getJsonPayload();

        int slackTimeStamp = check 'int:fromString(request.getHeader("X-Slack-Request-Timestamp"));
        int nowTimeStamp =  check'int:fromString(time:currentTime().time.toString().substring(0,10));
        int timeDiff = nowTimeStamp - slackTimeStamp;

        if rqstJson is json {
            if (rqstJson.token == self.token && timeDiff<60*5) {
                string rqstType = rqstJson.'type.toString();
                if (rqstType == "url_verification") {
                    return self.verifyURL(caller,rqstJson);

                } else if (rqstType == "event_callback") {
                    return self.getEventCallBackData(caller, rqstJson);
                } else {
                    return error("Invalid Action");
                }
            } else {
                var e = caller->respond(http:STATUS_BAD_REQUEST);
                return error("Invalid Request");
            }

        } else {
            return rqstJson;
        }
    }

    public isolated function verifyURL(http:Caller caller,json rqstJson) returns @untainted error|SlackEvent {
        http:Response response = new;
        error|ValidationRequest validationRqst = rqstJson.cloneWithType(ValidationRequest);
        if (validationRqst is ValidationRequest) {

            response.statusCode = http:STATUS_OK;
            response.setPayload({challenge: <@untainted>validationRqst.challenge});

            var e = caller->respond(response);
            if e is error {
                return e;
            } else {
                return validationRqst;
            }
        } else {
            return error("Invalid Request");
        }
    }

    public isolated function getEventCallBackData(http:Caller caller,json rqstJson) returns @untainted error|SlackEvent {
        var e = caller->respond(http:STATUS_ACCEPTED);
        if e is error {
            log:printError(e.toString());
        }
        error|string eventType = rqstJson.event.'type.toString();
        if eventType is string {
            json eventJson = check rqstJson.event;
            error|SlackEvent event = check eventJson.cloneWithType(SlackEvent);
            return event;

        } else {
            return error("Unable to Locate Event Type");
        }

    }
}