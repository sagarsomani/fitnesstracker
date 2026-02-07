import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/fitness_model.dart';

class WeeklyBarChart extends StatelessWidget {
  final List<FitnessRecord> records;

  const WeeklyBarChart({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 10000, // Target steps
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  // Logic to show Day names (M, T, W...)
                  return Text(
                    ['M', 'T', 'W', 'T', 'F', 'S', 'S'][value.toInt() % 7],
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: _generateGroups(),
        ),
        swapAnimationDuration: const Duration(
          milliseconds: 750,
        ), // Requirement: Animated
        swapAnimationCurve: Curves.easeInOutBack,
      ),
    );
  }

  List<BarChartGroupData> _generateGroups() {
    // This maps your Firebase records to the bars
    return List.generate(records.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: records[index].steps.toDouble(),
            color: Colors.deepPurpleAccent,
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }
}
