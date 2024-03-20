import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class TimerScreen extends StatefulWidget {
  final int minutes;
  final int seconds;

  const TimerScreen({Key? key, required this.minutes, required this.seconds})
      : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late int currentMinutes;
  late int currentSeconds;
  late Timer timer;
  late int totalTimeInSeconds;

  @override
  void initState() {
    super.initState();
    currentMinutes = widget.minutes;
    currentSeconds = widget.seconds;
    totalTimeInSeconds = (widget.minutes * 60) + widget.seconds;

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (currentSeconds == 0) {
          if (currentMinutes == 0) {
            t.cancel(); // Stop the timer when both minutes and seconds reach 0
            // You can perform any action here when the timer finishes
          } else {
            currentMinutes--;
            currentSeconds = 59;
          }
        } else {
          currentSeconds--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Meditation Timer'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Center(
                child: Text(
                  '${currentMinutes.toString().padLeft(2, '0')}:${currentSeconds.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: Colors.lightGreenAccent,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  // Calculate time spent
                  int timeSpentInSeconds = totalTimeInSeconds -
                      ((currentMinutes * 60) + currentSeconds);
                  int spentMinutes = timeSpentInSeconds ~/ 60;
                  int spentSeconds = timeSpentInSeconds % 60;

                  String spentTime =
                      '${spentMinutes.toString().padLeft(2, '0')}:${spentSeconds.toString().padLeft(2, '0')}';
                  print('Time spent: $spentTime');

                  timer.cancel();
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(auth.currentUser!.uid)
                      .collection("session")
                      .add({
                    'date':DateTime.now(),
                     'timeSpent':spentTime,
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Finish",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }
}
