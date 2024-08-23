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
            bot_id: [],
            text: "This is a Test",
            team: "T078S42MC59",
            bot_profile: {
                id: "B07986E3N4E",
                app_id: "A079SKHD00Z",
                name: "test-app",
                icons: {
                    image_36: "https://a.slack-edge.com/80588/img/plugins/app/bot_36.png",
                    image_48: "https://a.slack-edge.com/80588/img/plugins/app/bot_48.png",
                    image_72: "https://a.slack-edge.com/80588/img/plugins/app/service_72.png"
                },
                deleted: false,
                updated: 1719218992,
                team_id: "T078S42MC59"
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
        members: [
            [
                {
                    "id": "USLACKBOT",
                    "team_id": "T078S42MC59",
                    "name": "slackbot",
                    "deleted": false,
                    "color": "757575",
                    "real_name": "Slackbot",
                    "tz": "America/Los_Angeles",
                    "tz_label": "Pacific Daylight Time",
                    "tz_offset": -25200,
                    "profile": {
                        "title": "",
                        "phone": "",
                        "skype": "",
                        "real_name": "Slackbot",
                        "real_name_normalized": "Slackbot",
                        "display_name": "Slackbot",
                        "display_name_normalized": "Slackbot",
                        "fields": {},
                        "status_text": "",
                        "status_emoji": "",
                        "status_emoji_display_info": [],
                        "status_expiration": 0,
                        "avatar_hash": "sv41d8cd98f0",
                        "always_active": true,
                        "first_name": "slackbot",
                        "last_name": "",
                        "image_24": "https://a.slack-edge.com/80588/img/slackbot_24.png",
                        "image_32": "https://a.slack-edge.com/80588/img/slackbot_32.png",
                        "image_48": "https://a.slack-edge.com/80588/img/slackbot_48.png",
                        "image_72": "https://a.slack-edge.com/80588/img/slackbot_72.png",
                        "image_192": "https://a.slack-edge.com/80588/marketing/img/avatars/slackbot/avatar-slackbot.png",
                        "image_512": "https://a.slack-edge.com/80588/img/slackbot_512.png",
                        "status_text_canonical": "",
                        "team": "T078S42MC59"
                    },
                    "is_admin": false,
                    "is_owner": false,
                    "is_primary_owner": false,
                    "is_restricted": false,
                    "is_ultra_restricted": false,
                    "is_bot": false,
                    "is_app_user": false,
                    "updated": 0,
                    "is_email_confirmed": false,
                    "who_can_share_contact_card": "EVERYONE"
                },
                {
                    "id": "U078KJ7RX1U",
                    "team_id": "T078S42MC59",
                    "name": "adib",
                    "deleted": false,
                    "color": "9f69e7",
                    "real_name": "Adib Samoon",
                    "tz": "Asia/Colombo",
                    "tz_label": "Sri Lanka Standard Time",
                    "tz_offset": 19800,
                    "profile": {
                        "title": "",
                        "phone": "",
                        "skype": "",
                        "real_name": "Adib Samoon",
                        "real_name_normalized": "Adib Samoon",
                        "display_name": "Adib Samoon",
                        "display_name_normalized": "Adib Samoon",
                        "fields": null,
                        "status_text": "",
                        "status_emoji": "",
                        "status_emoji_display_info": [],
                        "status_expiration": 0,
                        "avatar_hash": "g22cb1d82fff",
                        "email": "adib@wso2.com",
                        "first_name": "Adib",
                        "last_name": "Samoon",
                        "image_24": "https://secure.gravatar.com/avatar/22cb1d82fffbdffa0fb80651f9afbb5a.jpg?s=24&d=https%3A%2F%2Fa.slack-edge.com%2Fdf10d%2Fimg%2Favatars%2Fava_0025-24.png",
                        "image_32": "https://secure.gravatar.com/avatar/22cb1d82fffbdffa0fb80651f9afbb5a.jpg?s=32&d=https%3A%2F%2Fa.slack-edge.com%2Fdf10d%2Fimg%2Favatars%2Fava_0025-32.png",
                        "image_48": "https://secure.gravatar.com/avatar/22cb1d82fffbdffa0fb80651f9afbb5a.jpg?s=48&d=https%3A%2F%2Fa.slack-edge.com%2Fdf10d%2Fimg%2Favatars%2Fava_0025-48.png",
                        "image_72": "https://secure.gravatar.com/avatar/22cb1d82fffbdffa0fb80651f9afbb5a.jpg?s=72&d=https%3A%2F%2Fa.slack-edge.com%2Fdf10d%2Fimg%2Favatars%2Fava_0025-72.png",
                        "image_192": "https://secure.gravatar.com/avatar/22cb1d82fffbdffa0fb80651f9afbb5a.jpg?s=192&d=https%3A%2F%2Fa.slack-edge.com%2Fdf10d%2Fimg%2Favatars%2Fava_0025-192.png",
                        "image_512": "https://secure.gravatar.com/avatar/22cb1d82fffbdffa0fb80651f9afbb5a.jpg?s=512&d=https%3A%2F%2Fa.slack-edge.com%2Fdf10d%2Fimg%2Favatars%2Fava_0025-512.png",
                        "status_text_canonical": "",
                        "team": "T078S42MC59"
                    },
                    "is_admin": true,
                    "is_owner": true,
                    "is_primary_owner": true,
                    "is_restricted": false,
                    "is_ultra_restricted": false,
                    "is_bot": false,
                    "is_app_user": false,
                    "updated": 1718859479,
                    "is_email_confirmed": true,
                    "has_2fa": false,
                    "who_can_share_contact_card": "EVERYONE"
                }
            ]
        ],
        cache_ts: 1719830510,
        response_metadata: [
            {
                next_cursor: ""
            }
        ]
    };

    # Get User Profile
    #
    # + return - Get User Profile
    resource isolated function get users\.profile\.get() returns UsersProfileGetResponse => {
        ok: true,
        profile: {
            title: "",
            phone: "",
            skype: "",
            real_name: "Adib Samoon",
            real_name_normalized: "Adib Samoon",
            display_name: "Adib Samoon",
            display_name_normalized: "Adib Samoon",
            fields: [],
            status_text: "",
            status_emoji: "",
            status_expiration: 0,
            avatar_hash: "g22cb1d82fff",
            email: "adib@wso2.com",
            first_name: "Adib",
            last_name: "Samoon",
            image_24: "https://secure.gravatar.com/avatar/22cb1d82fffbdffa0fb80651f9afbb5a.jpg?s=24&d=https%3A%2F%2Fa.slack-edge.com%2Fdf10d%2Fimg%2Favatars%2Fava_0025-24.png",
            image_32: "https://secure.gravatar.com/avatar/22cb1d82fffbdffa0fb80651f9afbb5a.jpg?s=32&d=https%3A%2F%2Fa.slack-edge.com%2Fdf10d%2Fimg%2Favatars%2Fava_0025-32.png",
            image_48: "https://secure.gravatar.com/avatar/22cb1d82fffbdffa0fb80651f9afbb5a.jpg?s=48&d=https%3A%2F%2Fa.slack-edge.com%2Fdf10d%2Fimg%2Favatars%2Fava_0025-48.png",
            image_72: "https://secure.gravatar.com/avatar/22cb1d82fffbdffa0fb80651f9afbb5a.jpg?s=72&d=https%3A%2F%2Fa.slack-edge.com%2Fdf10d%2Fimg%2Favatars%2Fava_0025-72.png",
            image_192: "https://secure.gravatar.com/avatar/22cb1d82fffbdffa0fb80651f9afbb5a.jpg?s=192&d=https%3A%2F%2Fa.slack-edge.com%2Fdf10d%2Fimg%2Favatars%2Fava_0025-192.png",
            image_512: "https://secure.gravatar.com/avatar/22cb1d82fffbdffa0fb80651f9afbb5a.jpg?s=512&d=https%3A%2F%2Fa.slack-edge.com%2Fdf10d%2Fimg%2Favatars%2Fava_0025-512.png",
            status_text_canonical: ""
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
