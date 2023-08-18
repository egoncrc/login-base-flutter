import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../memberships/domain/domain.dart';

class TicketCardShared extends StatelessWidget {
  final Entrada entrada;
  final String nombreSocio;

  const TicketCardShared({
    Key? key,
    required this.entrada, required this.nombreSocio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ticketCompartido(entrada.jornada, entrada.zona, entrada.asiento,
            entrada.torneo,entrada.visita, entrada.entrada, nombreSocio),
      ],
    );
  }

  Widget _ticketCompartido(int jornada, String zona, String silla,
      String torneo, String equipo,String entrada, String nombreInvitado) {
    return Container(
      decoration: _ticketCardSharedDecoration(),
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
                Text('$torneo',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800])),
                Text('Jornada #$jornada',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800])),
                Text('$zona - Asiento: $silla',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 25, 69))),
                Text('C.S.Herediano VS $equipo',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 159, 112, 4))),
                const Text('*******ENTRADA COMPARTIDA*******',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 118, 6, 6))),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  color: Colors.black,
                ),
                QrImageView(
                  data: entrada,
                  size: 350,
                  version: QrVersions.auto,
                ),
                const Divider(
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Compartido por socio(a): $nombreInvitado',
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 118, 6, 6))),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration _ticketCardSharedDecoration() => const BoxDecoration(
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
