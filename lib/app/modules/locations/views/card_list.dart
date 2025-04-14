import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/models/location_model.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/button_field.dart';
import 'package:latransportindo/app/data/widgets/field_form_data.dart';
import 'package:latransportindo/app/modules/locations/controllers/locations_controller.dart';

class CardList extends StatefulWidget {
  const CardList({super.key, required this.data});
  final LocationModel? data;

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  bool? isShow = false;

  // Widget fieldData({String? title, String? value, Widget? widget}) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Expanded(
  //         flex: 1,
  //         child: Text(
  //           title!,
  //           style: textSemiBold.copyWith(fontSize: 12),
  //         ),
  //       ),
  //       Expanded(
  //         flex: 2,
  //         child: widget ??
  //             Text(
  //               value!,
  //               overflow: isShow! ? TextOverflow.clip : TextOverflow.ellipsis,
  //               style: textRegular.copyWith(
  //                   fontSize: 12, color: AppColor.black400),
  //             ),
  //       ),
  //     ],
  //   );
  // }

  Color statusTextColor({String? status}) {
    if (status!.toLowerCase() == "aktif") return AppColor.blue400;
    return AppColor.yellow500;
  }

  Color statusBgColor({String? status}) {
    if (status!.toLowerCase() == "aktif") return AppColor.blue100;
    return AppColor.yellow100;
  }

  void setShow() {
    setState(() {
      isShow = !isShow!;
    });
  }

  var controller = Get.put(LocationsController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FieldFormData(
                      isShow: isShow,
                      title: "Nama",
                      value: widget.data!.name,
                    ),
                    const SizedBox(height: 8),
                    FieldFormData(
                      isShow: isShow,
                      title: "Alamat",
                      value: widget.data!.address,
                    ),
                    const SizedBox(height: 8),
                    isShow!
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FieldFormData(
                                isShow: isShow,
                                title: "Pelanggan",
                                value: widget.data!.customer!.name,
                              ),
                              const SizedBox(height: 8),
                              FieldFormData(
                                isShow: isShow,
                                title: "Status",
                                widget: RichText(
                                  text: TextSpan(
                                    style: textRegular.copyWith(fontSize: 12),
                                    children: [
                                      WidgetSpan(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                            horizontal: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: statusBgColor(
                                                status: widget.data!.status),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            "${widget.data!.status![0].toUpperCase()}${widget.data!.status!.substring(1)}",
                                            style: textRegular.copyWith(
                                              fontSize: 12,
                                              color: statusTextColor(
                                                  status: widget.data!.status),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              FieldFormData(
                                isShow: isShow,
                                title: "Action",
                                widget: RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: ButtonField(
                                          path: AppIcons.iconfilledit,
                                          bgColor: const Color(0xFFDAFFE9),
                                          txColor: const Color(0xFF2F9E5C),
                                          text: "Ubah",
                                          onTap: () => controller.editLocation(
                                            data: widget.data,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setShow(),
                child: Image.asset(
                  isShow!
                      ? AppIcons.iconfillexpandcircleup
                      : AppIcons.iconfillexpandcircledown,
                  width: 24,
                  height: 24,
                  color: AppColor.black400,
                ),
              )
            ],
          ),
          const Divider(
            color: AppColor.black100,
            height: 0,
            indent: 0,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
