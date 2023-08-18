import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../memberships/domain/entities/entities.dart';

class TicketCard extends StatelessWidget {
  final Entrada entrada;
  const TicketCard({Key? key, required this.entrada}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final userService = context.read<UserService>();
    return Container(
      decoration: _ticketCardDecoration(),
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 13, left: 18),
            child: Image(
                image: AssetImage('assets/images/escudo.png'), height: 40),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(entrada.torneo,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800])),
                Text('Jornada #${entrada.jornada}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800])),
                Text('${entrada.zona} - Asiento: ${entrada.asiento}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(248, 176, 31, 2))),
                Text('C.S. Herediano VS ${entrada.visita}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 159, 112, 4))),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.black,
                ),
                QrImageView(

                  data: entrada.entrada,
                  size: 350,
                  version: QrVersions.auto,
                ),
                const Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.share_outlined),
                        GestureDetector(
                          onTap: () => context.push('/membershipshared/${entrada.entrada}'),
                          child: const Text('Compartir Entrada', style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent))),
                        
                      ]),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _ticketCardDecoration() => const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(252, 251, 251, 0.969),
              Color.fromRGBO(243, 240, 240, 0.969),
              Color.fromRGBO(228, 230, 230, 1),
              Color.fromRGBO(216, 193, 151, 0.91)
            ]),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      );
}
