class EquipoModel {
    final String nombre;

    EquipoModel({
        required this.nombre,
    });

    factory EquipoModel.fromMap(Map<String, dynamic> json) => EquipoModel(
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
    };
}