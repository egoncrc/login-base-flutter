class TorneoModel {
    final String nombre;

    TorneoModel({
        required this.nombre,
    });

    factory TorneoModel.fromMap(Map<String, dynamic> json) => TorneoModel(
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
    };
}