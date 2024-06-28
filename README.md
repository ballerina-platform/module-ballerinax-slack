Ballerina Slack Connector 
===================

[![Build](https://github.com/ballerina-platform/module-ballerinax-slack/workflows/CI/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-slack/actions?query=workflow%3ACI)
[![codecov](https://codecov.io/gh/ballerina-platform/module-ballerinax-slack/branch/master/graph/badge.svg)](https://codecov.io/gh/ballerina-platform/module-ballerinax-slack)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-slack.svg)](https://github.com/ballerina-platform/module-ballerinax-slack/commits/master)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-slack/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-slack/actions/workflows/build-with-bal-test-graalvm.yml)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

[Slack](https://api.slack.com/) is a channel-based messaging platform. With Slack, people can work together more effectively, connect all their software tools and services, and find the information they need to do their best work — all within a secure, enterprise-grade environment.

This connector allows you to access the Slack Web API and Slack Events API through Ballerina.
It provides the capability to query information from and perform some actions in a Slack workspace.

For more information, go to the modules. 
- [`slack`](slack/Module.md)

## Overview

[Slack](https://slack.com/) is a collaboration platform for teams, offering real-time messaging, file sharing, and integrations with various tools. It helps streamline communication and enhance productivity through organized channels and direct messaging.

## Setup guide

To use the Slack Connector you need to be signed in to [Slack](https://slack.com/)

![Sign In Page](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-slack/master/docs/setup/resources/sign-in.png)

If you haven't created an account already, you can create it [here](https://slack.com/get-started#/createnew)


### Step 1: Create a Slack App 

1. Navigate to Your Apps in [Slack API](https://api.slack.com/) and Create a New Slack App

![Create Slack App](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-slack/master/docs/setup/resources/create-slack-app.png)

2. Provide an App Name and choose a workspace of your choice.

![Create Slack App Popup](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-slack/master/docs/setup/resources/create-slack-app-2.png)

3. Click 'Create App'

### Step 2: Add scopes to the token 

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

Import the `slack` module.

```ballerina
import ballerinax/slack;
```

### Step 2: Instantiate a new connector

Assign the OAuth token obtained to the variable **token**, and then initialize a new instance of the slack client by passing the token.

```ballerina
configurable string token = ?;

public function main() returns error? {

    slack:Client slack = check new({
        auth: {
            token
        }
    });
}
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


## Build from the source

### Prerequisites

1. Download and install Java SE Development Kit (JDK) version 17. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,
    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environment:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contributing to Ballerina
As an open source project, Ballerina welcomes contributions from the community. 

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct
All contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links
* Discuss the code changes of the Ballerina project in [ballerina-dev@googlegroups.com](mailto:ballerina-dev@googlegroups.com).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
