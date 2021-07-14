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

# Balleina Slack Listener provides the capability to access Slack Events API.
@display {label: "Slack Listener"}
public class Listener {
    private http:Listener httpListener;
    private string verificationToken;
    private HttpService httpService;

    # Initializes the Slack Listener. During initialization, you have to pass Slack Verification token and port.
    # Visit https://api.slack.com/apps, create your own Slack App and enable Event Subscription by going to 
    # `Event Subscriptions` section in your Slack App. 
    # Add events that you are planning to listen in the `Subscribe to events on behalf of users` section and save changes.
    # Obtain `Verification Token` from the `Basic Information` section of your Slack App.
    # 
    # + config - Configuration required to initialize the Listener
    public isolated function init(ListenerConfiguration config) returns error? {
        self.httpListener = check new (config.port);
        self.verificationToken = config.verificationToken;
    }

    public isolated function attach(SimpleHttpService s, string[]|string? name = ()) returns @tainted error? {
        self.httpService = new HttpService(s, self.verificationToken);
        check self.httpListener.attach(self.httpService, name);
    }

    public isolated function detach(service object {} s) returns error? {
        return self.httpListener.detach(s);
    }

    public isolated function 'start() returns error? {
        return self.httpListener.'start();
    }

    public isolated function gracefulStop() returns @tainted error? {
        return self.httpListener.gracefulStop();
    }

    public isolated function immediateStop() returns error? {
        return self.httpListener.immediateStop();
    }
}
