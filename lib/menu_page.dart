import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'app_bar.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar("折线图", context),
      body: Column(
        children: [
          SizedBox.fromSize(size: const Size.fromHeight(32)),
          SizedBox(
            width: 320,
            height: 140,
            child: lineChart,
          ),
        ],
      ),
    );
  }

  LineTouchData get lineTouchData => LineTouchData(
      getTouchLineEnd: (data, index) => double.infinity,
      getTouchedSpotIndicator:
          (LineChartBarData barData, List<int> spotIndexes) {
        return spotIndexes.map((spotIndex) {
          return TouchedSpotIndicatorData(
            FlLine(color: Colors.black26, strokeWidth: 1, dashArray: [1, 3]),
            FlDotData(
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                        radius: 4,
                        color: barData.color,
                        strokeWidth: 4,
                        strokeColor: barData.color?.withOpacity(0.5))),
          );
        }).toList();
      },
      touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white.withOpacity(0),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((LineBarSpot touchedSpot) {
              const textStyle = TextStyle(
                fontSize: 14,
              );
              return LineTooltipItem('', textStyle);
            }).toList();
          }),
      touchCallback: (FlTouchEvent event, LineTouchResponse? lineTouch) {
        if (!event.isInterestedForInteractions ||
            lineTouch == null ||
            lineTouch.lineBarSpots == null) {
          return;
        }
        final value = lineTouch.lineBarSpots![0].x;
        // flowVM.touchedIndex = value.toInt();
      });

  final firstSpotList = const [
    FlSpot(0, 4),
    FlSpot(1, 3.5),
    FlSpot(2, 4.5),
    FlSpot(3, 1),
    FlSpot(4, 4),
    FlSpot(5, 6),
    FlSpot(6, 6.5),
    FlSpot(7, 6),
    FlSpot(8, 4),
    FlSpot(9, 6),
    FlSpot(10, 6),
    FlSpot(11, 7),
  ];
  final secondSpotList = const [
    FlSpot(0, 0),
    FlSpot(1, 3),
    FlSpot(2, 4),
    FlSpot(3, 5),
    FlSpot(4, 8),
    FlSpot(5, 3),
    FlSpot(6, 5),
    FlSpot(7, 8),
    FlSpot(8, 4),
    FlSpot(9, 7),
    FlSpot(10, 7),
    FlSpot(11, 8),
  ];

  LineChartBarData get firstChartBarData => LineChartBarData(
        spots: firstSpotList,
        isCurved: false,
        barWidth: 2,
        color: const Color(0xFF256FFF),
        dotData: FlDotData(
          show: false,
        ),
      );

  LineChartBarData get secondChartBarData => LineChartBarData(
      spots: secondSpotList,
      isCurved: false,
      barWidth: 2,
      color: const Color(0xFFF2994A),
      dotData: FlDotData(
        checkToShowDot: (spot, barData) {
          return false;
        },
        getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
            radius: 4,
            strokeColor: const Color(0xFFF2994A).withOpacity(0.5),
            strokeWidth: 4,
            color: const Color(0xFFF2994A)),
      ));

  List<LineChartBarData> get lineBarsData => [
        firstChartBarData,
        secondChartBarData,
      ];

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            interval: 2,
            reservedSize: 16,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlGridData get gridData => FlGridData(
      show: true,
      verticalInterval: 2,
      horizontalInterval: 2,
      drawVerticalLine: true,
      // checkToShowVerticalLine: (double value) {
      //   if (value.toInt() == 0) {
      //     return true;
      //   }
      //   return value % 2 == 0;
      // },
      getDrawingHorizontalLine: (value) {
        return FlLine(
            color: const Color(0xFFE7E7E7).withOpacity(0.6), strokeWidth: 0.8);
      },
      getDrawingVerticalLine: (value) {
        if (value.toInt() == 0) {
          return FlLine(
              color: Colors.black26, strokeWidth: 1, dashArray: [1, 3]);
        }
        return FlLine(
            color: const Color(0xFFE7E7E7).withOpacity(0.6), strokeWidth: 0.8);
      });

  FlBorderData get borderData => FlBorderData(
      show: true,
      border: Border.all(
          color: const Color(0xFFE7E7E7).withOpacity(0.6), width: 0.8));

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xEE8E94A0),
      fontWeight: FontWeight.w300,
      fontSize: 8,
    );
    String text = '';
    if (value % 2 == 0) {
      text = '${value.toInt()}:00';
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(text, style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.w400,
      fontSize: 9.5,
    );
    return Text(value.toInt().toString(), style: style);
  }

  LineChart get lineChart => LineChart(
        LineChartData(
          maxY: 10,
          lineTouchData: lineTouchData,
          lineBarsData: lineBarsData,
          borderData: borderData,
          titlesData: titlesData,
          gridData: gridData,
          // extraLinesData: extraLinesData,
        ),
      );
}
