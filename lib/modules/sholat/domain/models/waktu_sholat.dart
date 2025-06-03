class WaktuSholat {
  DateTime subuhTime;
  DateTime terbitTime;
  DateTime dzuhurTime;
  DateTime asharTime;
  DateTime maghribTime;
  DateTime isyaTime;
  double locationLat;
  double locationLong;

  WaktuSholat({
    required this.subuhTime,
    required this.terbitTime,
    required this.dzuhurTime,
    required this.asharTime,
    required this.maghribTime,
    required this.isyaTime,
    required this.locationLat,
    required this.locationLong,
  });
}
