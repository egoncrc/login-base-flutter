import 'package:socios_herediano/features/auth/domain/entities/user.dart';
import 'package:socios_herediano/features/memberships/domain/entities/entrada.dart';

abstract class MembershipRepository {  
  Future<List<Entrada>> getListMerbershipsByUser(String userId);
}