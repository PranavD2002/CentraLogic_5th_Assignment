// import 'package:feedback_agent/Services/Bloc/ChatBloc.dart';
// import 'package:feedback_agent/Services/Bloc/ChatEvent.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class ChatInputWidget extends StatelessWidget {
//   final TextEditingController _textController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final chatBloc = BlocProvider.of<ChatBloc>(context);
//
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _textController,
//               decoration: InputDecoration(
//                 hintText: 'Type your answer...',
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             onPressed: () {
//               final userMessage = _textController.text.trim();
//               if (userMessage.isNotEmpty) {
//                 chatBloc.add(SendMessageEvent(userMessage));
//                 _textController.clear();
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }