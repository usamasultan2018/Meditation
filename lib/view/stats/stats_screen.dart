import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meditation/view/stats/widget/stats_container.dart';
import 'package:provider/provider.dart';

import '../../view_model/controller/stats/stats_controller.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    final statsController =
        Provider.of<StatsController>(context, listen: false);
    statsController.fetchStats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text("Stats Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Consumer<StatsController>(
                      builder: (context, statsController, _) {
                        return StatsContainer(
                            title: "Current Streaks",
                            subTitle: statsController.currentStreak.toString());
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Consumer<StatsController>(
                      builder: (context, statsController, _) {
                        return StatsContainer(
                            title: "Max Streaks",
                            subTitle: statsController.maxStreak.toString());
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Consumer<StatsController>(
                      builder: (context, statsController, _) {
                        return StatsContainer(
                            title: "Total Sessions",
                            subTitle: statsController.totalSessions.toString());
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Consumer<StatsController>(
                      builder: (context, statsController, _) {
                        return StatsContainer(
                            title: "Average Sessions",
                            subTitle: statsController.averageSessionDuration
                                .toString());
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
                height: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Session Log",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Consumer<StatsController>(
                    builder: (context, statsController, _) {
                      return  Text(
                        "${statsController.totalSessions} session",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(auth.currentUser!.uid)
                    .collection("session")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.data == null ||
                      snapshot.data!.docs.isEmpty) {
                    return const Text("No sessions logged yet.");
                  } else {
                    List<QueryDocumentSnapshot<Map<String, dynamic>>> allData =
                        snapshot.data!.docs;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: allData.length,
                        itemBuilder: (context, index) {
                          var data = allData[index];
                          Timestamp sessionTimestamp =
                              data['date'] as Timestamp;
                          DateTime sessionDate = sessionTimestamp.toDate();
                          String formattedDate = formatDate(sessionDate);
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey, width: 2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(formattedDate),
                                Text(data['timeSpent']),
                              ],
                            ),
                          );
                        });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }
}
