class ZonaModel {
    final int id;
    final String nombre;

    ZonaModel({
        required this.id,
        required this.nombre,
    });

    factory ZonaModel.fromMap(Map<String, dynamic> json) => ZonaModel(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
    };
}