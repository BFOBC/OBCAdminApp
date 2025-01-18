import 'package:flutter/material.dart';

class StackedChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define data for the chart
    final data = [
      {'day': 17, 'purple': 3, 'blue': 2, 'lightBlue': 1},
      {'day': 18, 'purple': 4, 'blue': 2, 'lightBlue': 2},
      {'day': 19, 'purple': 3, 'blue': 3, 'lightBlue': 2},
      {'day': 20, 'purple': 5, 'blue': 4, 'lightBlue': 3},
      {'day': 21, 'purple': 4, 'blue': 3, 'lightBlue': 2},
      {'day': 22, 'purple': 3, 'blue': 2, 'lightBlue': 1},
      {'day': 23, 'purple': 4, 'blue': 3, 'lightBlue': 2},
    ];

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder( 
        borderRadius: BorderRadius.circular(20), // Circular border radius
      ),
      elevation: 2, 
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Weekly Payments",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2559),
              ),
            ),
            SizedBox(height: 16),
            // Chart container
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: data.map((entry) {
                    final totalHeight = entry['purple']! + entry['blue']! + entry['lightBlue']!;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Stacked bar with separate containers for each color
                        Container(
                          width: 16,
                          height: totalHeight * 20.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Light Blue Section
                              Container(
                                height: entry['lightBlue']! * 20.0,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                              ),
                              // Blue Section
                              Container(
                                height: entry['blue']! * 20.0,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              // Purple Section
                              Container(
                                height: entry['purple']! * 20.0,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        // Day label
                        Text(
                          entry['day'].toString(),
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
