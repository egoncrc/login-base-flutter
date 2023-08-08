class SocioModel {
    final String user;

    SocioModel({
        required this.user,
    });

    factory SocioModel.fromMap(Map<String, dynamic> json) => SocioModel(
        user: json["user"],
    );

    Map<String, dynamic> toMap() => {
        "user": user,
    };
}