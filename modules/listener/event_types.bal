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
    string|Channel channel?;
    string user?;
    string ts?;
    string text?;
    string event_ts?;
    string channel_type?;
    string tab?;
    string connected_team_id?;
    string call_id?;
    string external_unique_id?;
    string latest?;
    string previously_connected_team_id?;
    string is_ext_shared?;
    string email_domain?;
    string enterprise_id?;
    Edited edited?;
    string subtype?;
    string team?;
    string inviter?;
    string file_id?;
    FileDetails file?;
};

public type Edited record {
    string user;
    string ts;
};

public type Channel record {
    string id;
    string name;
    int created;
    string creator?;
};

public type InviteRequestedEvent record {
    string 'type;
    InviteRequest invite_request;
};

public type InviteRequest record {
    string id;
    string email;
    int date_created;
    string[] requester_ids;
    string[] channel_ids;
    string invite_type;
    string real_name;
    int date_expire;
    string request_reason?;
    Team team?;
};

public type Team record {
    string id;
    string name?;
    string domain?;
};

public type FileEvent record {
    string 'type;
    string file_id;
    FileDetails file?;
    string event_ts?;
};

public type FileDetails record {
    string id;
};

public type SlackEvent RegularSlackEvent|ValidationRequest|InviteRequestedEvent;
