import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/pages/AdminScreens/dashboard/controller.dart';
import 'package:pie_chart/pie_chart.dart';

class DashBoardView extends GetView<DashBoardController> {
  DashBoardView({Key? key}) : super(key: key);
  final controller = Get.put<DashBoardController>(DashBoardController());

  Widget _pieChart(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only( bottom: 10.h),
      child: PieChart(
        dataMap: controller.loadedMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 35,
        chartRadius: MediaQuery.of(context).size.width / 2.5,
        colorList: controller.state.colorList,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 40,
        centerText: "Sales",
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
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
              )),
          child: Padding(
            padding: EdgeInsets.only(
                top: 15.h, bottom: 10.h, left: 10.h, right: 10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(alignment: Alignment.topRight,
                child: InkWell(
                    onTap: (){
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
                                title: controller.state.pendingOrders.toString()),
                            TextWidget(
                                title: controller.state.deliveredOrders.toString()),
                            TextWidget(
                                title: controller.state.cancelledOrders.toString()),
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchData();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx((){
            return controller.state.loaded.value == false
                ? _buildLoadingWidget(context)
                : Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: _buildLoadedWidget(context),
            );
          })
        ),
      ),
    );
  }
}
