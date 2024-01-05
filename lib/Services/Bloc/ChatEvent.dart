import 'package:feedback_agent/Widgets/ChatWidget.dart';

abstract class ChatEvent {}

class ChatBotInitialEvent extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
  String? message;

  SendMessageEvent(this.message);
}

class TextInputEvent extends ChatEvent {
  var number;

  TextInputEvent({required this.number});
}
