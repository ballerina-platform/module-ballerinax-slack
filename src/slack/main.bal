import ballerina/io;

Configuration slackConfig = {
    oAuth2Config: {
        accessToken: "xoxp-943581362995-944917875025-943586035043-3e31c8bb444e3dfc434f684c7bfbe075"
    }
};

public function main() {
    Client slackClient = new(slackConfig);
    ConversationClient conv = slackClient.getConversationsClient();
    ChatClient chat = slackClient.getChatClient();
    FileClient files = slackClient.getFileClient();
    UserClient users = slackClient.getUserClient();
    // string|error channelId = "CU31FE5EC";
    string channelName = "test-slack-connector";
    string[] userName = ["b7a.demo"];
    string userName1 = "b7a.demo";
    // string|error userId = "UTSSZRR0R";
    // if (channelId is string && userId is string) {
    //     var response1 = slackClient->postMessage(channelName, "Hello Channel id");
    //     io:println(response1);
    // }

    // var response1 = slackClient->postMessage("CTEUZ8EE7", "Hello", threadTs = "1581389258.000200");
    // var response1 = chat->updateMessage(channelName, "Hello ooooooooooo", "1581920430.001200");
    // var response2 = slackClient->archiveConversation(channelName);
    // io:println(response1);

    //  var response3 = slackClient->unArchiveConversation(channelName);
    //  io:println(response3);

    //  var response3 = conv->inviteUsersToConversation(channelName, userName);
    //  io:println(response3);

    // var response4 = slackClient->create("newchannel", false);
    // io:println(response4);

    // var response5 = conv->getInfo(channelName);
    // io:println(response5);

    // var response6 = conv->getInfo(channelName);
    // io:println(response6);

    // var response6 = conv->deleteChannel("channel2");
    // io:println(response6);

    var response1 = chat->postMessage(channelName, "Hello");
    io:println(response1);


    // var response6 = conv->joinConversation(channelName);
    // io:println(response6);

    // var response7 = slackClient->removeUserFromConversation(channelName, userName1);
    // io:println(response7);

    // var response8 = user->leaveConversation(channelName);
    // io:println(response8);

    // var response = conv->list();
    // if (response is Conversations) {    
    //     io:println("Conversations " + response);
    // } else {
    //     io:println(response.detail()?.message.toString());
    // }

    // var response8 = users->getUserInfo(userName1);
    // io:println(response8);

    // var response8 = conv->rename("channel2", "channel-2");
    // io:println(response8);

    // var response8 = users->listConversations(noOfItems = 10, types = "public_channel", user = userName1);
    // io:println(response8);

    // var response8 = slackClient->deleteFile("FU8FPV6PJ");
    // io:println(response8);

    // var response = files->getFileInfo("FU9GJ7YV7");
    // io:println(response);

    // var response8 = files->listFiles(tsFrom = "1582003145.000100", channelName = channelName, count = 10, tsTo = "1582881655.015100", user = userName1);
    // io:println(response8);

    // var response = chat->updateMessage(channelName, "chat 123", 1581920430.001200);
    // io:println(response);

    // var response9 = files->uploadFile("/home/bhashinee/Desktop/ipv6", channelName = channelName, title = "ThisIsTheTitle",
    //                                 initialComment = "ThisIsTheInitialComment", threadTs = "1582881139.014500");
    // io:println(response9);

    // string filePath = "/home/bhashinee/Desktop/ipv6";
    // int lastIndex = stringutils:lastIndexOf(filePath, "/");
    // string fileName = filePath.substring(lastIndex+1);
    // io:println(fileName);

}
