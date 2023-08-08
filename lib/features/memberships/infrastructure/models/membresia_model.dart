

import 'models.dart';


class MembresiaModel {
    final int id;
    final ZonasillaModel zonasilla;
    final SocioModel socio;

    MembresiaModel({
        required this.id,
        required this.zonasilla,
        required this.socio,
    });

    factory MembresiaModel.fromMap(Map<String, dynamic> json) => MembresiaModel(
        id: json["id"],
        zonasilla: ZonasillaModel.fromMap(json["zonasilla"]),
        socio: SocioModel.fromMap(json["socio"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "zonasilla": zonasilla.toMap(),
        "socio": socio.toMap(),
    };
}