import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:knovator_task/widgets/text_widget.dart';
import '../home/post_detail_screen.dart';
import '../models/post_model.dart';

class PostItemWidget extends StatefulWidget {
  final PostModel post;
  const PostItemWidget({super.key, required this.post});

  @override
  _PostItemWidgetState createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  bool isRead = false;
  late Timer timerData;
  late int remainingTime;
  late int timerDuration;

  @override
  void initState() {
    super.initState();
    timerDuration = Random().nextInt(20) + 10;
    remainingTime = timerDuration;

    timerData = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      }
    });
  }

  @override
  void dispose() {
    timerData.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isRead ? Colors.white : Colors.grey[200],
      child: ListTile(
        minVerticalPadding: 25,
        onTap: () {
          setState(() {
            isRead = true; // Mark as read
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailScreen(id: widget.post.id ?? 0),
            ),
          );
        },
        title: TextWidget(text : widget.post.title ?? '', fontSize: 13,fontWeight: FontWeight.bold,),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.timer),
            Text('$remainingTime sec'),
          ],
        ),
      ),
    );
  }
}


