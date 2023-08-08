import 'package:flutter/material.dart';

import '../../memberships/domain/domain.dart';

class MembershipCard extends StatelessWidget {
  final Entrada membership;

  const MembershipCard({super.key, required this.membership});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      height: 200,
      alignment: Alignment.center,
      decoration: _tickedListCardDecoration(),
      child: Stack(
        children: [
          Image(
              image: const AssetImage('assets/images/backgroundcard.png'),
              height: 200,
              color: Colors.grey.shade500),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text('JORNADA #${membership.jornada}',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700])),
              const SizedBox(
                height: 5,
              ),
              const Text('Club Sport Herediano',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 159, 112, 4))),
              const Text('VS',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 159, 112, 4))),
              Text('${membership.visita}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 159, 112, 4))),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: CircleAvatar(
                  //child: Icon(Icons.account_circle),
                  backgroundImage: const AssetImage('assets/images/escudo.png'),
                  backgroundColor: Colors.grey.withOpacity(0),
                  radius: 20,
                ),
                title: Text('${membership.zona}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(248, 176, 31, 2))),
                subtitle: const Text('Ver aquí sus entradas',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(169, 1, 84, 151))),
                trailing: const Icon(Icons.double_arrow_sharp,
                    size: 40, color: Color.fromARGB(255, 159, 112, 4)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



BoxDecoration _tickedListCardDecoration() => BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromARGB(255, 236, 237, 238),
            Color.fromRGBO(159, 159, 157, 0.8),
            // Color.fromRGBO(21,176,179, 1),
          ]),
      boxShadow: [
        BoxShadow(
          color: Colors.black54.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 6,
          offset: const Offset(0, 7),
        ),
      ],
    );
