import 'package:flutter/material.dart';

enum MessageType {
  user,
  bot,
}

class ChatMessage {
  final String message;
  final MessageType type;

  ChatMessage(this.message, this.type);
}

class ChatWidget extends StatelessWidget {
  final ChatMessage message;

  const ChatWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: message.type == MessageType.bot
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          if (message.type == MessageType.bot) ...[
            CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/chatBot.png',
                  height: 30,
                  width: 30,
                )),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              width: message.type == MessageType.bot
                  ? MediaQuery.of(context).size.width / 2.5
                  : MediaQuery.of(context).size.width / 49,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: message.type == MessageType.bot
                    ? const Color(0xffE9ECF4)
                    : const Color(0xffE7E7E9),
                borderRadius: message.type == MessageType.bot
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8))
                    : const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
              ),
              child: Text(
                message.message,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w200),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
