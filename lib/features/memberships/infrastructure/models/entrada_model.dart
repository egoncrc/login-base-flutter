import 'models.dart';


class EntradaModel {
    final String entrada;
    final JuegoModel juego;
    final MembresiaModel membresia;

    EntradaModel({
        required this.entrada,
        required this.juego,
        required this.membresia,
    });

    factory EntradaModel.fromMap(Map<String, dynamic> json) => EntradaModel(
        entrada: json["entrada"],
        juego: JuegoModel.fromMap(json["juego"]),
        membresia: MembresiaModel.fromMap(json["membresia"]),
    );

    Map<String, dynamic> toMap() => {
        "entrada": entrada,
        "juego": juego.toMap(),
        "membresia": membresia.toMap(),
    };
}