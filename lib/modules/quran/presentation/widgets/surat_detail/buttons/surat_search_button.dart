import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/constants/colors/app_colors.dart';
import '../../../controllers/surat_detail_controller.dart';

class SuratSearchButton extends StatelessWidget {
  const SuratSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SuratDetailController>();
    final searchController = SearchController();
    return SearchAnchor(
      isFullScreen: false,
      shrinkWrap: true,
      viewElevation: 10,
      viewHintText: "cari ayat",
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
        final filtered = controller.listAyat.where((ayat) {
          final terjemah = sanitize(ayat.terjemah);
          return terjemah.contains(query) ||
              ayat.noAyat.toString().contains(query);
        }).toList();
        return filtered.map((ayat) {
          return ListTile(
            title: Text(
              "${ayat.noAyat}. ${ayat.terjemah}",
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              searchController.closeView("");
              Future.delayed(Duration(milliseconds: 800));
              controller.searchedAyatIndex.value = ayat.noAyat - 1;
              // Get.toNamed(
              //   AppRoutes.suratDetail,
              //   arguments: {'no_surat': surat.noSurat},
              // );
            },
          );
        });
      },
    );
  }
}
