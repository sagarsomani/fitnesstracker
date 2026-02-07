import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/fitness_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  // 1. Add Fitness Record
  Future<void> addFitnessRecord(
    int steps,
    double calories,
    String workout,
  ) async {
    if (uid == null) return;
    await _db.collection('users').doc(uid).collection('fitness').add({
      'steps': steps,
      'calories': calories,
      'workout': workout,
      'date': Timestamp.now(),
    });
  }

  // 2. Update Fitness Record (Requirement: Edit records)
  Future<void> updateFitnessRecord(
    String docId,
    int steps,
    double calories,
    String workout,
  ) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('fitness')
        .doc(docId)
        .update({'steps': steps, 'calories': calories, 'workout': workout});
  }

  // 3. Delete Fitness Record (Requirement: Delete records)
  Future<void> deleteFitnessRecord(String docId) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('fitness')
        .doc(docId)
        .delete();
  }

  // 4. Get Stream of Fitness Records (Requirement: Weekly Summary Logic)
  Stream<List<FitnessRecord>> get fitnessStream {
    return _db
        .collection('users')
        .doc(uid)
        .collection('fitness')
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => FitnessRecord.fromFirestore(doc))
              .toList(),
        );
  }
}
