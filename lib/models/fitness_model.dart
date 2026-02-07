import 'package:cloud_firestore/cloud_firestore.dart';

class FitnessRecord {
  final String id;
  final int steps;
  final double calories;
  final String workout;
  final DateTime date;

  FitnessRecord({
    required this.id,
    required this.steps,
    required this.calories,
    required this.workout,
    required this.date,
  });

  // Convert Firebase Document to Dart Object
  factory FitnessRecord.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return FitnessRecord(
      id: doc.id,
      steps: data['steps'] ?? 0,
      calories: (data['calories'] ?? 0).toDouble(),
      workout: data['workout'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  // Convert Dart Object to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'steps': steps,
      'calories': calories,
      'workout': workout,
      'date': Timestamp.fromDate(date),
    };
  }
}
