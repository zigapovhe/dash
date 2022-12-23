import 'package:dash/enums/ReadStatusEnum.dart';
import 'package:dash/helpers/colors.dart';
import 'package:flutter/material.dart';

class ChatBanner extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final String image;
  final ReadStatusEnum readStatus;
  const ChatBanner({Key? key, required this.name, required this.lastMessage, required this.time, required this.image, required this.readStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget indicator;
     if(readStatus == ReadStatusEnum.newMessage){
      indicator = Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle
        ),
      );
    } else if (readStatus == ReadStatusEnum.read){
      indicator = const Icon(Icons.done_all, color: Colors.green, size: 18,);
    } else if (readStatus == ReadStatusEnum.delivered){
       indicator = const Icon(Icons.done, color: Colors.grey, size: 18,);
    } else {
      indicator = const SizedBox();
     }

    return ListTile(
      leading: ClipOval(
        //Oval avatar
        child: Material(
          color: ColorsHelper.accent.withOpacity(0.5), // button color
          child: const SizedBox(width: 50, height: 50, child: Icon(Icons.person, color: Colors.white,)),
        ),
      ),
      title: Text(name, style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      subtitle: Text(lastMessage, style: const TextStyle(color: Colors.grey, fontSize: 15)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: const TextStyle(color: Colors.grey, fontSize: 15)),
          const SizedBox(height: 5),
          indicator
        ],
      ),
    );
  }
}
