import '../../../../colors.dart';
import '../../../../data/remote/api_requests.dart';
import '../../../../data/shared_preferences/pref_manger.dart';
import '../../../../entities/order_model.dart';
import '../../../../utils/error_handler/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../_auth/login/view.dart';

class OrdersLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  final PrefManger _prefManger = Get.find();
  bool loading = false;
  bool isLogin = true;
  List<OrderModel> orderMainList = [];
  List<OrderModel> orderList = [];
  List<String> orderStatusList = [];

  String? selected;

  void setSelected(dynamic value) async {
    if(value == "طلباتي".tr){
      selected = null;
      update();
      orderList = orderMainList;
      return;
    }

    selected = value;
    //await getOrders();
    List<OrderModel> orderListNew = [];

    orderMainList.forEach((element) {
      orderListNew.addIf(element.orderStatus?.name == value, element);
    });

    orderList = orderListNew;
    update();
  }

  Color getOrderStatusColor(OrderStatus? orderStatus) {
    if (orderStatus?.code == 'delivered') {
      return secondaryColor;
    }
    if (orderStatus?.code == 'preparing') {
      return Colors.orange;
    }
    if (orderStatus?.code == 'cancelled') {
      return Colors.red;
    }

    return Colors.grey;
  }


  void goToLogin() {
    Get.to(LoginPage())?.then((value) async {
      await _apiRequests.onInit();
      getOrders();
    });
  }

  Future getOrders() async {
    if (!await _prefManger.getIsLogin()) {
     // Fluttertoast.showToast(msg: "يرجى تسجيل الدخول أولاً".tr);
      orderStatusList = [];
      orderMainList = [];
      orderList = [];
      selected = null;
      isLogin = false;
      update();
      return;
    }
    isLogin = true;


    selected = null;
    loading = true;
    update();
    try {
      orderStatusList = [];
      var response = await _apiRequests.getOrders();
      // log(response.data.toString());
      orderMainList = (response.data['payload'] as List)
          .map((e) => OrderModel.fromJson(e))
          .toList();

      orderList = orderMainList;

      orderStatusList.add("طلباتي".tr);
      orderMainList.forEach((element) {
        orderStatusList.addIf(
            !orderStatusList.contains(element.orderStatus!.name!),
            element.orderStatus!.name!);
      });
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    loading = false;
    update();
  }
}
