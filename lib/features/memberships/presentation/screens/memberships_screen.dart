import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/memberships/presentation/providers/providers.dart';
import 'package:teslo_shop/features/shared/shared.dart';

import '../../domain/entities/entrada.dart';

class MembershipsScreen extends StatelessWidget {
  const MembershipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Localidades'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.sports_soccer_rounded))
        ],
      ),
      body: FadeInRight(child: const _MembershipsView()),
    );
  }
}

class _MembershipsView extends ConsumerWidget {
  const _MembershipsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membershipProvider = ref.watch(membershipsProvider);
    
    List<Entrada> memberShipsZoneList = 
        ref.watch(membershipsProvider.notifier).uniqueMemberships();

    return RefreshIndicator(
        onRefresh: ref.watch(membershipsProvider.notifier).loadMemberships,
        child:
            _ListUniqueMemberships(memberShipsZoneList: memberShipsZoneList));
  }
}

class _ListUniqueMemberships extends StatelessWidget {
  final List<Entrada> memberShipsZoneList;

  const _ListUniqueMemberships({required this.memberShipsZoneList});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _tickedListDecoration(),
      child: memberShipsZoneList.isEmpty
          ? ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  //decoration: _tickedListCardDecoration(),
                  child: const Column(
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Text('Para ver tus entradas al siguiente juego',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 152, 13, 3))),
                      Text('se mostrará una lista con tus localidades',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 152, 13, 3))),
                      Text('el mismo día del partido programado en casa.',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 152, 13, 3))),
                      SizedBox(
                        height: 30,
                      ),
                      Image(
                        image: AssetImage('assets/images/escudo.png'),
                        height: 130,
                      ),
                    ],
                  ),
                ),
                const Column(
                  children: [
                    SizedBox(height: 15,),
                    Text('Deslice para actualizar',style: TextStyle(color: Color.fromARGB(255, 103, 126, 219)),),
                    Icon(Icons.keyboard_arrow_down,color:Color.fromARGB(255, 132, 150, 221),size: 50, )
                  ],
                )
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: ListView.builder(                
                itemCount: memberShipsZoneList.length,
                itemBuilder: (context, index) {
                  final entrada = memberShipsZoneList[index];

                  return GestureDetector(
                    onTap: () => context.push('/membership/${entrada.zona}'),
                    child: FadeInUp(child: MembershipCard(membership: entrada)),
                  );
                },
              ),              
            ),
            
    );
  }
}

BoxDecoration _tickedListDecoration() => const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          // Color.fromARGB(255, 116, 16, 3),
          Color.fromARGB(255, 224, 221, 221),
          Color.fromRGBO(120, 120, 120, 1),
          //  Color.fromRGBO(244, 247, 247, 1),
        ]));
