


import 'package:socios_herediano/features/memberships/domain/entities/entrada.dart';

abstract class MembershipDataSource {
  
  Future<List<Entrada>> getListMerbershipsByUser(String userId);
}
