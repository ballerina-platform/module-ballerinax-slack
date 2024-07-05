## Overview

[Slack](https://slack.com/) is a collaboration platform for teams, offering real-time messaging, file sharing, and integrations with various tools. It helps streamline communication and enhance productivity through organized channels and direct messaging.

## Setup guide

To use the Slack Connector you need to be signed in to [Slack](https://slack.com/).

<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-slack/master/docs/setup/resources/sign-in.png alt="Sign-In Page" style="width: 70%;">

If you haven't created an account already, you can create it [here](https://slack.com/get-started#/createnew).

### Step 1: Create a new Slack application 

1. Navigate to your apps in [Slack API](https://api.slack.com/) and create a new Slack app.

<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-slack/master/docs/setup/resources/create-slack-app.png alt="Create Slack App" style="width: 70%;">

2. Provide an app name and choose a workspace of your choice.

<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-slack/master/docs/setup/resources/create-slack-app-2.png alt="Create Slack App Popup" style="width: 70%;">

3. Click on the "Create App" button.

### Step 2: Add scopes to the token 

1. Once the application is created, go to the "Add Features and Functionality" section and click on "Permissions" to set the token scopes.

<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-slack/master/docs/setup/resources/add-features.png alt="Add features and functionality" style="width: 70%;">

2. In the **User Token Scopes** section set the following token scopes.

<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-slack/master/docs/setup/resources/token-permissions.png alt="User Token Scopes" style="width: 70%;">

3. Install the application to workspace.

<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-slack/master/docs/setup/resources/install-workspace.jpg alt="Install to workspace" style="width: 70%;">

4. Copy the OAuth token that is generated upon installation.

<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-slack/master/docs/setup/resources/copy-token.jpg alt="Copy token" style="width: 70%;">


## Quickstart

To use the `slack` connector in your Ballerina application, modify the `.bal` file as follows:

### Step 1: Import the module

Import the `slack` module.

```ballerina
import ballerinax/slack;
```

### Step 2: Instantiate a new connector

Assign the OAuth token obtained to the variable **token**, and then initialize a new instance of the slack client by passing the token.

```ballerina
configurable string token = ?;

slack:Client slack = check new({
    auth: {
        token
    }
});
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### Send a Text Message to General Channel

```ballerina
json postMessageResponse = check slack->/chat\.postMessage.post({channel: "general", text: "hello"});
```

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `Slack` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-slack/tree/master/examples), covering the following use cases:

1. [Automated Survey Report](https://github.com/ballerina-platform/module-ballerinax-slack/tree/master/examples/automated-survey-report) - This use case demonstrates how the Slack API can be utilized to generate a summarized report of daily stand up chats in the general channel.

2. [Survey Feedback Analysis](https://github.com/ballerina-platform/module-ballerinax-slack/tree/master/examples/survey-feedback-analysis) - This use case demonstrates how the Slack API can be utilized to perform a company-wide survey by creating a dedicated channel to receive and track feedback replies.