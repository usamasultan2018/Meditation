import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StatsController extends ChangeNotifier {
  int _currentStreak = 0;
  int _totalSessions = 0;
  int _maxStreak = 0;
  double _averageSessionDuration = 0.0;

  int get currentStreak => _currentStreak;
  int get totalSessions => _totalSessions;
  int get maxStreak => _maxStreak;
  double get averageSessionDuration => _averageSessionDuration;

  // Method to fetch statistics from Firestore
  Future<void> fetchStats() async {
    var auth = FirebaseAuth.instance;
    try {
      // Fetch session logs from Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(auth.currentUser!.uid)
          .collection("session")
          .orderBy("date", descending: true)
          .get();

      List<QueryDocumentSnapshot> sessions = querySnapshot.docs;
      _totalSessions = sessions.length;

      // Calculate current streak, max streak, and average session duration
      _calculateCurrentStreak(sessions);
      _calculateMaxStreak(sessions);
      _calculateAverageSessionDuration(sessions);

      // Notify listeners of the change in state
      notifyListeners();
    } catch (error) {
      print("Error fetching stats: $error");
    }
  }

  // Method to calculate current streak
  void _calculateCurrentStreak(List<QueryDocumentSnapshot> sessions) {
    // Implementation remains the same as before
  }

  // Method to calculate max streak
  void _calculateMaxStreak(List<QueryDocumentSnapshot> sessions) {
    // Implementation to calculate max streak
    _maxStreak = 0;
    int currentStreak = 0;
    DateTime? lastDate;

    for (var session in sessions) {
      DateTime sessionDate = (session.data() as Map<String, dynamic>)['date'].toDate();
      if (lastDate == null || _isConsecutiveDays(sessionDate, lastDate)) {
        currentStreak++;
        _maxStreak = currentStreak > _maxStreak ? currentStreak : _maxStreak;
      } else {
        currentStreak = 1; // Reset streak if not consecutive
      }
      lastDate = sessionDate;
    }
  }

  // Method to calculate average session duration
  void _calculateAverageSessionDuration(List<QueryDocumentSnapshot> sessions) {
    if (sessions.isEmpty) {
      _averageSessionDuration = 0.0;
      return;
    }

    int totalDurationMinutes = 0; // Change variable name to reflect duration in minutes
    for (var session in sessions) {
      String timeSpent = (session.data() as Map<String, dynamic>)['timeSpent'];
      List<String> timeParts = timeSpent.split(':');
      int hours = int.parse(timeParts[0]);
      int minutes = int.parse(timeParts[1]);
      totalDurationMinutes += (hours * 60) + minutes; // Accumulate total duration in minutes
    }

    _averageSessionDuration = totalDurationMinutes / sessions.length;
  }

  String formatDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    int minutes = duration.inMinutes;
    return '$minutes minutes';
  }
  String get formattedAverageSessionDuration => formatDuration(_averageSessionDuration.round());



  // Function to check if two dates are consecutive days
  bool _isConsecutiveDays(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day - date2.day == 1;
  }
}
