import 'package:flutter/material.dart';

class BMICard extends StatelessWidget {
  final double weight; // in kg
  final double height; // in meters

  const BMICard({super.key, required this.weight, required this.height});

  @override
  Widget build(BuildContext context) {
    // BMI Logic: weight / (height * height)
    double bmi = weight / (height * height);

    String getStatus() {
      if (bmi < 18.5) return "Underweight";
      if (bmi < 25) return "Normal";
      if (bmi < 30) return "Overweight";
      return "Obese";
    }

    Color getStatusColor() {
      if (bmi >= 18.5 && bmi < 25) return Colors.green;
      return Colors.orange;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Body Mass Index (BMI)",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                bmi.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                getStatus(),
                style: TextStyle(
                  color: getStatusColor(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Circular indicator for BMI
          Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: bmi / 40, // Scale of 40 for visual
                backgroundColor: Colors.grey.shade200,
                color: getStatusColor(),
                strokeWidth: 8,
              ),
              const Icon(Icons.speed, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
