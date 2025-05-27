import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catatan')),

      body: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text('Total Catatan: ${controller.bookmarks.length}')),
            SizedBox(height: 8),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.bookmarks.length,
                  itemBuilder: (context, index) {
                    final bookmark = controller.bookmarks[index];
                    return ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(
                        'QS. ${bookmark.suratName} ayat ${bookmark.noAyat}',
                      ),
                      subtitle: Text('${bookmark.timeStamp}'),
                      trailing: IconButton(
                        onPressed: () {
                          controller.deleteBookmark(bookmark);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
