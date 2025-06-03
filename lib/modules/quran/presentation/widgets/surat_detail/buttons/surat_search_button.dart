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
          final terjemah = ayat.terjemah;
          final lowerTerjemah = sanitize(terjemah);
          final idx = lowerTerjemah.indexOf(query);

          // Ambil potongan sekitar query (misal 20 karakter sebelum & 60 sesudah)
          int start = idx - 20 >= 0 ? idx - 20 : 0;
          int end = idx + query.length + 60 <= terjemah.length
              ? idx + query.length + 60
              : terjemah.length;
          String snippet = terjemah.substring(start, end);

          // Tambahkan "..." jika snippet tidak dimulai dari awal ayat
          if (start > 0) {
            snippet = '...$snippet';
          }

          // Highlight query pada snippet
          final matchStart = snippet.toLowerCase().indexOf(
            searchController.text.toLowerCase(),
          );
          final matchEnd = matchStart + searchController.text.length;

          return ListTile(
            title: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Get.theme.brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
                children: [
                  TextSpan(text: "${ayat.noAyat}. "),
                  if (matchStart != -1) ...[
                    TextSpan(text: snippet.substring(0, matchStart)),
                    TextSpan(
                      text: snippet.substring(matchStart, matchEnd),
                      style: TextStyle(
                        fontFamily: "Poppins",
                        backgroundColor: Colors.yellow,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(text: snippet.substring(matchEnd)),
                  ] else
                    TextSpan(text: snippet),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              searchController.closeView("");
              Future.delayed(Duration(milliseconds: 800));
              controller.searchedAyatIndex.value = ayat.noAyat - 1;
            },
          );
        });
      },
    );
  }
}
