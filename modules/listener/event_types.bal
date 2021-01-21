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

# Record representing the configuration for the Slack Listener.
#
# + verificationToken - the verification token mentioned in your slack app settings - basic information section
public type ListenerConfiguration record {|
    string verificationToken;
|};

public type ValidationRequest record {
    string token;
    string challenge;
    string 'type;
};

public type RegularSlackEvent record {
    string 'type;
    string channel?;
    Channel detailedChannel?;
    string user?;
    string ts?;
    string text?;
    string event_ts?;
    string channel_type?;
    string tab?;
    string connected_team_id?;
};

public type Channel record {
    string id;
    string name;
    string created;
};

public type FileEvent record {
    string 'type;
    string fileId;
    FileDetails file?;
    string event_ts?;
};

public type FileDetails record {
    string id;
};

public type SlackEvent RegularSlackEvent|FileEvent|ValidationRequest;
