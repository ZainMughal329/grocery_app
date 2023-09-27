import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/pages/AdminScreens/dashboard/controller.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:fl_chart/fl_chart.dart' as fl;

// import 'package:sliver_bar_chart/sliver_bar_chart.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-legend.dart';

class DashBoardView extends GetView<DashBoardController> {
  DashBoardView({Key? key}) : super(key: key);
  final controller = Get.put<DashBoardController>(DashBoardController());

  Widget _pieChart(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: PieChart(
        dataMap: controller.loadedMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 35,
        chartRadius: MediaQuery.of(context).size.width / 2.5,
        colorList: controller.state.colorList,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 30.r,
        centerText: "Sales",
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          // legendPosition: LegendPosition.right,
          showLegends: true,
          legendShape: BoxShape.circle,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
          decimalPlaces: 1,
        ),
        // gradientList: ---To add gradient colors---
        // emptyColorGradient: ---Empty Color gradient---
      ),
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: CircularProgressIndicator(
          color: LightAppColor.btnColor,
        ),
      ),
    );
  }

  Widget _buildLoadedWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Sales Report",
            style: GoogleFonts.poppins(
              color: LightAppColor.btnColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          // height: 150.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: LightAppColor.btnColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: 15.h, bottom: 10.h, left: 10.h, right: 10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: () {
                        controller.refreshData();
                      },
                      child: Icon(Icons.refresh)),
                ),
                _pieChart(context),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(title: 'Total Sales  '),
                            TextWidget(title: 'Total Orders  '),
                            TextWidget(title: 'Pending Orders  '),
                            TextWidget(title: 'Shipped Orders  '),
                            TextWidget(title: 'Delivered Orders  '),
                            TextWidget(title: 'Cancelled Orders  '),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              title: controller.state.totalSales.toString(),
                            ),
                            TextWidget(
                              title: controller.state.totalOrders.toString(),
                            ),
                            TextWidget(
                                title:
                                    controller.state.pendingOrders.toString()),
                            TextWidget(
                                title:
                                controller.state.shippedOrders.toString()),
                            TextWidget(
                                title: controller.state.deliveredOrders
                                    .toString()),
                            TextWidget(
                                title: controller.state.cancelledOrders
                                    .toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "DayWise Sales",
            style: GoogleFonts.poppins(
              color: LightAppColor.btnColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 250.h,
          decoration: BoxDecoration(
            color: LightAppColor.btnColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
            ),
          ),

          child: VerticalBarChart(
                    controller.state.orderCounts,
                  )

        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Monthly Sales",
            style: GoogleFonts.poppins(
              color: LightAppColor.btnColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          // height: 350.h,
          decoration: BoxDecoration(
            color: LightAppColor.btnColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
            ),
          ),

          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200.h,
                padding: EdgeInsets.only(
                    left: 25.w, top: 20.h,bottom: 10.h),
                child: fl.LineChart(
                  fl.LineChartData(
                    titlesData: fl.FlTitlesData(
                      topTitles: fl.AxisTitles(
                          sideTitles:
                              fl.SideTitles(showTitles: false)),
                      leftTitles: fl.AxisTitles(
                          sideTitles:
                              fl.SideTitles(showTitles: false)),
                      bottomTitles: fl.AxisTitles(
                        sideTitles: fl.SideTitles(

                          showTitles: true,
                          interval: 0.6,
                          // reservedSize: 32,
                          getTitlesWidget: (value, meta) {
                            print('Value : ' + value.toString());
                            int index = (value /
                                    (1 /
                                        (controller
                                                .state.months.length -
                                            1)))
                                .round();
                            if (index >= 0 &&
                                index <
                                    controller.state.months.length) {
                              var mon =
                                  controller.state.months[index];
                              print('object + ' + index.toString());

                              // print('mon : ' + mon[index].toString());
                              return fl.SideTitleWidget(
                                space: 4,
                                fitInside: fl.SideTitleFitInsideData(
                                    enabled: true,
                                    axisPosition: 10,
                                    parentAxisSize: 10,
                                    distanceFromEdge: -90),
                                // angle: 80,
                                axisSide: meta.axisSide,
                                child: Text(
                                  mon.toString(),
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                  ),
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                    ),
                    borderData: fl.FlBorderData(
                      show: true,
                      border: Border.all(
                        color: const Color(0xff37434d),
                        width: 1,
                      ),
                    ),
                    gridData: fl.FlGridData(show: false),
                    minX: 0,
                    maxX: (controller.state.months.length - 1)
                        .toDouble(),
                    minY: 0,
                    // maxY: controller.getMaxOrderCount(),
                    lineBarsData: [
                      fl.LineChartBarData(
                        spots: controller.getChartData(),
                        isCurved: true,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 20),
              Text('Select a Month to View Data:'),
              Wrap(
                spacing: 10,
                children: controller.state.months
                    .asMap()
                    .entries
                    .map((entry) {
                  final index = entry.key;
                  final month = entry.value;
                  return ElevatedButton(
                    onPressed: () =>
                        controller.showDataForMonth(index),
                    child: Text(month),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchData();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:  Obx(
            () {
              return controller.state.loaded.value == false
                  ? _buildLoadingWidget(context)
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: _buildLoadedWidget(context),
                    );
            },
          ),
        ),
      ),
    );
  }
}

class VerticalBarChart extends GetView<DashBoardController> {
  final Map<String, int> data;

  VerticalBarChart(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.w, top: 10.h,bottom: 10.h),
      child: Container(
        // height: 200.h,
        child: fl.BarChart(
          fl.BarChartData(
            alignment: fl.BarChartAlignment.spaceAround,
            titlesData: fl.FlTitlesData(
              topTitles:
                  fl.AxisTitles(sideTitles: fl.SideTitles(showTitles: false)),
              leftTitles:
                  fl.AxisTitles(sideTitles: fl.SideTitles(showTitles: false)),
              bottomTitles: fl.AxisTitles(
                sideTitles: fl.SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    var date = data.keys.toList()[value.toInt()];
                    return fl.SideTitleWidget(
                        axisSide: meta.axisSide, child: Text(date.toString()));
                  },
                ),
              ),
            ),
            borderData: fl.FlBorderData(
              show: true,

              border: Border.all(

                color: Colors.grey,
                width: 1.5,
              ),
            ),
            gridData: fl.FlGridData(show: false),
            barGroups: data.entries.map(
              (entry) {
                return fl.BarChartGroupData(
                  x: data.keys.toList().indexOf(entry.key),
                  barRods: [
                    fl.BarChartRodData(
                      toY: entry.value.toDouble(),
                      color: entry.key.length < 9 ? Colors.red : Colors.orange,
                    ),
                  ],
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}

// class VerticalBarChartForPastData extends StatelessWidget {
//   final Map<String, int> lastWeekData;
//   final Map<String, int> currentWeekData;
//
//   VerticalBarChartForPastData(this.lastWeekData, this.currentWeekData);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200.h,
//       child: fl.BarChart(
//         fl.BarChartData(
//           alignment: fl.BarChartAlignment.spaceAround,
//           titlesData: fl.FlTitlesData(
//             leftTitles: fl.AxisTitles(
//                 sideTitles:
//                 fl.SideTitles(showTitles: true)),
//             bottomTitles: fl.AxisTitles(
//     sideTitles:fl.SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value , meta) {
//                 List<String> days = lastWeekData.keys.toList();
//                 if (value >= 0 && value < days.length) {
//                   var d =  days[value.toInt()];
//                   return fl.SideTitleWidget(child: Text(d.toString()), axisSide: meta.axisSide);
//                 }
//                 return Container();
//               },
//             ),),
//           ),
//           borderData: fl.FlBorderData(
//             show: true,
//             border: Border.all(
//               color: const Color(0xff37434d),
//               width: 1,
//             ),
//           ),
//           barGroups: [
//             fl.BarChartGroupData(
//               x: 0,
//               barRods: lastWeekData.entries.map(
//                     (entry) {
//                   return fl.BarChartRodData(
//                     toY: entry.value.toDouble(),
//                     color: Colors.blue,
//                   );
//                 },
//               ).toList(),
//             ),
//             fl.BarChartGroupData(
//               x: 1,
//               barRods: currentWeekData.entries.map(
//                     (entry) {
//                   return fl.BarChartRodData(
//                     toY: entry.value.toDouble(),
//                     color: Colors.red,
//                   );
//                 },
//               ).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
// }
