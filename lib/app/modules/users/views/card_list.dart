import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/models/user_model.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/button_field.dart';
import 'package:latransportindo/app/data/widgets/field_form_data.dart';
import 'package:latransportindo/app/modules/users/controllers/users_controller.dart';

class CardList extends StatefulWidget {
  const CardList({super.key, required this.data});
  final UserModel? data;

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

  var controller = Get.put(UsersController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
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
                    value: widget.data!.phone,
                  ),
                  const SizedBox(height: 8),
                  isShow!
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FieldFormData(
                              isShow: isShow,
                              title: "Password",
                              value: "••••••••••",
                            ),
                            const SizedBox(height: 8),
                            FieldFormData(
                              isShow: isShow,
                              title: "Tipe Pengguna",
                              value: widget.data!.userType,
                            ),
                            const SizedBox(height: 8),
                            widget.data!.userType == "Pengemudi"
                                ? FieldFormData(
                                    isShow: isShow,
                                    title: "Nomor SIM",
                                    value: widget.data!.simNumber,
                                  )
                                : const SizedBox(),
                            widget.data!.userType == "Pengemudi"
                                ? const SizedBox(height: 8)
                                : const SizedBox(),
                            FieldFormData(
                              isShow: isShow,
                              title: "Action",
                              widget: Row(
                                children: [
                                  ButtonField(
                                    path: AppIcons.iconfilledit,
                                    bgColor: const Color(0xFFDAFFE9),
                                    txColor: const Color(0xFF2F9E5C),
                                    text: "Ubah",
                                    onTap: () => controller.editUser(
                                      data: widget.data,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ButtonField(
                                    path: AppIcons.iconfillremove,
                                    bgColor: const Color(0xFFFFDFDF),
                                    txColor: const Color(0xFFE05252),
                                    text: "Hapus",
                                    onTap: () => controller.deleteUser(
                                      data: widget.data,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        )
                      : const SizedBox()
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
    );
  }
}
