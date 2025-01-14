import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  final List<LineChartModel> data = [
    LineChartModel(date: DateTime(2024, 9), amount: 50),
    LineChartModel(date: DateTime(2024, 10), amount: 100),
    LineChartModel(date: DateTime(2024, 11), amount: 150),
    LineChartModel(date: DateTime(2024, 12), amount: 90),
    LineChartModel(date: DateTime(2025, 1), amount: 130),
    LineChartModel(date: DateTime(2025, 2), amount: 200),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFFF8F9FA),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Jobs. 200",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                DropdownButton<String>(
                  value: "This month",
                  icon: Icon(Icons.arrow_drop_down),
                  underline: Container(),
                  items: ["This month", "This week", "Today"]
                      .map((value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Subtitle
            Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 18),
                const SizedBox(width: 8),
                Text(
                  "On track",
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Placeholder for Line Chart
            SizedBox(
              height: 200,
              child: Placeholder(
                fallbackHeight: 200,
                fallbackWidth: double.infinity,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            // X-Axis Labels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: data.map((e) => Text("${e.date.month}/${e.date.year}")).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder Model
class LineChartModel {
  final DateTime date;
  final double amount;

  LineChartModel({required this.date, required this.amount});
}
