
import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/memberships/domain/datasources/membership_datasource.dart';
import 'package:teslo_shop/features/memberships/domain/entities/entities.dart';
import 'package:teslo_shop/features/memberships/infrastructure/mappers/entrada_mapper.dart';
import 'package:teslo_shop/features/memberships/infrastructure/models/entrada_response.dart';


class MembershipDataSourceImpl extends MembershipDataSource {
  final Dio dio;

  final String accessToken;

  MembershipDataSourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {'Authorization': 'Bearer $accessToken'}));

  @override
  Future<List<Entrada>> getListMerbershipsByUser(String userId) async {
    try {
      final response = await dio.get(
        '/items/entradas?fields[]=juego.jornada,juego.equipo.nombre,juego.fecha,juego.hora,juego.estadio.nombre,membresia.zonasilla.zona.id,membresia.zonasilla.zona.nombre,membresia.zonasilla.silla.numero,entrada,membresia.id,membresia.socio.user&filter={"_and":[{"membresia":{"socio":{"user":{"id":{"_eq":"$userId"}}}}},{"membresia":{"estadomembresia":{"_eq":1}}}]}',
      );

      //'/items/entradas?filter={"_and":[{"membresia":{"socio":{"user":{"id":{"_eq":"$userId"}}}}},{"membresia":{"estadomembresia":{"_eq":1}}}]}&fields[]=juego.jornada,juego.equipo.nombre,juego.fecha,juego.hora,juego.estadio.nombre,membresia.zonasilla.zona.id,membresia.zonasilla.zona.nombre,membresia.zonasilla.silla.numero,entrada,membresia.id,membresia.socio.user'
      ///items/entradas?fields[]=juego.jornada,juego.equipo.nombre,juego.fecha,juego.hora,juego.estadio.nombre,membresia.zonasilla.zona.id,membresia.zonasilla.zona.nombre,membresia.zonasilla.silla.numero,entrada,membresia.id,membresia.socio.user&filter={"_and":[{"membresia":{"socio":{"user":{"id":{"_eq":"900b55b4-5507-4e2c-86d2-43d7a61a0168"}}}}},{"membresia":{"estadomembresia":{"_eq":1}}}]}&access_token=Ypm71vxDiRzeuq_ZHBDk4uiFgyE7ouli'

      //,options: Options(headers: {'Authorization': 'Bearer $token'})

      EntradaResponse entradaResponse = EntradaResponse.fromMap(response.data);
     
      //print(entradaResponse.data[0].entrada);
      final List<Entrada> entradas = [];

      for (final entrada in entradaResponse.data) {
        entradas.add(EntradaMapper.entradaJsonToEntity(entrada));
      }

      return entradas;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError('Token incorrecto');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
