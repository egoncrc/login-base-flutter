import 'package:teslo_shop/features/auth/domain/entities/user.dart';
import 'package:teslo_shop/features/memberships/domain/entities/entrada.dart';

abstract class MembershipRepository {  
  Future<List<Entrada>> getListMerbershipsByUser(String userId);
}