import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/providers.dart';
import '../../domain/domain.dart';
import 'memberships_repository_provider.dart';

//PROVIDER
final membershipsProvider =
    StateNotifierProvider<MembershipsNotifier, MembershipsState>((ref) {
  final membershipRepository = ref.watch(membershipsRepositoryProvider);
  
  final userID = ref.watch(authProvider).user?.id.toString() ?? '';
  
  return MembershipsNotifier(
      membershipRepository: membershipRepository, userID: userID);
});

//NOTIFIER

class MembershipsNotifier extends StateNotifier<MembershipsState> {
  final MembershipRepository membershipRepository;
  final String userID;
  
  MembershipsNotifier(
      {required this.membershipRepository, required this.userID})
      : super(MembershipsState()) {
    loadMemberships();
  }

  Future loadMemberships() async {
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
    );
    
    final entradas =
        await membershipRepository.getListMerbershipsByUser(userID);
    if (entradas.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        entradas: [],
      );
      return;
    }
    state = state.copyWith(
      isLoading: false,
      entradas: [...entradas],
    );
  }

  List<Entrada> uniqueMemberships() {
    final setEntradas = Set<String>();
    List<Entrada> totalEntradasList = [];
    totalEntradasList.addAll(state.entradas);

    if (totalEntradasList.isEmpty) return [];

//TODO: Cambiar fecha por fecha de hoy
    // List<Entrada> uniqueMembershipsList = totalEntradasList
    //     .where((entrada) =>
    //         entrada.fecha == DateTime.parse('2023-01-28 00:00:00.000'))
    //     .toList();

    List<Entrada> uniqueMembershipsList = totalEntradasList
        .where((entrada) => setEntradas.add(entrada.zona))
        .toList();

    return uniqueMembershipsList;
  }

  List<Entrada> membershipsByZone(String zona) {
    List<Entrada> totalEntradasList = [];
    totalEntradasList.addAll(state.entradas);

    if (totalEntradasList.isEmpty) return [];

//TODO: Cambiar fecha por fecha de hoy
    List<Entrada> zoneMembershipsList =
        totalEntradasList.where((entrada) => entrada.zona == zona).toList();

    return zoneMembershipsList;
  }
}

//STATE

class MembershipsState {
  final bool isLoading;
  final List<Entrada> entradas;

  MembershipsState({
    this.isLoading = false,
    this.entradas = const [],
  });

  MembershipsState copyWith({
    bool? isLoading,
    List<Entrada>? entradas,
  }) =>
      MembershipsState(
          isLoading: isLoading ?? this.isLoading,
          entradas: entradas ?? this.entradas);
}
