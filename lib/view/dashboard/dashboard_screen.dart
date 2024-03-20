import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meditation/view/dashboard/timer_screen/timer_screen.dart';
class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  Duration _selectedDuration = Duration(minutes: 1); // Default duration is 1 minute

  Future<void> _selectTime(BuildContext context) async {
    Duration? pickedDuration = await showCupertinoDialog<Duration>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Select Duration"),
          content: Container(
            height: 200.0,
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.ms, // Hours and minutes mode
              initialTimerDuration: _selectedDuration,
              onTimerDurationChanged: (Duration newDuration) {
                setState(() {
                  _selectedDuration = newDuration;
                });
              },
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("OK"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx){
                  // Convert minutes to seconds before passing to TimerScreen
                  return TimerScreen(seconds: 00,minutes: _selectedDuration.inMinutes,);
                }));
              },
            ),
          ],
        );
      },
    );

    if (pickedDuration != null) {
      setState(() {
        _selectedDuration = pickedDuration;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meditation Timer"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(

          children: [
            Lottie.asset('assets/lottie/yoga.json'),
            Spacer(),
            Center(
              child: InkWell(
                onTap: (){
                  _selectTime(context);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  alignment: Alignment.center,
                  width: 200,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.rocket_launch),
                      SizedBox(width: 5,),
                      Text("Start Meditating",style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
