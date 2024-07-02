# Running Tests

There are two test environments for running the Slack connector tests. The default test environment is the mock server for the Slack API. The other test environment is the actual Slack API.

You can run the tests in either of these environments and each has its own compatible set of tests.

| Test Groups | Environment                                     |
| ----------- | ----------------------------------------------- |
| mock_tests  | Mock server for Slack API (Default Environment) |
| live_tests  | Slack API                                       |

## Running Tests in the Mock Server

To execute the tests on the mock server, ensure that the `IS_LIVE_SERVER` environment variable is either set to `false` or unset before initiating the tests.

This environment variable can be configured within the `Config.toml` file located in the tests directory or specified as an environmental variable.

#### Using a Config.toml File

Create a `Config.toml` file in the tests directory and the following content:

```toml
isLiveServer = false
```

#### Using Environment Variables

Alternatively, you can set your authentication credentials as environment variables:

```bash
export IS_LIVE_SERVER=false
```

Then, run the following command to run the tests:

```bash
   ./gradlew clean test
```

## Running Tests Against Slack Live API

#### Using a Config.toml File

Create a `Config.toml` file in the tests directory and add your authentication credentials a

```toml
isTestOnLiveServer = true
token = "<your-slack-token>"
```

#### Using Environment Variables

Alternatively, you can set your authentication credentials as environment variables:

```bash
export IS_LIVE_SERVER=true
export token = "<your-slack-token>"
```

Then, run the following command to run the tests:

```bash
   ./gradlew clean test -Pgroups="live_tests"
```
