import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/models/customer_model.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/utils/utils.dart';
import 'package:latransportindo/app/data/widgets/field_form_data.dart';
import 'package:latransportindo/app/modules/customers/controllers/customers_controller.dart';

class CardList extends StatefulWidget {
  const CardList({super.key, required this.data});
  final CustomerModel? data;

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  bool? isShow = false;
  Widget btn({
    String? path,
    Color? bgColor,
    Color? txColor,
    String? text,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: RichText(
          text: TextSpan(
            style: textRegular.copyWith(
              fontSize: 12,
              color: txColor,
            ),
            children: [
              WidgetSpan(
                child: Image.asset(
                  path!,
                  width: 18,
                  height: 18,
                  color: txColor,
                ),
              ),
              const WidgetSpan(child: SizedBox(width: 4)),
              TextSpan(text: text!)
            ],
          ),
        ),
      ),
    );
  }

  void setShow() {
    setState(() {
      isShow = !isShow!;
    });
  }

  var controller = Get.put(CustomersController());
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
                      title: "No. Telepon",
                      value: widget.data!.phoneNumber,
                    ),
                    const SizedBox(height: 8),
                    isShow!
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FieldFormData(
                                isShow: isShow,
                                title: "Email",
                                value: widget.data!.email,
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
                                            "${widget.data!.status}",
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
                                        child: btn(
                                          path: AppIcons.iconfilledit,
                                          bgColor: const Color(0xFFDAFFE9),
                                          txColor: const Color(0xFF2F9E5C),
                                          text: "Ubah",
                                          onTap: () => controller.editCustomer(
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
