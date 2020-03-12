// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import ballerina/oauth2;
import ballerina/http;

# Contains information about the channel topic.
# 
# + value - Value of the topic
# + creator - The user Id of the member that created the topic
public type Topic record {
    string value;
    string creator;
};

# Contains information about the channel purpose.
# 
# + value - Value of the purpose
# + creator - The user Id of the member that created the channel
public type Purpose record {
    string value;
    string creator;
};

# Contains information about the channel.
# 
# + id - Id of the channel
# + name - Name of the channel
# + is_channel - `true` if a channel, else `false`
# + is_group - `true` if a group conversation, else `false`
# + is_archived - `true` if the channel is archived
# + is_general - `true` if the channel is the "general" channel that includes all regular members
# + name_normalized - Normalized name
# + parent_conversation - Name of the parent conversation if there is one
# + creator - The user Id of the member that created the channel
# + is_member - `true` if the calling member is part of the channel
# + is_private - `true` if a private channel
# + topic - Contains information about the channel topic
# + purpose - Contains information about the channel purpose
public type Channel record {
    string id;
    string name;
    boolean is_channel;
    boolean is_group;
    boolean is_archived;
    boolean is_general;
    string name_normalized;
    string? parent_conversation;
    string creator;
    boolean is_member?;
    boolean is_private;
    Topic topic;
    Purpose purpose;
};

# Contains information about conversations.
# 
# + channels - An array of channels
# + response_metadata - Response meta data
public type Conversations record {
    Channel[] channels;
    Response_metadata response_metadata;
};

# Contains information about the response meta data.
# 
# + next_cursor - Cursor in the second request
public type Response_metadata record {
    string next_cursor;
};

# Contains information about the user.
# 
# + id - User id
# + team_id - Team id
# + name - Name of the user
# + deleted - `true` if the user has been deactivated, otherwise false
# + real_name - The real name that the user specified in their workspace profile
# + tz - The time zone
# + tz_label - the commonly used name of the `tz` timezone
# + profile - Contains information about user's workspace profile
# + is_admin - `true` if the user is an admin of the current workspace
# + is_owner - `true` if the user is an owner of the current workspace
# + is_primary_owner - `true` if the user is the primary owner of the current workspace
# + is_restricted - `true` if the user is a guest user
# + is_bot - `true` if the user is a bot user
# + is_app_user - `true` if the user is an authorized user of the calling app
# + has_2fa - `true` if the user has two factor authentication
public type User record {
    string id;
    string team_id;
    string name;
    boolean deleted;
    string real_name;
    string tz;
    string tz_label;
    Profile profile;
    boolean is_admin;  
    boolean is_owner;
    boolean is_primary_owner;
    boolean is_restricted;
    boolean is_bot;
    boolean is_app_user;
    boolean has_2fa;
};

# Contains information about the user profile.
# 
# + title - Title added in the user profile
# + phone - Phone number 
# + skype - skype id
# + real_name - The real name that the user specified in their workspace profile
# + real_name_normalized - The `real_name` field, but with any non-Latin characters filtered out
# + display_name - The display name that the user has chosen to identify themselves by in their workspace profile
# + display_name_normalized - The `display_name` field, but with any non-Latin characters filtered out
public type Profile record {
    string title;
    string phone;
    string skype;
    string real_name;
    string real_name_normalized;
    string display_name;
    string display_name_normalized;
};

# Contains information about the file.
# 
# + id - File id
# + created - Timestamp representing when the file was created
# + name - File name
# + title - File title
# + user - The user id of the user who uploaded the file
# + editable - `true` if the file is stored as editable
# + size - File size in bytes
# + mode - Contains one of hosted, external, snippet or post
# + is_external - `true` if the master copy of the file is stored within the system, otherwise `false`
# + external_type - Kind of external file eg: dropbox or gdoc
# + is_public - `true` if the file is public
# + public_url_shared - `true` if the file's public url has been shared
# + url_private - Points to a URL to the file content
# + url_private_download - Includes headers to force a browser download
# + permalink - The URL pointing to a single page for the file containing details, comments and a download link
# + permalink_public - Points to a public file itself
# + lines - The total count of the lines shown in the snippet
# + lines_more - The count of the lines not shown in the preview
# + comments_count - The number of comments attached to the file
public type FileInfo record {
    string id;
    float created;
    string name;
    string title;
    string user;
    boolean editable;
    int size;
    string mode;
    boolean is_external;
    string? external_type;
    boolean is_public;
    boolean public_url_shared;
    string url_private;
    string url_private_download;
    string permalink;
    string permalink_public;
    int lines;
    int lines_more;
    int comments_count;
};

# Holds the parameters used to create a `Client`.
#
# + oAuth2Config - OAuth2 client configuration
# + proxyConfig - Proxy configuration if connecting through a proxy
public type Configuration record {
   oauth2:DirectTokenConfig oAuth2Config;
   http:ProxyConfig? proxyConfig = ();
};
