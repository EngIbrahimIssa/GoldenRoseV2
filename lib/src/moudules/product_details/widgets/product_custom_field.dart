import 'package:dropdown_button2/dropdown_button2.dart';
import '../logic.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../main.dart';
import '../../../colors.dart';
import '../../../entities/product_details_model.dart';
import '../../../utils/custom_widget/custom_image.dart';
import '../../../utils/custom_widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCustomField extends StatelessWidget {
  final CustomFields customField;

  const ProductCustomField({required this.customField, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsLogic>(
        init: Get.find<ProductDetailsLogic>(),
        builder: (logic) {
          switch (customField.type) {
            case 'TEXT':
              logic.mapTextEditController[customField.id!] =
                  TextEditingController();
              logic.observeTextEdit(
                  logic.mapTextEditController[customField.id!],
                  customField.price ?? 0);
              var required = customField.isRequired ?? false ? '*' : '';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(child: CustomText("${customField.label}")),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        required,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (customField.price != null && customField.price != 0.0)
                        CustomText(
                          "السعر ".tr + '( ${customField.formattedPrice})',
                          color: secondaryColor,
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: logic.mapTextEditController[customField.id!],

                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(10)
                      ),

                      labelText: customField.label ?? '',
                      hintText: customField.hint ?? '',
                      labelStyle: TextStyle(color: primaryColor)
                    ),
                  ),
                ],
              );
            case 'NUMBER':
              logic.mapTextEditController[customField.id!] =
                  TextEditingController();
              logic.observeTextEdit(
                  logic.mapTextEditController[customField.id!],
                  customField.price ?? 0);
              var required = customField.isRequired ?? false ? '*' : '';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(child: CustomText("${customField.label}")),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        required,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (customField.price != null && customField.price != 0.0)
                        CustomText(
                          "السعر ".tr + '( ${customField.formattedPrice})',
                          color: secondaryColor,
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: logic.mapTextEditController[customField.id!],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: customField.label ?? '',
                      hintText: customField.hint ?? '',
                        labelStyle: TextStyle(color: primaryColor)

                    ),
                  ),
                ],
              );

            case 'TIME':
              logic.mapTextEditController[customField.id!] =
                  TextEditingController();
              var required = customField.isRequired ?? false ? '*' : '';
              return GetBuilder<ProductDetailsLogic>(
                  id: customField.id!,
                  builder: (logic) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(child: CustomText("${customField.label}")),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              required,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller:
                          logic.mapTextEditController[customField.id!],
                          readOnly: true,
                          onTap: () {
                            FocusScope.of(Get.context!)
                                .requestFocus(FocusNode());
                            showTimePicker(
                                context: Get.context!,
                                builder: (BuildContext? context,
                                    Widget? child) =>
                                    MediaQuery(
                                      data: MediaQuery.of(context!)
                                          .copyWith(
                                          alwaysUse24HourFormat: false),
                                      child: child!,
                                    ),
                                initialTime: TimeOfDay.now())
                                .then(
                                  (value) {
                                if (value == null) return;
                                DateTime tempDate = DateFormat("hh:mm").parse(
                                    value.hour.toString() +
                                        ":" +
                                        value.minute.toString());
                                var dateFormat = DateFormat("hh:mm a");

                                String day =
                                    "${value.hour.toString().padLeft(2, "0")}:${value.minute.toString().padLeft(2, "0")}";
                                logic.mapTextEditController[customField.id!]
                                    ?.text = day;
                                logic.update([customField.id!]);
                              },
                            );
                          },
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,

                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              labelText: customField.label ?? '',
                              labelStyle: TextStyle(color: primaryColor),
                              hintText: customField.hint == null ? '' : '--:-- --',

                              suffixIcon:
                              logic.mapTextEditController[customField.id!]
                                  ?.text.isEmpty ==
                                  true
                                  ? const SizedBox()
                                  : InkWell(
                                onTap: () {
                                  logic.mapTextEditController[
                                  customField.id!] =
                                      TextEditingController();
                                  logic.update([customField.id!]);
                                },
                                child: const Icon(
                                    Icons.highlight_remove_outlined),
                              )),
                        ),
                      ],
                    );
                  });
            case 'DATE':
              logic.mapTextEditController[customField.id!] =
                  TextEditingController();
              var required = customField.isRequired ?? false ? '*' : '';
              return GetBuilder<ProductDetailsLogic>(
                  id: customField.id!,
                  builder: (logic) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(child: CustomText("${customField.label}")),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              required,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller:
                          logic.mapTextEditController[customField.id!],
                          readOnly: true,
                          onTap: () {
                            FocusScope.of(Get.context!)
                                .requestFocus(FocusNode());
                            showDatePicker(
                                context: Get.context!,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100))
                                .then(
                                  (value) {
                                if (value == null) return;
                                String date =
                                    "${value.year.toString()}-${value.month.toString().padLeft(2, "0")}-${value.day.toString().padLeft(2, "0")}";
                                logic.mapTextEditController[customField.id!]
                                    ?.text = date;
                                logic.update([customField.id!]);
                              },
                            );
                          },
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,

                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              labelText: customField.label ?? '',
                              labelStyle: TextStyle(color: primaryColor),

                              hintText: customField.hint ?? '',
                              suffixIcon:
                              logic.mapTextEditController[customField.id!]
                                  ?.text.isEmpty ==
                                  true
                                  ? const SizedBox()
                                  : InkWell(
                                onTap: () {
                                  logic.mapTextEditController[
                                  customField.id!] =
                                      TextEditingController();
                                  logic.update([customField.id!]);
                                },
                                child: const Icon(
                                    Icons.highlight_remove_outlined),
                              )),
                        ),
                      ],
                    );
                  });
            case 'DROPDOWN':
              var required = customField.isRequired ?? false ? '*' : '';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CustomText("${customField.name}"),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        required,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        '${customField.hint}',
                        color: secondaryColor,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: Stack(
                      children: [
                        GetBuilder<ProductDetailsLogic>(
                            id: customField.id,
                            builder: (logic) {
                              return DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  iconSize: 0,
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.sp),
                                  ),
                                  itemPadding: EdgeInsets.zero,
                                  dropdownPadding: EdgeInsets.zero,
                                  itemHeight: 55.h,
                                  scrollbarAlwaysShow: true,
                                  isExpanded: true,
                                  selectedItemBuilder: (con) {
                                    return customField.choices
                                        ?.map((selectedType) {
                                      return Container(
                                          height: double.infinity,
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 10),
                                          child: Row(
                                            children: [
                                              CustomText(
                                                  "${selectedType.name}"),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              if (selectedType.price !=
                                                  null &&
                                                  selectedType.price != 0.0)
                                                CustomText(
                                                    '( ${selectedType.formattedPrice})',
                                                    color: secondaryColor)
                                            ],
                                          ));
                                    }).toList() ??
                                        [];
                                  },
                                  hint: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            'اختر'.tr,
                                            fontSize: 12,
                                          ),
                                        ],
                                      )),
                                  value:
                                  logic.mapDropDownChoices[customField.id],
                                  items:
                                  customField.choices?.map((selectedType) {
                                    return DropdownMenuItem(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Row(
                                          children: [
                                            CustomText(selectedType.name),
                                            const SizedBox(width: 5),
                                            if (selectedType.price != null &&
                                                selectedType.price != 0.0)
                                              CustomText(
                                                  '( ${selectedType.formattedPrice})',
                                                  color: secondaryColor)
                                          ],
                                        ),
                                      ),
                                      value: selectedType.id,
                                    );
                                  }).toList(),
                                  onChanged: (value) =>
                                      logic.changeDropDownSelected(
                                          customField.id!,
                                          customField.choices
                                              ?.firstWhere((element) =>
                                          element.id == value)
                                              .price ??
                                              0,
                                          value),
                                ),
                              );
                            }),
                        Positioned(
                            left: isArabicLanguage ? 10 : null,
                            right: isArabicLanguage ? null : 10,
                            top: 0,
                            bottom: 0,
                            child:
                            const Icon(Icons.keyboard_arrow_down_outlined)),
                      ],
                    ),
                  )
                ],
              );
            case 'CHECKBOX':
              var required = customField.isRequired ?? false ? '*' : '';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(child: CustomText("${customField.name}")),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        required,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: CustomText(
                          '${customField.hint}',
                          color: secondaryColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GetBuilder<ProductDetailsLogic>(
                      id: customField.id!,
                      builder: (logic) {
                        return Column(
                          children: customField.choices?.map((e) {
                            //  log(logic.mapCheckboxChoices[customOptionFields.id!]![e.id!].toString());
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: CheckboxListTile(

                                value: logic.mapCheckboxChoices[
                                customField.id!]?[e.id!] ??
                                    false,
                                onChanged: (value) {
                                  logic.changeCheckboxSelected(
                                      customField.id!,
                                      e.id!,
                                      e.price ?? 0,
                                      value);
                                },
                                title: Row(
                                  children: [
                                    Flexible(child: CustomText("${e.name}")),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    if (e.price != null && e.price != 0.0)
                                      CustomText(
                                        '( ${e.formattedPrice})',
                                        color: secondaryColor,
                                      )
                                  ],
                                ),
                              ),
                            );
                          }).toList() ??
                              [],
                        );
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );

            case 'IMAGE':
              logic.mapTextEditController[customField.id!] =
                  TextEditingController();
              var required = customField.isRequired ?? false ? '*' : '';
              String? temporaryUrl;
              return GetBuilder<ProductDetailsLogic>(
                  init: Get.find<ProductDetailsLogic>(),
                  id: customField.id!,
                  builder: (logic) {
                    return logic.isUploadLoading
                        ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          )),
                    )
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(child: CustomText("${customField.label}")),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              required,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                List<String?>? path =
                                await logic.uploadFileImage(
                                    false, customField.id!);
                                if (path != null) {
                                  if (path.first != null) {
                                    logic
                                        .mapTextEditController[
                                    customField.id!]
                                        ?.text = path.first!;
                                    temporaryUrl = path[1];
                                  }
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: Colors.grey.shade300),
                                child: temporaryUrl != null
                                    ? CustomImage(
                                  url: temporaryUrl,
                                  width: double.infinity,
                                  height: 70,
                                  size: 20,
                                )
                                    : CustomText(
                                  customField.hint,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                            if (temporaryUrl != null)
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          temporaryUrl = null;
                                          logic.mapTextEditController[
                                          customField.id!] =
                                              TextEditingController();
                                          logic.update([customField.id!]);
                                        },
                                        icon: const Icon(
                                            Icons.highlight_remove)),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ],
                    );
                  });
            case 'FILE':
              logic.mapTextEditController[customField.id!] =
                  TextEditingController();
              var required = customField.isRequired ?? false ? '*' : '';
              String? temporaryUrl;
              return GetBuilder<ProductDetailsLogic>(
                  init: Get.find<ProductDetailsLogic>(),
                  id: customField.id!,
                  builder: (logic) {
                    if (logic.isUploadLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            )),
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Flexible(child: CustomText("${customField.label}")),
                              const SizedBox(
                                width: 5,
                              ),
                              CustomText(
                                required,
                                color: Colors.red,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  List<String?>? path = await logic
                                      .uploadFileImage(true, customField.id!);
                                  if (path != null) {
                                    if (path.first != null) {
                                      logic
                                          .mapTextEditController[
                                      customField.id!]
                                          ?.text = path.first!;
                                      temporaryUrl = path[1];
                                    }
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade300),
                                  child: temporaryUrl != null
                                      ? CustomImage(
                                    url: temporaryUrl,
                                    width: double.infinity,
                                    height: 70,
                                    size: 20,
                                  )
                                      : CustomText(
                                    customField.hint,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                              if (temporaryUrl != null)
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            temporaryUrl = null;
                                            logic.mapTextEditController[
                                            customField.id!] =
                                                TextEditingController();
                                            logic.update([customField.id!]);
                                          },
                                          icon: const Icon(
                                              Icons.highlight_remove)),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      );
                    }
                  });

            default:
              return const SizedBox();
          }
        });
  }
}
