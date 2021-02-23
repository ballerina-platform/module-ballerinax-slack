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

import ballerina/http;

# Contains information about the channel topic.
# 
# + value - Value of the topic
# + creator - The user ID of the member who created the topic
public type Topic record {
    string value;
    string creator;
};

# Contains information about the channel purpose.
# 
# + value - Value of the purpose
# + creator - The user ID of the member who created the channel
public type Purpose record {
    string value;
    string creator;
};

# Contains information about the channel.
# 
# + id - ID of the channel
# + name - Name of the channel
# + isChannel - `true` if a channel or else `false`
# + isGroup - `true` if a group conversation or else `false`
# + isArchived - `true` if the channel is archived
# + isGeneral - `true` if the channel is the "general" channel, which includes all regular members
# + nameNormalized - Normalized name
# + parentConversation - Name of the parent conversation if there is one
# + creator - The user ID of the member who created the channel
# + isMember - `true` if the calling member is part of the channel
# + isPrivate - `true` if a private channel
# + topic - Contains information about the channel topic
# + purpose - Contains information about the channel purpose
public type Channel record {
    string id;
    string name;
    boolean isChannel;
    boolean isGroup;
    boolean isArchived;
    boolean isGeneral;
    string nameNormalized;
    string? parentConversation;
    string creator;
    boolean isMember?;
    boolean isPrivate;
    Topic topic;
    Purpose purpose;
};

# Contains information about conversations.
# 
# + channels - An array of channels
# + responseMetadata - Response meta data
public type Conversations record {
    Channel[] channels;
    ResponseMetadata responseMetadata;
};

# Contains information about the response meta data.
# 
# + nextCursor - Cursor in the second request
public type ResponseMetadata record {
    string nextCursor;
};

# Contains information about the user.
# 
# + id - User ID
# + teamId - Team ID
# + name - Name of the user
# + deleted - `true` if the user has been deactivated or else `false`
# + realName - The real name that the users specified in their workspace profile
# + tz - The time zone
# + tzLabel - The commonly-used name of the `tz` timezone
# + profile - Contains information about the user's workspace profile
# + isAdmin - `true` if the user is an admin of the current workspace
# + isOwner - `true` if the user is an owner of the current workspace
# + isPrimaryOwner - `true` if the user is the primary owner of the current workspace
# + isRestricted - `true` if the user is a guest user
# + isBot - `true` if the user is a bot user
# + isAppUser - `true` if the user is an authorized user of the calling app
# + has2fa - `true` if the user has two factor authentication
public type User record {
    string id;
    string teamId;
    string name;
    boolean deleted;
    string realName;
    string tz;
    string tzLabel;
    Profile profile;
    boolean isAdmin;  
    boolean isOwner;
    boolean isPrimaryOwner;
    boolean isRestricted;
    boolean isBot;
    boolean isAppUser;
    boolean has2fa;
};

# Contains information about the user profile.
# 
# + title - Title added in the user profile
# + phone - Phone number 
# + skype - Skype ID
# + realName - The real name, which the users specified in their workspace profile
# + realNameNormalized - The `real_name` field with any non-Latin characters filtered out
# + displayName - The display name, which the users have chosen to identify themselves by in their workspace profile
# + displayNameNormalized - The `display_name` field with any non-Latin characters filtered out
public type Profile record {
    string title;
    string phone;
    string skype;
    string realName;
    string realNameNormalized;
    string displayName;
    string displayNameNormalized;
};

# Contains information about the file.
# 
# + id - File ID
# + created - Timestamp representing when the file was created
# + name - File name
# + title - File title
# + user - The user ID of the user who uploaded the file
# + editable - `true` if the file is stored as editable
# + size - File size in bytes
# + mode - Contains one of hosted, external, snippet, or post
# + isExternal - `true` if the master copy of the file is stored within the system otherwise `false`
# + externalType - Type of the external file (e.g., Dropbox or GDoc)
# + isPublic - `true` if the file is public
# + publicUrlShared - `true` if the file's public URL has been shared
# + urlPrivate - Points to a URL for the file content
# + urlPrivateDownload - Includes headers to force a browser download
# + permalink - The URL pointing to a single page for the file containing details, comments, and a download link
# + permalinkPublic - Points to a public file itself
# + lines - The total count of the lines shown in the snippet
# + linesMore - The count of the lines not shown in the preview
# + commentsCount - The number of comments attached to the file
public type FileInfo record {
    string id;
    float created;
    string name;
    string title;
    string user;
    boolean editable;
    int size;
    string mode;
    boolean isExternal;
    string? externalType;
    boolean isPublic;
    boolean publicUrlShared;
    string urlPrivate;
    string urlPrivateDownload;
    string permalink;
    string permalinkPublic;
    int lines;
    int linesMore;
    int commentsCount;
};

# Parameters associated with posting messages in Slack.
# 
# + channelName - Channel name
# + text - Text message
# + threadTs - Provide another message's `ts` value to make this message a reply
# + attachments - A JSON-based array of structured attachments
# + blocks - A JSON-based array of structured blocks
# + iconImoji - Emoji to use as the icon for this message
# + iconUrl - URL to an image to use as the icon for this message
# + linkNames - Set to `true` to find and link channel names and usernames
# + mrkdwn - Set to `true` to enable Slack markup parsing
# + parse - Refers how messages should be treated: `none`, which is the default value or `full` 
# + replyBroadcast - Used in conjunction with `threadTs` and indicates whether the reply should be made visible to everyone
#                    in the channel or conversation
# + unfurlLinks - `true` to enable unfurling of primarily text-based content or otherwise `false`
# + unfurlMedia - `false` to disable unfurling of media content
# + username - Bot's user name. This must be used in conjunction with `asUser` set to `false`or otherwise ignored
public type Message record {|
    string channelName;
    string text;
    string threadTs?;
    json[] attachments?;
    json[] blocks?;
    string iconImoji?;
    string iconUrl?;
    boolean linkNames?;
    boolean mrkdwn = true;
    Parse parse = NONE;
    boolean replyBroadcast = false;
    boolean unfurlLinks?;
    boolean unfurlMedia?;
    string username?;
|};

# Refers how messages should be treated: `none`, which is the default value or `full` 
public type Parse NONE|FULL;

# Holds the parameters used to create a `Client`.
#
# + bearerTokenConfig - Bearer token configuration
public type Configuration record {|
   http:BearerTokenConfig bearerTokenConfig;
|};

type FileInfoArray FileInfo[];
