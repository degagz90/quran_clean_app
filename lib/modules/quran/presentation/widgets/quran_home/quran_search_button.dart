import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/colors/app_colors.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../controllers/quran_controller.dart';

class QuranSearchButton extends StatelessWidget {
  const QuranSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuranController>();
    final searchController = SearchController();
    return SearchAnchor(
      isFullScreen: false,
      shrinkWrap: true,
      viewElevation: 10,
      viewHintText: "cari surat",
      headerHintStyle: TextStyle(color: Colors.grey),
      dividerColor: AppColors.ungu2,
      viewSurfaceTintColor: Colors.white,
      textInputAction: TextInputAction.done,
      searchController: searchController,
      builder: (context, searchController) {
        return IconButton(
          onPressed: () {
            searchController.text = '';
            searchController.openView();
          },
          icon: Icon(Icons.search),
        );
      },
      suggestionsBuilder: (context, searchController) {
        String sanitize(String s) =>
            s.toLowerCase().replaceAll(RegExp(r"[-']"), '');
        final query = searchController.text.toLowerCase();
        if (query.isEmpty) {
          return const Iterable<Widget>.empty();
        }
        final filtered = controller.listSurat.where((surat) {
          final name = sanitize(surat.name);
          final indoName = sanitize(surat.indoName);
          return name.contains(query) || indoName.contains(query);
        }).toList();
        return filtered.map((surat) {
          return ListTile(
            title: Text("${surat.noSurat}. ${surat.name} (${surat.indoName})"),
            onTap: () {
              searchController.closeView("");
              Future.delayed(Duration(milliseconds: 500));
              Get.toNamed(
                AppRoutes.suratDetail,
                arguments: {'no_surat': surat.noSurat},
              );
            },
          );
        });
      },
    );
  }
}
