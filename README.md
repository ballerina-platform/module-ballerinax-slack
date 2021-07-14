Ballerina Slack Connector 
===================

[![Build](https://github.com/ballerina-platform/module-ballerinax-slack/workflows/CI/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-slack/actions?query=workflow%3ACI)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-slack.svg)](https://github.com/ballerina-platform/module-ballerinax-slack/commits/master)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This is a [Ballerina](https://ballerina.io/) connector for Slack.

[Slack](https://api.slack.com/) is a channel-based messaging platform. With Slack, people can work together more effectively, connect all their software tools and services, and find the information they need to do their best work — all within a secure, enterprise-grade environment.

This connector allows you to access the Slack Web API and Slack Events API through Ballerina. This 
connector can be used to implement some of the most common use cases of Slack. This connector provides the capability
to query information from and perform some actions in a Slack workspace. This connector also allows you to listen to
Slack Events.

For more information about configuration and operations, go to the modules. 
- [`slack`](https://docs.central.ballerina.io/ballerinax/microsoft.excel/1.0.0).
- [`slack.listener`](https://docs.central.ballerina.io/ballerinax/slack.listener/1.0.0).

## Building from the Source

### Setting Up the Prerequisites

1. Download and install Java SE Development Kit (JDK) version 11 (from one of the following locations).

   * [Oracle](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)

   * [OpenJDK](https://adoptopenjdk.net/)

        > **Note:** Set the JAVA_HOME environment variable to the path name of the directory into which you installed JDK.

2. Download and install [Ballerina Swan Lake Beta2](https://ballerina.io/). 

### Building the Source

Execute the commands below to build from the source.

1. Gradle build
```shell script
    ./gradlew build
```

2. To build the ballerina package:
```shell script
    bal build -c ./slack
```

3. To build the ballerina package without the tests:
```shell script
    bal build --skip-tests ./slack
```

## Contributing to Ballerina
As an open source project, Ballerina welcomes contributions from the community. 

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of Conduct
All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful Links
* Discuss the code changes of the Ballerina project in [ballerina-dev@googlegroups.com](mailto:ballerina-dev@googlegroups.com).
* Chat live with us via our [Slack channel](https://ballerina.io/community/slack/).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
