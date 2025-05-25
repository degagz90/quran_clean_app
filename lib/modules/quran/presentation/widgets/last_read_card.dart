import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuranLastReadCard extends StatelessWidget {
  const QuranLastReadCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Container(
          height: 180,
          width: Get.width - 30,
          decoration: BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(
              image: AssetImage('assets/images/last_read.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
