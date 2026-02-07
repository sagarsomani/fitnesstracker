import 'package:flutter/material.dart';
import '../../models/fitness_model.dart';
import '../../services/db_service.dart';

class EditActivityScreen extends StatefulWidget {
  final FitnessRecord record; // Pass the existing record to this screen
  const EditActivityScreen({super.key, required this.record});

  @override
  State<EditActivityScreen> createState() => _EditActivityScreenState();
}

class _EditActivityScreenState extends State<EditActivityScreen> {
  late TextEditingController _stepsController;
  late TextEditingController _calController;
  late String _selectedWorkout;

  @override
  void initState() {
    super.initState();
    // Pre-fill the controllers with existing data
    _stepsController = TextEditingController(
      text: widget.record.steps.toString(),
    );
    _calController = TextEditingController(
      text: widget.record.calories.toString(),
    );
    _selectedWorkout = widget.record.workout;
  }

  void _updateActivity() async {
    await DatabaseService().updateFitnessRecord(
      widget.record.id,
      int.parse(_stepsController.text),
      double.parse(_calController.text),
      _selectedWorkout,
    );
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Activity")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedWorkout,
              isExpanded: true,
              items: [
                'Running',
                'Walking',
                'Cycling',
                'Gym',
                'Yoga',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => _selectedWorkout = val!),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _stepsController,
              decoration: const InputDecoration(labelText: "Steps"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _calController,
              decoration: const InputDecoration(labelText: "Calories"),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _updateActivity,
                child: const Text("UPDATE RECORD"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
