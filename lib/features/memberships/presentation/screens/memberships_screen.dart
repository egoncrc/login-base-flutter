import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/memberships/presentation/providers/providers.dart';
import 'package:teslo_shop/features/shared/shared.dart';

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
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
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

    final memberShipsZoneList =
        ref.watch(membershipsProvider.notifier).uniqueMemberships();    

    return Container(
      decoration: _tickedListDecoration(),
      child: memberShipsZoneList.isEmpty 
      ?   Container(              
                
                alignment: Alignment.center,
                //decoration: _tickedListCardDecoration(),
                child: const Column(
                  children: [
                    SizedBox(height: 50,),
                    Text('No hay partidos programados para el día de hoy.',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 152, 13, 3))),
                    Text('Revise la opción de Jornadas, para ver el',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color:  Color.fromARGB(255, 152, 13, 3))),
                    Text('próximo partido en casa de nuestro equipo',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color:  Color.fromARGB(255, 152, 13, 3))),
                    Image(image: AssetImage('assets/images/escudo.png'),height:100,),
                    
                  ],
                ),
              )
      :  Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: ListView.builder(
          itemCount: memberShipsZoneList.length,
          itemBuilder: (context, index) {
            final entrada = memberShipsZoneList[index];
          
            return GestureDetector(
              onTap: ()=> context.push('/membership/${entrada.zona}'),
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