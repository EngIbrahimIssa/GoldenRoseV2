import '../../data/remote/api_requests.dart';
import '../../entities/shipping_method_model.dart';
import '../../utils/error_handler/error_handler.dart';
import 'package:get/get.dart';

class DeliveryOptionLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  bool loading = false;
  List<ShippingMethodModel> listShippingMethods = [];
  List list = ['الخيار 1', 'الخيار 2', 'الخيار 3'];
  String? selected;

  @override
  void onInit() {
    super.onInit();
    getShippingMethods(false);
  }

  void setSelected(dynamic value) {
    selected = value;
    update();
  }

  void getShippingMethods(bool forceLoading) async {
    if(listShippingMethods.isNotEmpty && !forceLoading){
      return;
    }
    loading = true;
    update();
    try {
      var response = await _apiRequests.getShippingMethods();
      listShippingMethods = (response.data['payload'] as List)
          .map((e) => ShippingMethodModel.fromJson(e))
          .toList();
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    loading = false;
    update();
  }

  String getSelectedCities(int index) {
    var cities = '';
    int count = 0;

    if (listShippingMethods[index].selectCities!.length > 3) {
      for (int i = 0; i < 3; i++) {
        (count == 0)
            ? cities =
                cities + (listShippingMethods[index].selectCities![i].name ?? '')
            : cities = cities +
                " , " +
            (listShippingMethods[index].selectCities![i].name ?? '');
        count += 1;
      }

      return cities + " , " + " مدن".tr + "${listShippingMethods[index].selectCities!.length - 3}";
    } else {
      listShippingMethods[index].selectCities?.forEach((element) {
        (count == 0)
            ? cities = cities + (element.name ?? '')
            : cities = cities + " , " + (element.name ?? '');
        count += 1;
      });
      return cities;
    }
  }
}
