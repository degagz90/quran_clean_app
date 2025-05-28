import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sholat_controller.dart';

class SholatView extends GetView<SholatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SholatView')),

      body: SafeArea(child: Text('MyController')),
    );
  }
}
