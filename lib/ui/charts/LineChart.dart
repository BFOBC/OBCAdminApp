import 'package:charts_flutter_updated/flutter.dart' as charts;
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
    List<charts.Series<JobsData, String>> series = [
      charts.Series(
        id: 'Jobs',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (JobsData data, _) => data.month,
        measureFn: (JobsData data, _) => data.jobCount,
        data: data,
      ),
    ];

    return SizedBox(
      height: 200,
      child: charts.LineChart(
        series.cast<charts.Series<dynamic, num>>(),
        animate: true,
      ),
    );
  }
}