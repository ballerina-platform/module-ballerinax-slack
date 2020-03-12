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

const string BASE_URL = "https://slack.com/api";
const string CREATE_CONVERSATION_PATH = "/conversations.create?name=";
const string IS_PRIVATE_CONVERSATION = "&is_private=";
const string LIST_CONVERSATIONS_PATH = "/conversations.list";
const string EMPTY_STRING = "";
const string ARCHIVE_CHANNEL_PATH = "/conversations.archive?channel=";
const string UNARCHIVE_CHANNEL_PATH = "/conversations.unarchive?channel=";
const string FALSE = "false";
const string TRUE = "true";
const string LIST_USERS_PATH = "/users.list";
const string KICK_USER_FROM_CHANNEL_PATH = "/conversations.kick?channel=";
const string USER_ARG = "&user=";
const string INVITE_USERS_TO_CHANNEL_PATH = "/conversations.invite?channel=";
const string USER_IDS_ARG = "&user_ids=";
const string GET_CONVERSATION_INFO_PATH = "/conversations.info?channel=";
const string INCLUDE_LOCALE = "&include_locale=";
const string INCLUDE_NUM_MEMBERS = "&include_num_members=";
const string POST_MESSAGE_PATH = "/chat.postMessage?channel=";
const string UPDATE_MESSAGE_PATH = "/chat.update?channel=";
const string TEXT_TYPE_ARG = "&text=";
const string THREAD_TS_ARG = "&thread_ts=";
const string THREAD_TS_ARG_FOR_UPDATING = "&ts=";
const string CONVERSATIONS_JOIN_PATH = "/conversations.join?channel=";
const string LEAVE_CHANNEL_PATH = "/conversations.leave?channel=";
const string GET_USER_INFO_PATH = "/users.info?&user=";
const string RENAME_CHANNEL_PATH = "/conversations.rename?channel=";
const string NAME_ARG = "&name=";
const string DELETE_CONVERSATION_PATH = "/chat.delete?channel=";
const string DELETE_CONVERSATION_TS_ARG = "&ts=";
const string DELETE_FILE_PATH = "/files.delete?file=";
const string LIST_FILES_PATH = "/files.list";
const string CHANNEL_ARG = "?channel=";
const string QUESTION_MARK = "?";
const string COUNT_AS_FIRST_PARAM = "?count=";
const string COUNT_AS_SECOND_PARAM = "&count=";
const string TS_FROM_AS_FIRST_PARAM = "?ts_from=";
const string TS_FROM_AS_SECOND_PARAM = "&ts_from=";
const string TS_TO_AS_FIRST_PARAM = "?ts_to=";
const string TS_TO_AS_SECOND_PARAM = "&ts_to=";
const string TYPES_AS_FIRST_PARAM = "?types=";
const string TYPES_AS_SECOND_PARAM = "&types=";
const string USER_AS_FIRST_PARAM = "?user=";
const string USER_AS_SECOND_PARAM = "&user=";
const string UPLOAD_FILES_PATH = "/files.upload";
const string LIST_USER_CONVERSATIONS_PATH = "/users.conversations?";
const string CHANNELS_PARAM = "?channels=";
const string TITLE_AS_FIRST_PARAM = "?title=";
const string TITLE_AS_SECOND_PARAM = "&title=";
const string INITIAL_COMMENT_AS_FIRST_PARAM = "?initial_comment=";
const string INITIAL_COMMENT_AS_SECOND_PARAM = "&initial_comment=";
const string THREAD_TS_AS_FIRST_PARAM = "?thread_ts=";
const string THREAD_TS_AS_SECOND_PARAM = "&thread_ts=";
const string FILE = "file";
const string GET_FILE_INFO_PATH = "/files.info?file=";
const string DISPOSITION = "form-data";
const string BACK_SLASH = "/";
const string SLACK_ERROR_CODE = "(ballerinax/slack)SlackError";
const string EXCLUDE_ARCHIVED = "exclude_archived=";
const string LIMIT = "&limit=";
const string TYPES = "types=";