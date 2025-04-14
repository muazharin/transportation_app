import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/models/vehicle_model.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/utils/utils.dart';
import 'package:latransportindo/app/data/widgets/button_field.dart';
import 'package:latransportindo/app/data/widgets/field_form_data.dart';
import 'package:latransportindo/app/modules/vehicles/controllers/vehicles_controller.dart';

class CardList extends StatefulWidget {
  const CardList({super.key, required this.data});
  final VehicleModel? data;

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  bool? isShow = false;

  void setShow() {
    setState(() {
      isShow = !isShow!;
    });
  }

  var controller = Get.put(VehiclesController());
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
                      title: "Nomor Polisi",
                      value: widget.data!.policeNumber.toString().toUpperCase(),
                    ),
                    const SizedBox(height: 8),
                    FieldFormData(
                      isShow: isShow,
                      title: "Jenis Mobil",
                      value: widget.data!.carType!.name,
                    ),
                    const SizedBox(height: 8),
                    isShow!
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FieldFormData(
                                isShow: isShow,
                                title: "Keterangan",
                                value: widget.data!.note,
                              ),
                              const SizedBox(height: 8),
                              FieldFormData(
                                isShow: isShow,
                                title: "Nomor Pintu",
                                value: widget.data!.doorNumber,
                              ),
                              const SizedBox(height: 8),
                              FieldFormData(
                                isShow: isShow,
                                title: "Nomor KIR",
                                value: widget.data!.kir,
                              ),
                              const SizedBox(height: 8),
                              FieldFormData(
                                isShow: isShow,
                                title: "Nomor STNK",
                                value: widget.data!.stnk,
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
                                        child: ButtonField(
                                          path: AppIcons.iconfilledit,
                                          bgColor: const Color(0xFFDAFFE9),
                                          txColor: const Color(0xFF2F9E5C),
                                          text: "Ubah",
                                          onTap: () => controller.editVehicle(
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
