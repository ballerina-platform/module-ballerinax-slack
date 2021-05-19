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

# Slack Event information.
#
# + token - A verification token to validate the event originated from Slack
# + team_id - The unique identifier of the workspace where the event occurred
# + api_app_id - The unique identifier your installed Slack application. Use this to distinguish which app the event 
#                belongs to if you use multiple apps with the same Request URL.
# + event - Contains the inner set of fields representing the actual event, that happened
# + 'type - Indicates which kind of event dispatch this is, usually `event_callback`
# + event_id - A unique identifier for this specific event, globally unique across all workspaces
# + event_time - The epoch timestamp in seconds indicating when this event was dispatched
# + event_context - Information about the event context 
# + authorizations - Describes one of the installations that this event is visible to
public type SlackEvent record { 
    string token;
    string team_id;
    string api_app_id;
    EventType event;
    string 'type;
    string event_id;
    int event_time;
    string event_context?;
    json authorizations?;
};

# The inner set of fields representing the actual slack event, that happened.
#
# + 'type - The specific name of the event
public type EventType record {
    string 'type;
};

# Slack Event that mention your app or bot information.
#
# + token - A verification token to validate the event originated from Slack
# + team_id - The unique identifier of the workspace where the event occurred
# + api_app_id - The unique identifier your installed Slack application. Use this to distinguish which app the event 
#                belongs to if you use multiple apps with the same Request URL.
# + event - Contains the inner set of fields representing the actual event, that happened
# + 'type - Indicates which kind of event dispatch this is, usually `event_callback`
# + event_id - A unique identifier for this specific event, globally unique across all workspaces
# + event_time - The epoch timestamp in seconds indicating when this event was dispatched
# + event_context - Information about the event context 
# + authorizations - Describes one of the installations that this event is visible to 
public type AppMentionEvent record { 
    string token;
    string team_id;
    string api_app_id;
    AppMentionEventType event;
    string 'type;
    string event_id;
    int event_time;
    string event_context?;
    json authorizations?;
};

# The inner set of fields representing the actual slack event that mention your app or bot.
#
# + 'type - Indicates which kind of event dispatch this 
# + channel - The channel that mention your app or bot
# + user - The user who mention your app or bot
# + text - The mentioned text
# + ts - The timestamp of what the event describes, which may occur slightly prior to the event being dispatched
# + event_ts - The timestamp the event was dispatched 
public type AppMentionEventType record {
    string 'type;
    string channel?;
    string user?;
    string text?;
    string ts?;
    string event_ts?;
};

# Slack Event with channel created information.
#
# + token - A verification token to validate the event originated from Slack
# + team_id - The unique identifier of the workspace where the event occurred
# + api_app_id - The unique identifier your installed Slack application. Use this to distinguish which app the event 
#                belongs to if you use multiple apps with the same Request URL.
# + event - Contains the inner set of fields representing the actual event, that happened
# + 'type - Indicates which kind of event dispatch this is, usually `event_callback`
# + event_id - A unique identifier for this specific event, globally unique across all workspaces
# + event_time - The epoch timestamp in seconds indicating when this event was dispatched
# + event_context - Information about the event context 
# + authorizations - Describes one of the installations that this event is visible to  
public type ChannelCreatedEvent record { 
    string token;
    string team_id;
    string api_app_id;
    ChannelCreatedEventType event;
    string 'type;
    string event_id;
    int event_time;
    string event_context?;
    json authorizations?;
};

# The inner set of fields representing the actual slack event, that happened with channel created information.
#
# + 'type - Indicates which kind of event dispatch this 
# + channel - The created channel
public type ChannelCreatedEventType record {
    string 'type;
    Channel channel?;
};

# The created channel information.
#
# + id - Channel ID
# + name - Channel name
# + created - The epoch timestamp in seconds indicating when this channel was created
# + creator - The creator of the channel
public type Channel record {
    string id;
    string name?;
    int created?;
    string creator?;
};

# Slack Event with custom emoji added or changed information.
#
# + token - A verification token to validate the event originated from Slack
# + team_id - The unique identifier of the workspace where the event occurred
# + api_app_id - The unique identifier your installed Slack application. Use this to distinguish which app the event 
#                belongs to if you use multiple apps with the same Request URL.
# + event - Contains the inner set of fields representing the actual event, that happened
# + 'type - Indicates which kind of event dispatch this is, usually `event_callback`
# + event_id - A unique identifier for this specific event, globally unique across all workspaces
# + event_time - The epoch timestamp in seconds indicating when this event was dispatched
# + event_context - Information about the event context 
# + authorizations - Describes one of the installations that this event is visible to 
public type EmojiChangedEvent record { 
    string token;
    string team_id;
    string api_app_id;
    EmojiChangedEventType event;
    string 'type;
    string event_id;
    int event_time;
    string event_context?;
    json authorizations?;
};

# The inner set of fields representing the actual slack event, that happened with custom emoji added or
# changed information.
#
# + 'type - Field Description  
# + subtype - Emoji changed subtype  
# + event_ts - The timestamp the event was dispatched   
# + name - Emoji name 
# + value - Emoji value
public type EmojiChangedEventType record {
    string 'type;
    string subtype?;
    string event_ts?;
    string name?;
    string value?;
};

# Slack Event with file shared information.
#
# + token - A verification token to validate the event originated from Slack
# + team_id - The unique identifier of the workspace where the event occurred
# + api_app_id - The unique identifier your installed Slack application. Use this to distinguish which app the event 
#                belongs to if you use multiple apps with the same Request URL.
# + event - Contains the inner set of fields representing the actual event, that happened
# + 'type - Indicates which kind of event dispatch this is, usually `event_callback`
# + event_id - A unique identifier for this specific event, globally unique across all workspaces
# + event_time - The epoch timestamp in seconds indicating when this event was dispatched
# + event_context - Information about the event context 
# + authorizations - Describes one of the installations that this event is visible to 
public type FileSharedEvent record { 
    string token;
    string team_id;
    string api_app_id;
    FileSharedEventType event;
    string 'type;
    string event_id;
    int event_time;
    string event_context?;
    json authorizations?;
};

# The inner set of fields representing the actual slack event, that happened with file shared information.
#
# + 'type - Indicates which kind of event dispatch this  
# + channel_id - Channel ID the file was shared
# + file_id - ID of the file shared 
# + user_id - ID of the user who shared the file
# + file - The shared file
# + event_ts - The timestamp the event was dispatched 
public type FileSharedEventType record {
    string 'type;
    string channel_id?;
    string file_id?;
    string user_id?;
    File file?;
    string event_ts?;
};

# The shared file information
#
# + id - Shared file ID
public type File record {
    string id;
};

# Slack Event with member joined channel information.
#
# + token - A verification token to validate the event originated from Slack
# + team_id - The unique identifier of the workspace where the event occurred
# + api_app_id - The unique identifier your installed Slack application. Use this to distinguish which app the event 
#                belongs to if you use multiple apps with the same Request URL.
# + event - Contains the inner set of fields representing the actual event, that happened
# + 'type - Indicates which kind of event dispatch this is, usually `event_callback`
# + event_id - A unique identifier for this specific event, globally unique across all workspaces
# + event_time - The epoch timestamp in seconds indicating when this event was dispatched
# + event_context - Information about the event context 
# + authorizations - Describes one of the installations that this event is visible to 
public type MemberJoinedChannelEvent record { 
    string token;
    string team_id;
    string api_app_id;
    MemberJoinedChannelEventType event;
    string 'type;
    string event_id;
    int event_time;
    string event_context?;
    json authorizations?;
};

# The inner set of fields representing the actual slack event, that happened with member joined channel information.
#
# + 'type - Field Description  
# + user - User ID belonging to the user that joined the channel  
# + channel - ID of the channel joined  
# + channel_type - single letter indicating the type of channel used in "channel"  
# + team - The workspace the user is from  
# + inviter - User ID of the inviting user  
# + event_ts - The timestamp the event was dispatched 
public type MemberJoinedChannelEventType record {
    string 'type;
    string user?;
    string channel?;
    string channel_type?;
    string team?;
    string inviter?;
    string event_ts?;
};

# Slack Event with message sent information.
#
# + token - A verification token to validate the event originated from Slack
# + team_id - The unique identifier of the workspace where the event occurred
# + api_app_id - The unique identifier your installed Slack application. Use this to distinguish which app the event 
#                belongs to if you use multiple apps with the same Request URL.
# + event - Contains the inner set of fields representing the actual event, that happened
# + 'type - Indicates which kind of event dispatch this is, usually `event_callback`
# + event_id - A unique identifier for this specific event, globally unique across all workspaces
# + event_time - The epoch timestamp in seconds indicating when this event was dispatched
# + event_context - Information about the event context 
# + authorizations - Describes one of the installations that this event is visible to 
public type MessageEvent record { 
    string token;
    string team_id;
    string api_app_id;
    MessageEventType event;
    string 'type;
    string event_id;
    int event_time;
    string event_context?;
    json authorizations?;
};

# The inner set of fields representing the actual slack event, that happened with message sent information.
#
# + 'type - Indicates which kind of event dispatch this 
# + channel - The channel the message was sent
# + channel_type - The channel type of the message
# + user - The user who sent the message
# + text - The message text
# + ts - The timestamp of what the event describes, which may occur slightly prior to the event being dispatched
# + event_ts - The timestamp the event was dispatched
public type MessageEventType record {
    string 'type;
    string channel?;
    string channel_type?;
    string user?;
    string text?;
    string ts?;
    string event_ts?;
};

# Slack Event with reaction added information.
#
# + token - A verification token to validate the event originated from Slack
# + team_id - The unique identifier of the workspace where the event occurred
# + api_app_id - The unique identifier your installed Slack application. Use this to distinguish which app the event 
#                belongs to if you use multiple apps with the same Request URL.
# + event - Contains the inner set of fields representing the actual event, that happened
# + 'type - Indicates which kind of event dispatch this is, usually `event_callback`
# + event_id - A unique identifier for this specific event, globally unique across all workspaces
# + event_time - The epoch timestamp in seconds indicating when this event was dispatched
# + event_context - Information about the event context 
# + authorizations - Describes one of the installations that this event is visible to 
public type ReactionAddedEvent record { 
    string token;
    string team_id;
    string api_app_id;
    ReactionAddedEventType event;
    string 'type;
    string event_id;
    int event_time;
    string event_context?;
    json authorizations?;
};

# The inner set of fields representing the actual slack event, that happened with reaction added information.
#
# + 'type - Indicates which kind of event dispatch this 
# + user - ID of the user who performed this event
# + reaction - The reaction added
# + item_user - ID of the user that created the original item that has been reacted to
# + item - Brief reference to what was reacted to
# + event_ts - The timestamp the event was dispatched
public type ReactionAddedEventType record {
    string 'type;
    string user?;
    string reaction?;
    string item_user?;
    Item item?;
    string event_ts?;
};

# Brief reference to what was reacted to.
#
# + 'type - The type of the item reacted
# + channel - The channel of the item reacted
# + ts - The timestamp of reaction
public type Item record {
    string 'type?;
    string channel?;
    string ts?;
};

# Slack Event with new member team join information.
#
# + token - A verification token to validate the event originated from Slack
# + team_id - The unique identifier of the workspace where the event occurred
# + api_app_id - The unique identifier your installed Slack application. Use this to distinguish which app the event 
#                belongs to if you use multiple apps with the same Request URL.
# + event - Contains the inner set of fields representing the actual event, that happened
# + 'type - Indicates which kind of event dispatch this is, usually `event_callback`
# + event_id - A unique identifier for this specific event, globally unique across all workspaces
# + event_time - The epoch timestamp in seconds indicating when this event was dispatched
# + event_context - Information about the event context 
# + authorizations - Describes one of the installations that this event is visible to 
public type TeamJoinEvent record { 
    string token;
    string team_id;
    string api_app_id;
    TeamJoinEventType event;
    string 'type;
    string event_id;
    int event_time;
    string event_context?;
    json authorizations?;
};

# The inner set of fields representing the actual slack event, that happened with new member team join information.
#
# + 'type - Indicates which kind of event dispatch this 
# + user - User information of the team  
# + event_ts - The timestamp the event was dispatched
public type TeamJoinEventType record {
    string 'type;
    json user?;
    string event_ts?;
};

# Listener configuration.
#
# + port - Listener port 
# + verificationToken - Slack verification token
public type ListenerConfiguration record {
    int port;
    string verificationToken;
};
