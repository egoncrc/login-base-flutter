class EstadioModel {
    final String nombre;

    EstadioModel({
        required this.nombre,
    });

    factory EstadioModel.fromMap(Map<String, dynamic> json) => EstadioModel(
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
    };
}