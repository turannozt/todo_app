// ignore_for_file: unnecessary_type_check
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/ui/theme.dart';

import '../controllers/task_controller.dart';

class NotifiedPage extends StatefulWidget {
  final String label;
  const NotifiedPage({super.key, required this.label});

  @override
  State<NotifiedPage> createState() => _NotifiedPageState();
}

class _NotifiedPageState extends State<NotifiedPage> {
  final _taskController = Get.put(TaskController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: context.theme.colorScheme.background,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Get.isDarkMode ? Colors.grey[300] : Colors.grey,
          ),
        ),
        title: Text(
          widget.label.toString().split("|")[0],
          style: TextStyle(
              color: Get.isDarkMode ? Colors.grey[300] : Colors.black),
        ),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Get.isDarkMode ? Colors.white : Colors.grey[300],
          ),
          child: Column(
            children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? Colors.grey[400] : Colors.grey[300],
                ),
              ),
              const SizedBox(height: 10),
              const Spacer(),
              Text(
                widget.label.toString().split("|")[1],
                style: GoogleFonts.lato(
                  color: Get.isDarkMode ? Colors.grey[600]: Colors.black,
                  fontSize: 30,
                ),
              ),
              const Spacer(),
              const SizedBox(height: 20),
              _bottomSheetButton(
                label: 'Task Completed',
                onTap: () {
                  int myInt = int.parse(widget.label.toString().split("|")[2]);
                  assert(myInt is int);

                  _taskController.markTaskCompleted(myInt);
                  Get.back();
                },
                clr: primaryClr,
                context: context,
              ),
              const SizedBox(height: 10),
              _bottomSheetButton(
                label: 'Close',
                onTap: () {
                  Get.back();
                },
                clr: Colors.red[300]!,
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: isClose == true ? Colors.transparent : clr,
          border: Border.all(
            width: 2,
            color: isClose == true
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titleStyle
                : titleStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
          ),
        ),
      ),
    );
  }
}
