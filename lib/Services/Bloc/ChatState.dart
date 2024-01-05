import 'package:feedback_agent/Agent/Models/DataModel.dart';

abstract class ChatState {}



class ChatBotInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class InvalidState extends ChatState {}

class ValidState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<DataModel>? chatBotList;

  ChatLoadedState(this.chatBotList);
}

class ChatErrorState extends ChatState {
  final String error;

  ChatErrorState(this.error);
}
