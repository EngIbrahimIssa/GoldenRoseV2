import '../../data/remote/api_requests.dart';
import '../../entities/bank_response_model.dart';
import '../../utils/error_handler/error_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadTransferLogic extends GetxController {
  final ApiRequests _apiRequests = Get.find();
  final TextEditingController nameController = TextEditingController();
  bool isBanksLoading = false;
  bool isLoading = false;
  XFile? image;

  BankResponseModel? selected;
  List<BankResponseModel> banksList = [];

  @override
  void onInit() {
    getStoreBanks();
    super.onInit();
  }

  void setSelected(dynamic value) async {
    selected = value;
    update();
  }

  void pickPhoto({required bool isPhoto}) async {
    final ImagePicker _picker = ImagePicker();
//    if(await checkAndRequestCameraPermissions())
    image = await _picker.pickImage(source: isPhoto ?  ImageSource.camera : ImageSource.gallery);
    update();

  }


  getStoreBanks() async {
    isBanksLoading = true;
    update();
    try {
      var response = await _apiRequests.getStoreBanks();
      banksList = (response.data['payload'] as List)
          .map((e) => BankResponseModel.fromJson(e))
          .toList();
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isBanksLoading = false;
    update();
  }

  uploadTransfer(String? orderCode) async {
    if(selected == null){
      Fluttertoast.showToast(msg: "يرجى اختيار البنك أولاً".tr);
      return;
    }
    if(nameController.text.isEmpty){
      Fluttertoast.showToast(msg: "يرجى ادخال اسم المحول منه أولاً".tr);
      return;
    }
    if(image == null){
      Fluttertoast.showToast(msg: "يرجى ارفاق صورة الحوالة أولاً".tr);
      return;
    }
    isLoading = true;
    update();
    try {
      var response = await _apiRequests.uploadTransfer(
        image: image,
        storeBankId: selected?.id.toString(),
        senderName: nameController.text,
        orderCode: orderCode
      );
      Get.back();
      Fluttertoast.showToast(msg: "تم ارسال الحوالة بنجاح".tr);
    } catch (e) {
      ErrorHandler.handleError(e);
    }
    isLoading = false;
    update();
  }
}
