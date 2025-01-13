/*import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';  // Import the flutter_charts package

class ActivityData {
  final String type;
  final int count;

  ActivityData(this.type, this.count);
}

class PieChartWidget extends StatelessWidget {
  final List<ActivityData> data;

  PieChartWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    // Preparing the data for the PieChart
    List<PieChartSegment> segments = data.map((activity) {
      return PieChartSegment(
        value: activity.count.toDouble(),
        label: '${activity.type}: ${activity.count}',
        color: _getColorForType(activity.type), // Assigning color based on type
      );
    }).toList();

    return SizedBox(
      height: 200,
      child: PieChart(
        segments: segments,
        animate: true,
      ),
    );
  }

  // Helper method to assign colors to each type
  Color _getColorForType(String type) {
    switch (type) {
      case 'Type A':
        return Colors.blue;
      case 'Type B':
        return Colors.red;
      case 'Type C':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
*/