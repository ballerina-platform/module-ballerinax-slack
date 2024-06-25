@@ -0,0 +1,24 @@
_Author_: @Chilliwiddit \
_Created_: 2024/06/25 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Slack. The OpenAPI specification is obtained from the [APIs Guru website](https://api.apis.guru/v2/specs/slack.com/1.7.0/openapi.json).
The following changes were made so as to prevent api methods demanding a token being passed as a method parameter.

1. Remove the token requirement from the parameter section of each endpoint in which it appeared. Endpoints in which it did not appear are:-
        
        admin.conversations.restrictAccess.addGroup
        admin.conversations.restrictAccess.removeGroup
        admin.emoji.add
        admin.emoji.addAlias
        admin.emoji.remove
        admin.emoji.rename
        admin.teams.settings.setDefaultChannels
        admin.teams.settings.setIcon
        dnd.setSnooze
        files.remote.add
        files.remote.remove
        files.remote.update
        files.upload
        oauth.access
        oauth.token
        oauth.v2.access
        users.deletePhoto
        users.setPhoto

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository '/ballerina' directory.

```bash
bal openapi -i ..\docs\spec\openapi.json --mode client --license ..\docs\license.txt
```