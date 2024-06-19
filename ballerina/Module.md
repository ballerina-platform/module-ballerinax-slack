## Overview

[Slack](https://blog.google/products/gmail/) is a collaboration platform for teams, offering real-time messaging, file sharing, and integrations with various tools. It helps streamline communication and enhance productivity through organized channels and direct messaging.

The `ballerinax/slack` package offers APIs to connect and interact with [Slack API](https://developers.google.com/gmail/api/guides) endpoints, specifically based on [Gmail API v1](https://gmail.googleapis.com/$discovery/rest?version=v1).

## Setup guide

To use the Gmail connector, you must have access to the Gmail REST API through a [Google Cloud Platform (GCP)](https://console.cloud.google.com/) account and a project under it. If you do not have a GCP account, you can sign up for one [here](https://cloud.google.com/).

### Step 1: Create a Google Cloud Platform project

1. Open the [Google Cloud Platform Console](https://console.cloud.google.com/).

2. Click on the project drop-down menu and select an existing project or create a new one for which you want to add an API key.

    ![GCP Console Project View](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-googleapis.gmail/master/docs/setup/resources/gcp-console-project-view.png)

### Step 2: Enable Gmail API

1. Navigate to the **Library** tab and enable the Gmail API.

    ![Enable Gmail API](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-googleapis.gmail/master/docs/setup/resources/enable-gmail-api.png)

### Step 3: Configure OAuth consent

1. Click on the **OAuth consent screen** tab in the Google Cloud Platform console.

    ![Consent Screen](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-googleapis.gmail/master/docs/setup/resources/consent-screen.png)

2. Provide a name for the consent application and save your changes.

### Step 4: Create OAuth client

1. Navigate to the **Credentials** tab in your Google Cloud Platform console.

2. Click on **Create credentials** and select **OAuth client ID** from the dropdown menu.

    ![Create Credentials](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-googleapis.gmail/master/docs/setup/resources/create-credentials.png)

3. You will be directed to the **Create OAuth client ID** screen, where you need to fill in the necessary information as follows:

    | Field                    | Value                |
    | ------------------------ | -------------------- |
    | Application type         | Web Application      |
    | Name                     | GmailConnector       |
    | Authorized Redirect URIs | https://developers.google.com/oauthplayground |

4. After filling in these details, click on **Create**.

5. Make sure to save the provided Client ID and Client secret.