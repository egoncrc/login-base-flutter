class SillaModel {
    final String numero;

    SillaModel({
        required this.numero,
    });

    factory SillaModel.fromMap(Map<String, dynamic> json) => SillaModel(
        numero: json["numero"],
    );

    Map<String, dynamic> toMap() => {
        "numero": numero,
    };
}