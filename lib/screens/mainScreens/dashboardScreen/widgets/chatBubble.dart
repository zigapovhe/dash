import 'package:dash/dtos/chatDto/chatDto.dart';
import 'package:dash/helpers/extensions.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Chat chat;
  final bool sentByMe;
  const ChatBubble({Key? key, required this.chat, required this.sentByMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            mainAxisAlignment: sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: sentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(chat.sender ?? "no name", style: const TextStyle(fontSize: 11, color: Colors.black)),
                  ),
                  Container(
                    width: screenWidth * 0.4,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: sentByMe ? Colors.blueGrey : Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(chat.message, style: const TextStyle(color: Colors.white)),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Text(chat.timestamp.toPrettyHour, style: const TextStyle(fontSize: 11, color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
