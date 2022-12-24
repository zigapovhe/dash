import 'package:dash/enums/ReadStatusEnum.dart';
import 'package:dash/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class ChatBanner extends StatelessWidget {
  final String name;
  final String lastMessage;
  final DateTime time;
  final ReadStatusEnum readStatus;
  final Function()? onTap;

  const ChatBanner(
      {Key? key,
      required this.name,
      required this.lastMessage,
      required this.time,
      required this.readStatus,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String abbreviation;

    if(name.contains(" ")){
      final List<String> split = name.split(" ");
      abbreviation = split[0][0] + split[1][0];
    } else {
      if(name.length > 2){
        abbreviation = name.substring(0, 2);
      } else {
        abbreviation = name;
      }
    }


    String timeString;
    DateTime now = DateTime.now();
    if(time.year == now.year && time.month == now.month && time.day == now.day){
      timeString = "${time.hour}:${time.minute}";
    } else if (time.year == now.year){
      timeString = "${time.day}.${time.month}";
    } else {
      timeString = "${time.day}.${time.month}.${time.year}";
    }

    Widget indicator;
    if (readStatus == ReadStatusEnum.newMessage) {
      indicator = Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
            color: Colors.redAccent, shape: BoxShape.circle),
      );
    } else if (readStatus == ReadStatusEnum.read) {
      indicator = const Icon(
        Icons.done_all,
        color: Colors.green,
        size: 18,
      );
    } else if (readStatus == ReadStatusEnum.delivered) {
      indicator = const Icon(
        Icons.done,
        color: Colors.grey,
        size: 18,
      );
    } else {
      indicator = const SizedBox();
    }

    return InkWell(
        onTap: onTap,
        splashColor: ColorsHelper.accent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          decoration: BoxDecoration(
            //color: ColorsHelper.accent.withOpacity(0.37),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SwipeableTile(
              color: ColorsHelper.background,
              swipeThreshold: 0.2,
              direction: SwipeDirection.horizontal,
              onSwiped: (direction) {
                // Here call setState to update state
              },
              backgroundBuilder: (context, direction, progress) {
                if (direction == SwipeDirection.endToStart) {
                  return Container(color: Colors.red);
                } else if (direction == SwipeDirection.startToEnd) {
                  return Container(color: Colors.blue);
                }
                return Container();
              },
              key: UniqueKey(),
              child: ListTile(
                leading: ClipOval(
                  child: Material(
                    color: ColorsHelper.accent.withOpacity(0.5), // button color
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Center(child: Text(abbreviation, style: const TextStyle(color: Colors.white, fontSize: 18),))),
                  ),
                ),
                title: Text(name, style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: Text(lastMessage, style: const TextStyle(color: Colors.grey, fontSize: 15)),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(timeString, style: const TextStyle(color: Colors.grey, fontSize: 15)),
                    const SizedBox(height: 5),
                    indicator
                  ],
                ),
              ) // Here Tile which will be shown at the top
              ),
        ));
  }
}
