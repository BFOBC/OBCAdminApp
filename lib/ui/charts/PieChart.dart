import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartWidget extends StatelessWidget {
  final Map<String, double> dataMap = {
    "Completed Jobs": 63,
    "Active Jobs": 25,
  };

  final List<Color> colorList = [
    Color(0xFF4318FF),
    Color(0xFF6AD2FF),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and Dropdown
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Activity Analysis",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton<String>(
              value: "Monthly",
              icon: Icon(Icons.arrow_drop_down),
              underline: Container(),
              items: ["Monthly", "Weekly", "Daily"]
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
        // Pie Chart
        PieChart(
          dataMap: dataMap,
          colorList: colorList,
          chartType: ChartType.ring,
          ringStrokeWidth: 0,
          chartRadius: MediaQuery.of(context).size.width / 2.5,
          legendOptions: LegendOptions(
            showLegends: false,
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValues: false,
          ),
        ),
        const SizedBox(height: 20),
        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildLegendItem(Color(0xFF4318FF), "Completed Jobs", "63%"),
            _buildLegendItem(Color(0xFF6AD2FF), "Active Jobs", "25%"),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String title, String percentage) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(radius: 5, backgroundColor: color),
            const SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          percentage,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
