import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/colors/light_app_colors.dart';
import 'package:grocery_app/pages/user_screens/details/index.dart';
import 'package:grocery_app/pages/user_screens/search_directory/controller.dart';

import '../../../components/reuseable/icon_widget.dart';
import '../../../components/reuseable/search_text_field.dart';

class SearchView extends GetView<SearchBarController> {
  SearchView({super.key});

  final controller = Get.put(SearchBarController());

  Widget _searchBarView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.h),
      child: GetBuilder<SearchBarController>(
        builder: (con) {
          return TextField(
            onChanged: (value) {
              controller.searchTours(value);
            },
            controller: controller.state.searchController,
            textInputAction: TextInputAction.search,

            keyboardType: TextInputType.text,
            cursorColor: Colors.orange,
            // focusNode: focNode,
            decoration: InputDecoration(

              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.orange,
              )),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.orange,
              )),

              prefixIcon: InkWell(
                onTap: () {
                  controller.state.searchController.clear();
                  controller.filteredItemsList.clear();
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: LightAppColor.btnColor,
                ),
              ),
              suffixIcon: Icon(
                Icons.search,
                color: LightAppColor.btnColor,
              ),
              // border: InputBorder.none,

              hintText: 'Search items here...',
            ),
          );
        },
      ),
    );
  }

  Widget _buildlistTile(BuildContext context, String img, String title,
      String category, String subCategory, int price, int discount) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.grey[200]!))),
            child: Image.network(
              img,
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ), // assuming you store image URLs in firestore
          ),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5.0),
              Text(
                category,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 5.0),
              Text(
                subCategory,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Text(
                    'RS${price}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        decoration: discount != 0 && discount > 0
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  discount != 0 && discount > 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'RS ' +
                                controller
                                    .calculateDiscountedPrice(price, discount)
                                    .toString(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        )
                      : Container(),
                  if (discount != 0 && discount > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${discount}% OFF',
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    ),
                ],
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container(),
              SizedBox(
                height: 10.h,
              ),
              IconWidget(iconData: Icons.arrow_forward_ios_rounded),
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
        elevation: 0,
        title: _searchBarView(),
        backgroundColor: LightAppColor.bgColor,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          // _searchBarView(),
          // SizedBox(
          //   height: 5.h,
          // ),
          Expanded(
            child: Obx(
              () =>
                  // var tours = controller.filteredTourList;
                  controller.filteredItemsList.length != 0
                      ? ListView.builder(
                          itemCount: controller.filteredItemsList.length,
                          itemBuilder: (context, index) {
                            print('Length iss :' +
                                controller.filteredItemsList.length.toString());
                            // Customize this part based on your data structure.
                            var item = controller.filteredItemsList[index];
                            print('Item is : ' + item.toString());
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 2),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => DetailsScreen(
                                          title: item['title'],
                                          itemImg: item['imageUrl'],
                                          price: item['price'],
                                          itemQty: item['priceQty'],
                                          userName: controller.state.username
                                              .toString(),
                                          itemId: item['itemId'],
                                          category: item['category'],
                                          subCategory: item['subCategory'],
                                          discount: item['discount']));
                                      controller.filteredItemsList.clear();
                                      controller.state.searchController.clear();
                                    },
                                    child: _buildlistTile(
                                        context,
                                        item['imageUrl'],
                                        item['title'],
                                        item['category'],
                                        item['subCategory'],
                                        item['price'],
                                        item['discount']),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            'No searches yet',
                            style: TextStyle(
                                color: LightAppColor.textColor, fontSize: 25),
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
