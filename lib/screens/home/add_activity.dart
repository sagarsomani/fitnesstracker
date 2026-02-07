import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _stepsController = TextEditingController();
  final _calController = TextEditingController();
  String _selectedWorkout = 'Running'; // Default value

  final List<String> _workouts = [
    'Running',
    'Walking',
    'Cycling',
    'Gym',
    'Yoga',
  ];

  Future _saveActivity() async {
    // Basic Validation
    if (_stepsController.text.isEmpty || _calController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      // Saving to the sub-collection: users -> userId -> fitness
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('fitness')
          .add({
            'steps': int.parse(_stepsController.text),
            'calories': double.parse(_calController.text),
            'workout': _selectedWorkout,
            'date': Timestamp.now(), // Requirement: date format
          });

      if (!mounted) return;
      Navigator.pop(context); // Go back to Dashboard
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Log Activity")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Workout Type",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _selectedWorkout,
              isExpanded: true,
              items: _workouts.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() => _selectedWorkout = newValue!);
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _stepsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Steps Taken",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _calController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Calories Burned",
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: _saveActivity,
                child: const Text(
                  "SAVE ACTIVITY",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
