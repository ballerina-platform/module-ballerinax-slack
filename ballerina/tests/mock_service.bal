// Copyright (c) 2024 WSO2 LLC. (http://www.wso2.org).
//
// WSO2 LLC. licenses this file to you under the Apache License,
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

listener http:Listener httpListener = new (9090);

http:Service mockAPI = service object {

    # Get Presence
    #
    # + return - Get Presence
    resource isolated function get users\.getPresence() returns json => {
        "ok": true,
        "presence": "away",
        "online": false,
        "auto_away": false,
        "manual_away": false,
        "connection_count": 0
    };

    # Post Message
    #
    # + return - json
    resource isolated function post chat\.postMessage(@http:Payload http:Request request) returns ChatPostMessageResponse => {
        ok: true,
        channel: "C078KJ7SW78",
        ts: "1719830298.784769",
        message: {
            user: "U078KJ7RX1U",
            'type: "message",
            ts: "1719830298.784769",
            botId: "B07986E3N4E",
            text: "This is a Test",
            team: "T078S42MC59",
            botProfile: {
                id: "B07986E3N4E",
                appId: "A079SKHD00Z",
                name: "test-app",
                icons: {
                    image36: "https://a.slack-edge.com/80588/img/plugins/app/bot_36.png",
                    image48: "https://a.slack-edge.com/80588/img/plugins/app/bot_48.png",
                    image72: "https://a.slack-edge.com/80588/img/plugins/app/service_72.png"
                },
                deleted: false,
                updated: 1719218992,
                teamId: "T078S42MC59"
            },
            blocks: [
                {
                    "type": "rich_text",
                    "block_id": "I/L",
                    "elements": [
                        {
                            "type": "rich_text_section",
                            "elements": [
                                {
                                    "type": "text",
                                    "text": "This is a Test"
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    };

    # List Users
    #
    # + return - List Users
    resource isolated function get users\.list() returns UsersListResponse => {
        ok: true,
        cacheTs: 1697039999,
        members: [
            <UserObjAnyOf1>{
                isAppUser: true,
                isBot: false,
                updated: 0,
                id: "U078KJ7RX1U",
                teamId: "T078S42MC59",
                name: "adib",
                deleted: false,
                color: "9c3b2a",
                realName: "Adib Samoon",
                tzLabel: "Sri Lanka Standard Time",
                tzOffset: 19800,
                profile: {
                    avatarHash: "",
                    statusText: "",
                    statusEmoji: ":)",
                    displayName: "",
                    realNameNormalized: "Adib Samoon",
                    displayNameNormalized: "Adib Samoon",
                    skype: "", 
                    realName: "",
                    phone: "",
                    title: "",
                    fields: ()
                },
                isAdmin: true,
                isOwner: true,
                isPrimaryOwner: true,
                isRestricted: false,
                isUltraRestricted: false,
                has2fa: false
            }
        ]
    };

    # Find a user with an email address
    #
    # + return - Raw JSON mirroring the actual Slack response, so that the data binding is exercised
    resource isolated function get users\.lookupByEmail(string email) returns json => {
        "ok": true,
        "user": {
            "id": "U0123ABCDEF",
            "team_id": "T0123ABCDEF",
            "name": "jdoe",
            "deleted": false,
            "color": "bc3663",
            "real_name": "John Doe",
            "tz": "Asia/Colombo",
            "tz_label": "Sri Lanka Standard Time",
            "tz_offset": 19800,
            "is_admin": true,
            "is_owner": true,
            "is_primary_owner": true,
            "is_restricted": false,
            "is_ultra_restricted": false,
            "is_bot": false,
            "is_app_user": false,
            "updated": 1789995766,
            "is_email_confirmed": true,
            "who_can_share_contact_card": "EVERYONE",
            "profile": {
                "real_name": "John Doe",
                "display_name": "",
                "avatar_hash": "9011c884f4a7",
                "real_name_normalized": "John Doe",
                "display_name_normalized": "",
                "first_name": "John",
                "last_name": "Doe",
                "team": "T0123ABCDEF",
                "email": email,
                "title": "",
                "phone": "",
                "skype": "",
                "status_text": "",
                "status_text_canonical": "",
                "status_emoji": "",
                "status_emoji_display_info": [],
                "status_expiration": 0
            }
        }
    };

    # Gets information about a user
    #
    # + return - Raw JSON mirroring the actual Slack response for the Slackbot user
    resource isolated function get users\.info(string user) returns json => {
        "ok": true,
        "user": {
            "id": user,
            "team_id": "T0123ABCDEF",
            "name": "slackbot",
            "deleted": false,
            "color": "757575",
            "real_name": "Slackbot",
            "tz": "America/Los_Angeles",
            "tz_label": "Pacific Daylight Time",
            "tz_offset": -25200,
            "is_bot": false,
            "is_app_user": false,
            "updated": 0,
            "profile": {
                "real_name": "Slackbot",
                "display_name": "Slackbot",
                "avatar_hash": "sv41d8cd98f0",
                "real_name_normalized": "Slackbot",
                "display_name_normalized": "Slackbot",
                "fields": {},
                "title": "",
                "phone": "",
                "skype": "",
                "status_text": "",
                "status_emoji": ""
            }
        }
    };

    # Get User Profile
    #
    # + return - Get User Profile
    resource isolated function get users\.profile\.get() returns UsersProfileGetResponse => {
        ok: true,
        profile: {
            avatarHash: "",
            displayNameNormalized: "Adib Samoon",
            realName: "Adib Samoon",
            realNameNormalized: "Adib Samoon",
            statusText: "",
            statusEmoji: ":)",
            displayName: "",
            title: "",
            phone: "",
            skype: "",
            fields: [],
            email: "adib@wso2.com"
        }
    };

    # Get Conversation Replies
    #
    # + ts - Timestamp of the parent message, which selects the recorded thread to return
    # + return - A message without replies, a thread started by a user, or a thread posted by an incoming webhook
    resource isolated function get conversations\.replies(string ts) returns json {
        if ts == "1792466505.885929" {
            return {
                "ok": true,
                "messages": [
                    {
                        "user": "U0C3F40S9EG",
                        "type": "message",
                        "ts": "1792466505.885929",
                        "bot_id": "B0C6NHTEXFY",
                        "text": "user thread parent",
                        "team": "T0C39FE0MFG",
                        "thread_ts": "1792466505.885929",
                        "reply_count": 1,
                        "reply_users_count": 1,
                        "latest_reply": "1792466506.732069",
                        "reply_users": ["U0C3F40S9EG"],
                        "is_locked": false,
                        "subscribed": true,
                        "last_read": "1792466506.732069"
                    },
                    {
                        "user": "U0C3F40S9EG",
                        "type": "message",
                        "ts": "1792466506.732069",
                        "bot_id": "B0C6NHTEXFY",
                        "text": "user thread reply",
                        "team": "T0C39FE0MFG",
                        "thread_ts": "1792466505.885929",
                        "parent_user_id": "U0C3F40S9EG"
                    }
                ],
                "has_more": false
            };
        }
        if ts == "1792466432.867219" {
            return {
                "ok": true,
                "messages": [
                    {
                        "subtype": "bot_message",
                        "text": "webhook thread parent",
                        "type": "message",
                        "ts": "1792466432.867219",
                        "bot_id": "B0CA360244X",
                        "thread_ts": "1792466432.867219",
                        "reply_count": 1,
                        "reply_users_count": 1,
                        "latest_reply": "1792466473.227499",
                        "reply_users": ["B0CA360244X"],
                        "is_locked": false,
                        "subscribed": false
                    },
                    {
                        "subtype": "bot_message",
                        "text": "webhook thread reply",
                        "type": "message",
                        "ts": "1792466473.227499",
                        "bot_id": "B0CA360244X",
                        "thread_ts": "1792466432.867219"
                    }
                ],
                "has_more": false
            };
        }
        return {
            "ok": true,
            "messages": [
                {
                    "user": "U0C3F40S9EG",
                    "type": "message",
                    "ts": "1792462400.691309",
                    "bot_id": "B0C6NHTEXFY",
                    "app_id": "A0C7HPSETU0",
                    "text": "A message without replies",
                    "team": "T0C39FE0MFG",
                    "blocks": []
                }
            ],
            "has_more": false
        };
    }

    # Update Message
    #
    # + return - The updated message, with its blocks as an array
    resource isolated function post chat\.update(@http:Payload http:Request request) returns json => {
        "ok": true,
        "channel": "D0C3BBBA890",
        "ts": "1792465147.962269",
        "text": "Edited by the Ballerina connector test <https://ballerina.io>",
        "message": {
            "user": "U0C3F40S9EG",
            "type": "message",
            "edited": {
                "user": "U0C3F40S9EG",
                "ts": "1792465148.000000"
            },
            "bot_id": "B0C6NHTEXFY",
            "app_id": "A0C7HPSETU0",
            "text": "Edited by the Ballerina connector test <https://ballerina.io>",
            "team": "T0C39FE0MFG",
            "blocks": [
                {
                    "type": "rich_text",
                    "block_id": "pCX7",
                    "elements": [
                        {
                            "type": "rich_text_section",
                            "elements": [
                                {
                                    "type": "text",
                                    "text": "Edited by the Ballerina connector test "
                                },
                                {
                                    "type": "link",
                                    "url": "https://ballerina.io"
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    };
};

function init() returns error? {
    if isLiveServer {
        log:printInfo("Skiping mock server initialization as the tests are running on live server");
        return;
    }
    log:printInfo("Initiating mock server");
    check httpListener.attach(mockAPI, "/");
    check httpListener.'start();
}
