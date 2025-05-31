enum Tema { light, dark }

enum Qari { alAfasy, ashShatree, haniRifai }

class Setting {
  final Tema tema;
  final Qari qari;
  final bool continuesPlay;
  final bool playAdzan;

  Setting({
    required this.tema,
    required this.qari,
    required this.continuesPlay,
    required this.playAdzan,
  });
}
