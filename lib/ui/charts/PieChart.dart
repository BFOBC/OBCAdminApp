import 'package:charts_flutter_updated/flutter.dart' as charts;
import 'package:flutter/material.dart';

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
    List<charts.Series<ActivityData, String>> series = [
      charts.Series(
        id: 'Activity',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ActivityData data, _) => data.type,
        measureFn: (ActivityData data, _) => data.count,
        labelAccessorFn: (ActivityData data, _) => '${data.type}: ${data.count}',
        data: data,
      ),
    ];

    return SizedBox(
      height: 200,
      child: charts.PieChart(
        series,
        animate: true,
        defaultRenderer: charts.ArcRendererConfig(
          arcRendererDecorators: [
            charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.auto,
            ),
          ],
        ),
      ),
    );
  }
}