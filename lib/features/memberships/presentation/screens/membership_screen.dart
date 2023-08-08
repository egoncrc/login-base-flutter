import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/shared.dart';
import '../providers/providers.dart';

class MembershipScreen extends StatelessWidget {
  final String zona;

  const MembershipScreen({super.key, required this.zona});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(zona),
      ),
      body: _TicketListView(zona: zona )
      );
  }
}

class _TicketListView extends ConsumerWidget {
  final String zona;

  const _TicketListView({required this.zona});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberShipsTikectsList =
        ref.watch(membershipsProvider.notifier).membershipsByZone(zona);
    return Container(
      decoration: _tickedViewDecoration(),
      child: ListView.builder(
        
        itemCount: memberShipsTikectsList.length,
        itemBuilder: (BuildContext context, int index) {
          final entrada = memberShipsTikectsList[index];
          return Container(              
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TicketCard(entrada: entrada),
              )
              );
        },
      ),
    );;
  }
}

BoxDecoration _tickedViewDecoration()=> const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(218, 223, 223, 1),
        Color.fromRGBO(120, 120, 120, 1),
        // Color.fromRGBO(21,176,179, 1),
      ]
      )
  );