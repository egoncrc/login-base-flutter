import 'package:socios_herediano/features/auth/domain/entities/user.dart';
import 'package:socios_herediano/features/memberships/domain/datasources/membership_datasource.dart';
import 'package:socios_herediano/features/memberships/domain/entities/entrada.dart';
import 'package:socios_herediano/features/memberships/domain/repositories/membership_repository.dart';

class MembershipRepositoryImpl extends MembershipRepository {
  final MembershipDataSource dataSource;

  MembershipRepositoryImpl({required this.dataSource});

  @override
  Future<List<Entrada>> getListMerbershipsByUser(String userId) {
    return dataSource.getListMerbershipsByUser(userId);
  }
}
