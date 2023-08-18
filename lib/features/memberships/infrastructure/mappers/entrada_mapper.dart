


import 'package:socios_herediano/features/memberships/infrastructure/models/entrada_model.dart';

import '../../domain/entities/entities.dart';

class EntradaMapper {
    

    static Entrada entradaJsonToEntity( EntradaModel entradaModel ) => Entrada(
    entrada: entradaModel.entrada,
    jornada: entradaModel.juego.jornada,
    fecha: entradaModel.juego.fecha,
    hora: entradaModel.juego.hora,
    visita: entradaModel.juego.equipo.nombre,
    torneo: entradaModel.juego.torneo.nombre,
    estadio: entradaModel.juego.estadio.nombre,
    zona: entradaModel.membresia.zonasilla.zona.nombre,
    asiento: entradaModel.membresia.zonasilla.silla.numero,
  );
}