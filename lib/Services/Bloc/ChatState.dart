abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<String> messages;

  ChatLoadedState(this.messages);
}

class ChatErrorState extends ChatState {
  final String error;

  ChatErrorState(this.error);
}