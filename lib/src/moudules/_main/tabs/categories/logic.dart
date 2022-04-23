import 'package:entaj/src/data/remote/api_requests.dart';
import 'package:entaj/src/entities/category_model.dart';
import 'package:entaj/src/moudules/notification/view.dart';
import 'package:entaj/src/moudules/search/view.dart';
import 'package:entaj/src/utils/error_handler/error_handler.dart';
import 'package:get/get.dart';

class CategoriesLogic extends GetxController {


  void goToNotification(){
    Get.to(NotificationPage());
  }


}
