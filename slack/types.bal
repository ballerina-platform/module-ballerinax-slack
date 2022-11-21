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
    string permalinkPublic?;
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
# + iconEmoji - Emoji to use as the icon for this message
# + iconUrl - URL to an image to use as the icon for this message
# + linkNames - Set to `true` to find and link channel names and usernames
# + mrkdwn - Set to `true` to enable Slack markup parsing
# + parse - Refers how messages should be treated: `none`, which is the default value or `full` 
# + replyBroadcast - Used in conjunction with `threadTs` and indicates whether the reply should be made visible to everyone
#                    in the channel or conversation
# + unfurlLinks - `true` to enable unfurling of primarily text-based content or otherwise `false`
# + unfurlMedia - `false` to disable unfurling of media content
# + asUser - `true` to post the message as the authed user, instead of as a bot
# + username - Bot's user name. This must be used in conjunction with `asUser` set to `false`or otherwise ignored
@display {label: "Message"}
public type Message record {
    @display {label: "Channel Name"}
    string channelName;
    @display {label: "Text"}
    string text;
    @display {label: "Timestamp Of Message"}
    string threadTs?;
    @display {label: "Attachments"}
    json[] attachments?;
    @display {label: "Blocks"}
    json[] blocks?;
    @display {label: "Icon Emoji"}
    string iconEmoji?;
    @display {label: "Icon Url"}
    string iconUrl?;
    @display {label: "Link Names"}
    boolean linkNames?;
    @display {label: "Markup Parsing"}
    boolean mrkdwn?;
    @display {label: "Parse"}
    Parse parse?;
    @display {label: "Reply Broadcast"}
    boolean replyBroadcast?;
    @display {label: "Unfurl Text Content"}
    boolean unfurlLinks?;
    @display {label: "Unfurl Media Content"}
    boolean unfurlMedia?;
    @display {label: "As Authed User"}
    boolean asUser?;
    @display {label: "Bot Username"}
    string username?;
};

# Parameters associated with updating a message.
# 
# + channelName - Channel name containing the message to be updated
# + text - Text message
# + ts - Timestamp of the message to be updated
# + attachments - A JSON-based array of structured attachments
# + blocks - A JSON-based array of structured blocks
# + linkNames - Set to `true` to find and link channel names and usernames
# + parse - Refers how messages should be treated
# + replyBroadcast - Broadcast an existing thread reply to make it visible to everyone in the channel
@display {label: "Update Message"}
public type UpdateMessage record {
    @display {label: "Channel Name"}
    string channelName;
    @display {label: "Text"}
    string text;
    @display {label: "Timestamp Of Message"}
    string ts;
    @display {label: "Attachments"}
    json[] attachments?;
    @display {label: "Blocks"}
    json[] blocks?;
    @display {label: "Link Names"}
    boolean linkNames?;
    @display {label: "Parse"}
    Parse parse?;
    @display {label: "Reply Broadcast"}
    boolean replyBroadcast?;
};

# Represents values for Parse
# 
# + NONE - none
# + FULL - full
public enum Parse {
    NONE = "none",
    FULL = "full"
}

# Holds the parameters used to create a `Client`.
#
@display{label: "Connection Config"}
public type ConnectionConfig record {|
   # Configurations related to client authentication
    http:BearerTokenConfig auth;
    # The HTTP version understood by the client
    string httpVersion = "1.1";
    # Configurations related to HTTP/1.x protocol
    http:ClientHttp1Settings http1Settings = {};
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings = {};
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with Redirection
    http:FollowRedirects? followRedirects = ();
    # Configurations associated with request pooling
    http:PoolConfiguration? poolConfig = ();
    # HTTP caching related configurations
    http:CacheConfig cache = {};
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig? circuitBreaker = ();
    # Configurations associated with retrying
    http:RetryConfig? retryConfig = ();
    # Configurations associated with cookies
    http:CookieConfig? cookieConfig = ();
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits = {};
    #SSL/TLS-related options
    http:ClientSecureSocket? secureSocket = ();
|};

type FileInfoArray FileInfo[];

# Contains information about messages in a Channel.
# 
# + user - UserId of the author
# + text - Message text
# + type - Type of the message
# + ts - Time stamp of the message
public type MessageInfo record {
    string user;
    string text;
    string 'type;
    string ts;
};

# Represents Conversation history response.
#
# + messages - List of MessageInfo
# + ok - If it is success or not
# + hasMore - False if it is end of pagination or True if it has more records
# + responseMetadata - Response metadata
type ConversationHistoryResponse record {
    MessageInfo[] messages;
    boolean ok;
    boolean hasMore;
    ResponseMetadata responseMetadata?;
};

# Represents Conversation members response.
#
# + members - List of userId of members
# + ok - If it is success or not
# + responseMetadata - Response metadata
type ConversationMembersResponse record {
    string[] members;
    boolean ok;
    ResponseMetadata responseMetadata;
};
