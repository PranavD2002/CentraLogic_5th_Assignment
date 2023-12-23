import 'dart:convert';

import 'package:feedback_agent/Agent/Models/DataModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatMessageWidget extends StatelessWidget {
  final String message;

  const ChatMessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isBotMessage = message.startsWith('Bot:');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
        isBotMessage ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isBotMessage) ...[
            CircleAvatar(
              child: Icon(Icons.android),
            ),
            SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isBotMessage ? Colors.blue : Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



//
// class ChatWidget extends StatelessWidget {
//   const ChatWidget({super.key, required this.message, required this.sender});
//
//   final String message;
//   final String sender;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Align(
//             alignment:
//                 sender == "user" ? Alignment.centerRight : Alignment.centerLeft,
//             child: Row(
//               // crossAxisAlignment: sender=='user'?CrossAxisAlignment.end:CrossAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   "assets/chatBot.png",
//                   height: 30,
//                   width: 30,
//                 ),
//                 const SizedBox(
//                   width: 15,
//                 ),
//                 Expanded(
//                   child: Container(
//                     color: const Color(0xffE7E7E9),
//                     child: Text(
//                       message,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w200,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
// void _forBot(String botMsg){
//   Row(
//     // crossAxisAlignment: sender=='user'?CrossAxisAlignment.end:CrossAxisAlignment.center,
//     children: [
//       Image.asset(
//         "assets/chatBot.png",
//         height: 30,
//         width: 30,
//       ),
//       const SizedBox(
//         width: 15,
//       ),
//       Expanded(
//         child: Container(
//           color: const Color(0xffE7E7E9),
//           child: Text(
//             botMsg,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w200,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       )
//     ],
//   );
// }
// void _forUser(String userMsg) {
//   Row(children: [
//     Expanded(
//       child: Container(
//         color: const Color(0xffE7E7E9),
//         child: Text(
//           userMsg,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w200,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     )
//   ]);
// }
