import 'package:flutter/material.dart';
import 'package:yes_no_app/config/theme/helpers/get_yes_no_ansewr.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProviders extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    Message(text: 'Hola preciosa', fromWho: FromWho.me),
    Message(text: 'que tal te fue en el trabajo', fromWho: FromWho.me),
    Message(text: 'quieres cenar conmigo, hoy ?', fromWho: FromWho.me)
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);

    if (text.endsWith('?')) {
      herReplay();
    }
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> herReplay() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messageList.add(herMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  void moveScrollToBottom() {
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }
}
