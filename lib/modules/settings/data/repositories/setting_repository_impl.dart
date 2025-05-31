import 'dart:convert';

import '../datasources/setting_local_datasource.dart';

import '../../domain/models/setting.dart';
import '../../domain/repositories/setting_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final localData = SettingLocalDatasource();
  final String key = "setting";

  @override
  Future<Setting> getSetting() async {
    //baca dari storage
    String? data = await localData.readStorage(key);
    //kalau null buat setting default
    if (data == null) {
      return Setting(
        tema: Tema.light,
        qari: Qari.ashShatree,
        continuesPlay: true,
        playAdzan: false,
      );
    }
    //kalau tidak null ambil data
    //buat String jadi map
    Map<String, dynamic> parsedData = jsonDecode(data);
    //masukkan data ke model
    return Setting(
      tema: Tema.values.firstWhere(
        (element) => element.name == parsedData["tema"],
      ),
      qari: Qari.values.firstWhere(
        (element) => element.name == parsedData["qari"],
      ),
      continuesPlay: parsedData['continuesPlay'],
      playAdzan: parsedData['playAdzan'],
    );
  }

  @override
  Future<void> saveSetting(Setting setting) async {
    // ubah setting dalam bentuk string
    Map<String, dynamic> mappedSetting = {
      "tema": setting.tema.name,
      "qari": setting.qari.name,
      "continuesPlay": setting.continuesPlay,
      "playAdzan": setting.playAdzan,
    };
    final jsonString = jsonEncode(mappedSetting);
    // simpan ke storage
    await localData.saveToStorage(key, jsonString);
  }
}
