import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/memberships/domain/datasources/membership_datasource.dart';
import 'package:teslo_shop/features/memberships/domain/entities/entities.dart';
import 'package:teslo_shop/features/memberships/infrastructure/mappers/entrada_mapper.dart';
import 'package:teslo_shop/features/memberships/infrastructure/models/entrada_response.dart';

class MembershipDataSourceImpl extends MembershipDataSource {
  final Dio dio;

  final String accessToken;
  

  MembershipDataSourceImpl(
      { required this.accessToken})
      : dio = Dio(BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {'Authorization': 'Bearer $accessToken'}));

  @override
  Future<List<Entrada>> getListMerbershipsByUser(String userId) async {
    try {
      //TODO: Cambiar a fecha de Sistema el CurrentDate
      //String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      String currentDate = '2023-01-14';
      final response = await dio.get(
        '/items/entradas?fields[]=juego.jornada,juego.equipo.nombre,juego.fecha,juego.hora,juego.estadio.nombre,membresia.zonasilla.zona.id,membresia.zonasilla.zona.nombre,membresia.zonasilla.silla.numero,entrada,membresia.id,membresia.socio.user&filter={"_and":[{"membresia":{"socio":{"user":{"id":{"_eq":"$userId"}}}}},{"membresia":{"estadomembresia":{"_eq":1}}},{"juego":{"fecha":{"_eq":"$currentDate"}}}]}',
      );

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
