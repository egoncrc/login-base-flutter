import 'models.dart';


class JuegoModel {
    final int jornada;
    final DateTime fecha;
    final String hora;
    final EquipoModel equipo;
    final EstadioModel estadio;

    JuegoModel({
        required this.jornada,
        required this.fecha,
        required this.hora,
        required this.equipo,
        required this.estadio,
    });

    factory JuegoModel.fromMap(Map<String, dynamic> json) => JuegoModel(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        hora: json["hora"],
        equipo: EquipoModel.fromMap(json["equipo"]),
        estadio: EstadioModel.fromMap(json["estadio"]),
    );

    Map<String, dynamic> toMap() => {
        "jornada": jornada,
        "fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "hora": hora,
        "equipo": equipo.toMap(),
        "estadio": estadio.toMap(),
    };
}