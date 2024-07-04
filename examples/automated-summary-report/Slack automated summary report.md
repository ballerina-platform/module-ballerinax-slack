# Automated summary report

This use case demonstrates how the Slack API can be utilized to generate a summarized report of daily stand up chats in the general channel.

## Prerequisites

1. Generate a Slack token to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/slack/latest#prerequisites).

2. For each example, create a `Config.toml` file with the related configuration. Here's an example of what your `Config.toml` file should look:

   ```toml
   token = "<token>"
   ```

## Run the example

Execute the following command to run the example:

```ballerina
bal run
```