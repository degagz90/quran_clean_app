import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/constants/text_styles/app_text.dart';
import '../../../../domain/models/ayat.dart';
import '../../../../domain/models/surat.dart';

class TafsirButton extends StatelessWidget {
  final Surat _surat;
  final Ayat _ayat;
  const TafsirButton(this._surat, this._ayat, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Get.defaultDialog(
          barrierDismissible: false,
          onCancel: () {},
          textCancel: 'Tutup',
          buttonColor: Theme.of(context).primaryColor,
          titleStyle: TextStyle(color: Theme.of(context).primaryColor),
          title: 'Tafsir QS. ${_surat.name}: ${_ayat.noAyat}',
          content: Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '${_ayat.tafsir}\n\nsumber: Kementrian Agama Republik Indonesia',
                  style: AppText.subtitleText,
                ),
              ),
            ),
          ),
        );
      },
      label: Text('tafsir', style: TextStyle(fontWeight: FontWeight.bold)),
      icon: Icon(Icons.arrow_right),
      iconAlignment: IconAlignment.end,
    );
  }
}
