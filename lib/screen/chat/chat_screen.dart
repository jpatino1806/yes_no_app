import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_providers.dart';
import 'package:yes_no_app/presentation/widget/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widget/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widget/share/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(3.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://media.vogue.mx/photos/6419da908041e1cc9fc61b73/master/pass/GettyImages-1474006521.jpg'),
          ),
        ),
        //centerTitle: true,
        title: const Text('Mi amor ╔╦╦╦╗'),
      ),
      body: const _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatProviders = context.watch<ChatProviders>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              controller: chatProviders.chatScrollController,
              itemCount: chatProviders.messageList.length,
              itemBuilder: (BuildContext context, int index) {
                final message = chatProviders.messageList[index];
                return (message.fromWho == FromWho.her)
                    ? HerMessageBubble(
                        message: message,
                      )
                    : MyMessageBubble(
                        message: message,
                      );
              },
            )),
            //caja de texto de mensajes
            MessageFieldBox(onValue: chatProviders.sendMessage),
          ],
        ),
      ),
    );
  }
}
