## Overview

[Slack](https://slack.com/) is a collaboration platform for teams, offering real-time messaging, file sharing, and integrations with various tools. It helps streamline communication and enhance productivity through organized channels and direct messaging.

## Setup guide

To use the Slack Connector you need to be signed in to [Slack API](https://api.slack.com/)

### Step 1: Create a Slack App 

1. Navigate to Your Apps and Create a New Slack App

![Create Slack App](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-slack/master/docs/setup/resources/create-slack-app.png)

2. Provide an App Name and choose a workspace of your choice.

![Create Slack App Popup](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-slack/master/docs/setup/resources/create-slack-app-2.png)

3. Click 'Create App'

### Step 2: Adding scopes to the token 

1. Once the application is created, go to the "Add Features and Functionality" section and click on "Permissions" to set the token scopes.

![Add Features and Functionality](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-slack/master/docs/setup/resources/add-features.png)

2. In the **User Token Scopes** section set the following token scopes.

![User Token Scopes](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-slack/master/docs/setup/resources/token-permissions.png)

3. Install the application to workspace

![Install to workspace ](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-slack/master/docs/setup/resources/install-workspace.jpg)

4. Copy the OAuth token that is generated upon installation.

![Copy Token](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-slack/master/docs/setup/resources/copy-token.jpg)


## Quickstart

To use the `slack` connector in your Ballerina application, modify the `.bal` file as follows:

### Step 1: Import the module

Import the `slack` module and `ballerina/io`.

```ballerina
import ballerinax/slack;
import ballerina/io;
```

### Step 2: Instantiate a new connector

Assign the OAuth token obtained to the variable **value**. and then initialize a new instance of the slack client by passing the token.

```ballerina
configurable string value = ?;

public function main() returns error? {

    slack:Client cl = check new({
        auth: {
            token: value
        }
    });
}
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### Send a Text Message to General Channel

```ballerina
var t = check cl->/chat\.postMessage.post({ channel : "general", text: "hello" });

    io:print(t);
```

### Step 4: Run the Ballerina application

```bash
bal run
```








