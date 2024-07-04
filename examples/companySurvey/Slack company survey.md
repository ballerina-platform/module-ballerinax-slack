# Slack company survey feedback

This use case demonstrates how the Slack API can be utilized to perform a company-wide survey by creating a dedicated channel to receive and track feedback replies.

## Prerequisites

### 1. Setup Slack account

Generate Slack token to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/slack/latest#prerequisites).

### 2. Configuration

Create a `Config.toml` file in the example root directory, and update your Slack account token as follows:

```toml
token = "<token>"
```

## Run the example

Execute the following command to run the example:

```ballerina
bal run
```
