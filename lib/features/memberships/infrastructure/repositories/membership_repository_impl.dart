import 'package:teslo_shop/features/auth/domain/entities/user.dart';
import 'package:teslo_shop/features/memberships/domain/datasources/membership_datasource.dart';
import 'package:teslo_shop/features/memberships/domain/entities/entrada.dart';
import 'package:teslo_shop/features/memberships/domain/repositories/membership_repository.dart';

class MembershipRepositoryImpl extends MembershipRepository {
  final MembershipDataSource dataSource;

  MembershipRepositoryImpl({required this.dataSource});

  @override
  Future<List<Entrada>> getListMerbershipsByUser(String userId) {
    return dataSource.getListMerbershipsByUser(userId);
  }
}
