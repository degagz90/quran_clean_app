import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catatan')),

      body: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Column(
          children: [
            Text('Jumlah Catatan: ${controller.bookmarks.length}'),
            Expanded(
              child: ListView.builder(
                itemCount: controller.bookmarks.length,
                itemBuilder: (context, index) {
                  final bookmark = controller.bookmarks[index];
                  return ListTile(title: Text('${bookmark.suratName}'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
