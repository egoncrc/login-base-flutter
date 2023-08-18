import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socios_herediano/features/auth/presentation/providers/providers.dart';
import 'package:socios_herediano/features/memberships/domain/domain.dart';
import 'package:socios_herediano/features/memberships/infrastructure/datasources/membership_datasources_impl.dart';
import 'package:socios_herediano/features/memberships/infrastructure/repositories/membership_repository_impl.dart';

final membershipsRepositoryProvider = Provider<MembershipRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token.toString() ?? '';    
     
  final membershipsRepository = MembershipRepositoryImpl(
      dataSource: MembershipDataSourceImpl(accessToken: accessToken));
  return membershipsRepository;
});
