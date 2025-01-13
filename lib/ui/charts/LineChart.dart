/*import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class JobsData {
  final String month;
  final int jobCount;

  JobsData(this.month, this.jobCount);
}

class LineChartWidget extends StatelessWidget {
  final List<JobsData> data;

  LineChartWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true), // Optional: Add grid lines
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < data.length) {
                    return Text(
                      data[index].month,
                      style: TextStyle(fontSize: 10),
                    );
                  }
                  return const SizedBox.shrink();
                },
                interval: 1,
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: Colors.blue, // Updated to `color` instead of `colors`
              spots: data.asMap().entries.map((entry) {
                return FlSpot(entry.key.toDouble(), entry.value.jobCount.toDouble());
              }).toList(),
              barWidth: 3,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
*/