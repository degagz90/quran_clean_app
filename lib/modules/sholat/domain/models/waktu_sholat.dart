class WaktuSholat {
  DateTime subuhTime;
  DateTime terbitTime;
  DateTime dzuhurTime;
  DateTime asharTime;
  DateTime maghribTime;
  DateTime isyaTime;
  String nextPrayer;
  DateTime nextPrayerTime;

  WaktuSholat({
    required this.subuhTime,
    required this.terbitTime,
    required this.dzuhurTime,
    required this.asharTime,
    required this.maghribTime,
    required this.isyaTime,
    required this.nextPrayer,
    required this.nextPrayerTime,
  });
}
