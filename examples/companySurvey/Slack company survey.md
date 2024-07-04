# Slack Company Survey

This use case demonstrates how the Slack API can be utilized to perform a company-wide survey by creating a dedicated channel to receive and track feedback replies.

## Prerequisites

### 1. Setup Slack account

Generate Slack token to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/slack/latest#prerequisites).

### 2. Configuration

Update your Slack account related configurations in the `Config.toml` file in the example root directory:

```toml
token = "<token>"
```

## Run the example

Execute the following command to run the example:

```ballerina
bal run
```
