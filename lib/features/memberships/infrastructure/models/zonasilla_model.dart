
import 'models.dart';

class ZonasillaModel {
    final ZonaModel zona;
    final SillaModel silla;

    ZonasillaModel({
        required this.zona,
        required this.silla,
    });

    factory ZonasillaModel.fromMap(Map<String, dynamic> json) => ZonasillaModel(
        zona: ZonaModel.fromMap(json["zona"]),
        silla: SillaModel.fromMap(json["silla"]),
    );

    Map<String, dynamic> toMap() => {
        "zona": zona.toMap(),
        "silla": silla.toMap(),
    };
}