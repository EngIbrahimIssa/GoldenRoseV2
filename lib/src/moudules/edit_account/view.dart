import 'package:entaj/src/utils/custom_widget/custom_button_widget.dart';
import 'package:entaj/src/utils/custom_widget/custom_text.dart';
import 'package:entaj/src/utils/validation/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class EditAccountPage extends StatelessWidget {
  final EditAccountLogic logic = Get.put(EditAccountLogic());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EditAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logic.setData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          "تعديل الحساب".tr,
          fontSize: 16,
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<EditAccountLogic>(builder: (logic) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        color: Colors.grey.shade100),
                    child: TextFormField(
                      controller: logic.nameController,
                      validator: Validation.nameValidate,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          labelStyle: TextStyle(color: Colors.grey.shade700),
                          labelText: "الاسم".tr),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        color: Colors.grey.shade100),
                    child: TextFormField(
                      controller: logic.emailController,
                      validator: Validation.emailValidate,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          labelStyle: TextStyle(color: Colors.grey.shade700),
                          labelText: "البريد الإلكتروني".tr),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        color: Colors.grey.shade100),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: logic.phoneController,
                            validator: Validation.phoneValidate,
                            enabled: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                labelStyle:
                                    TextStyle(color: Colors.grey.shade700),
                                labelText: "رقم الجوال".tr),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.sp),
                              color: Colors.white),
                          child: Row(
                            children: const [
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.keyboard_arrow_down),
                              CustomText("+966"),
                              SizedBox(
                                width: 5,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButtonWidget(
                      title: "حفظ التغييرات".tr,
                      radius: 15,
                      loading: logic.isLoading,
                      onClick: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        FocusScope.of(context).unfocus();

                        logic.editAccountDetails();
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
