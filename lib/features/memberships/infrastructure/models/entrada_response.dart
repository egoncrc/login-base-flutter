import 'models.dart';

class EntradaResponse {
    final List<EntradaModel> data;

    EntradaResponse({
        required this.data,
    });

    factory EntradaResponse.fromMap(Map<String, dynamic> json) => EntradaResponse(
        data: List<EntradaModel>.from(json["data"].map((x) => EntradaModel.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}