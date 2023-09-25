import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/components/reuseable/text_widget.dart';
import 'package:grocery_app/pages/AdminScreens/orders/OrderItems/controller.dart';

class OrderItemsView extends GetView<OrderItemsController> {
  String orderId;
  String customerId;
   OrderItemsView({Key? key,required this.orderId,required this.customerId}) : super(key: key);
  final controller = Get.put<OrderItemsController>(OrderItemsController());

  Widget _buildlistTile(
      BuildContext context,
      String img,
      String title,
      String category,
      String subCategory,
      int price,
      int discount,
      String orderId,
      String status,
      int itemQty,
      ) {
    Color statusColor;

    // Customize the color based on the order status
    switch (status) {
      case 'Delivered':
        statusColor = Colors.green;
        break;
      case 'Shipped':
        statusColor = Colors.orange;
        break;
      case 'Pending':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.black;
        break;
    }
    void _showOrderDetailsDialogue(BuildContext context) {
      final orderDetailsContent = Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            // Add order details such as image, name, etc. here
            // Example:
            Center(
              child: Container(
                height: 100,
                width: 100,
                child: Image.network(img),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),

            TextWidget(
              title: 'Order #' + orderId,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),

            SizedBox(
              height: 5.h,
            ),
            TextWidget(title: 'Item Name: ' + title),
            SizedBox(
              height: 5.h,
            ),

            TextWidget(title: 'ItemQuantity: ' + itemQty.toString()),
            SizedBox(
              height: 5.h,
            ),

            TextWidget(title: 'Category: ' + category),
            SizedBox(
              height: 5.h,
            ),
            TextWidget(title: 'Sub-Category: ' + subCategory),
            SizedBox(
              height: 5.h,
            ),
            TextWidget(
              title: 'Original Price ' + price.toString(),
            ),
            SizedBox(
              height: 5.h,
            ),

            TextWidget(
              title: 'Discount: ' + discount.toString() + '%',
            ),
          ],
        ),
      );

      Get.defaultDialog(
        title: 'Order Details',
        content: orderDetailsContent,
        radius: 10.0,
        // cancelTextColor: Colors.orange,
        cancel: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                          color: Colors.orange,
                        ))),
                child: Center(
                    child:
                    TextWidget(title: 'Close', textColor: Colors.orange)))),
      );
    }

    return GestureDetector(
      onTap: () {
        _showOrderDetailsDialogue(context);
      },
      child: Card(
        margin: EdgeInsets.only(right: 16, left: 16, top: 12),
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                title: 'Order #' + orderId,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 8.0),
              TextWidget(
                title: 'Title: $title',
                fontSize: 12.sp,
              ),
              SizedBox(height: 8.0),
              TextWidget(
                title: 'Quantity: '+ itemQty.toString(),
                fontSize: 12.sp,
              ),
              SizedBox(height: 8.0),
              TextWidget(
                title: 'Price: '+ (price - ((discount/price)*100)).toString(),
                fontSize: 12.sp,
              ),
              SizedBox(height: 8.0),
              SizedBox(height: 8.0),
              TextWidget(
                title: 'Status: $status',
                textColor: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: LightAppColor.btnColor,
        title:
        // TextWidget(title: 'Edit Inventory',textColor: LightAppColor.bgColor,fontSize: 16,),
        Text(
          'Order Items',
          style: TextStyle(color: Colors.white, fontSize: 20.sp),
        ),

      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: controller.getAllOrdersData(customerId,orderId),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(color: LightAppColor.btnColor,),);
            }
            if (snapshot.hasData) {
              return snapshot.data!.length != 0
                  ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 5.h),
                      child: GestureDetector(
                        onTap: () {

                        },
                        child: _buildlistTile(
                          context,
                          snapshot.data![index].itemImg,
                          snapshot.data![index].itemName,
                          snapshot.data![index].category,
                          snapshot.data![index].subCategory,
                          snapshot.data![index].totalPrice.toInt(),
                          snapshot.data![index].discount.toInt(),
                          snapshot.data![index].orderId,
                          snapshot.data![index].status.toString(),
                          snapshot.data![index].itemQty,
                        ),
                      ),
                    );
                  })
                  : Column(
                children: [
                  TextWidget(
                    title: 'No items here yet.',
                    fontSize: 28.sp,
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              print('Error : ' + snapshot.error.toString());
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            } else {
              return Container();
            }
          },

        ),
      ),
    );
  }
}
