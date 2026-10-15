_Author_: @Chilliwiddit \
_Created_: 2024/06/25 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Slack. The OpenAPI specification is obtained from the [APIs Guru website](https://api.apis.guru/v2/specs/slack.com/1.7.0/openapi.json).
These changes are done in order to improve the overall usability, and to address some known language limitations.

1. Removed the token requirement from the parameter section of each endpoint in which it appeared. Endpoints in which it did not appear are: 
   
    * admin.conversations.restrictAccess.addGroup
    * admin.conversations.restrictAccess.removeGroup
    * admin.emoji.add
    * admin.emoji.addAlias
    * admin.emoji.remove
    * admin.emoji.rename
    * admin.teams.settings.setDefaultChannels
    * admin.teams.settings.setIcon
    * dnd.setSnooze
    * files.remote.add
    * files.remote.remove
    * files.remote.update
    * files.upload
    * oauth.access
    * oauth.token
    * oauth.v2.access
    * users.deletePhoto
    * users.setPhoto

2. Sanitized the inline and component schema names by removing the whitespaces, special characters and, converting them to pascal case.
   * This was done using the `sanitations.bal` script under the `docs/spec` directory.

3. Changed the `UserObj` and `ResponseMetadataObj` schemas under the `components` section from arrays to the `anyOf` of their variants, and removed the `InlineArrayItemsUserObj` and `InlineArrayItemsResponseMetadataObj` schemas. The original specification defines `objs_user` and `objs_response_metadata` with an `items` keyword but no `type`, which resulted in them being treated as arrays, while the Slack API returns a single object.

4. Changed the `tz` property of the `UserObjAnyOf1` and `UserObjUserObjAnyOf12` schemas to a nullable `string`, and removed the `UserObjTz`, `UserObjTz1`, `TzAnyOf1`, `TzTzAnyOf12`, `TzAnyOf11` and `TzTzAnyOf112` schemas. The original specification has the same `items` without `type` issue for `tz`, which resulted in it being treated as an array, while the Slack API returns a time zone string such as `Asia/Colombo`.

5. Changed the `fields` property of the `UserProfileObj` schema to be optional and to accept either an object or an array, as in the original specification. The Slack API omits `fields` for most users and returns it as an object (e.g. `{}`) for others.

6. Changed the `ConversationObj` schema under the `components` section from an array to the `anyOf` of its variants, and removed the `InlineArrayItemsConversationObj` schema. Like the schemas in item 3, the original `objs_conversation` schema has an `items` keyword but no `type`, while the Slack API returns a single conversation object.

7. Changed the `latest` and `parent_conversation` properties of the `ConversationObject`, `ConversationMPIMObject` and `ConversationIMChannelObjectFromConversationsMethods` schemas from arrays to a nullable `MessageObj` and a nullable `ChannelDef` respectively, and removed the `ConversationObjLatest`, `ConversationObjLatest1`, `ConversationObjLatest2`, `ConversationObjParentConversation`, `ConversationObjParentConversation1`, `ConversationObjParentConversation2`, `LatestAnyOf21`, `LatestAnyOf22`, `LatestAnyOf23`, `ParentConversationAnyOf2`, `ParentConversationAnyOf21` and `ParentConversationAnyOf22` schemas. The original specification uses `items` without `type` to express "a value or null" for these properties, which resulted in them being treated as arrays, while the Slack API returns a single value or `null` (e.g. `"parent_conversation": null`).

8. Changed the inline `200` response schemas of `pins.list`, `reactions.get` and `users.identity` from arrays of `InlineResponseItems200`, `InlineResponseItems2001` and `InlineResponseItems2002` to a reference to those schemas directly. Also changed the `channel` property of the `ConversationsOpenResponse` schema from an array to a single `ConversationsOpenResponseChannel`. The original specification uses `items` without `type` for these, while the Slack API returns a single object.

9. Changed the following properties from arrays to a nullable single value, and removed the corresponding wrapper and `null` variant schemas. The original specification uses `items` without `type` to express "a value or null" for these properties.
    * `bot_id` of `MessageObj` (nullable `BotIdDef`)
    * `discoverable` of `TeamObj` (nullable string)
    * `deleted_by` and `auto_type` of `SubteamObj` (nullable `UserIdDef` and nullable string)
    * `options` of `TeamProfileFieldObj` (nullable `TeamProfileFieldOptionObj`)
    * `latest` of `ChannelObj` (nullable `MessageObj`)
    * `channel_actions_ts` of `ConversationsHistoryResponse` (nullable integer)

10. Changed the `messages` property of `ConversationsRepliesResponse`, the `items` property of `ReactionsListResponse` and `StarsListResponse`, and the `ids` and `excluded_ids` properties of `ResourcesObj` from arrays of arrays to arrays. The original specification uses `items` with a list of schemas inside an array, which resulted in a nested array, while the Slack API returns a flat array.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.json --mode client --license docs/license.txt -o ballerina/
```

Note: The license year is hardcoded to 2024, change if necessary.
