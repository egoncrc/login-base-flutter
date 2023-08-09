import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';


import '../../domain/domain.dart';
import '../../../shared/shared.dart';
import '../providers/providers.dart';

class TicketSharedScreen extends StatelessWidget {
  final String entrada;

  TicketSharedScreen(
      {Key? key,
      
      required this.entrada})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compartir Entrada'),
      ),
      body: _ticketSharedView(entrada: entrada)
      );
    
  }

 }

class _ticketSharedView extends ConsumerWidget {

  final String entrada;
  const _ticketSharedView({required this.entrada});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenShotController = ScreenshotController();
    final List<Entrada> tikects =ref.watch(membershipsProvider).entradas.toList()..where((ent) => ent.entrada == entrada);
    
    return Container(
      decoration: _tickedViewDecoration(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Screenshot(
                  controller: screenShotController,
                  child: TicketCardShared(entrada: tikects[0]),                  
                  ),
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.black,
                onPressed: () async {
                  final image = await screenShotController.capture();

                  await saveAndShare(image!);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 130, vertical: 25),
                  child: const Text(
                    'Compartir',
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
 
 

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/ticketCSH.png');
    image.writeAsBytesSync(bytes);
    await Share.shareXFiles([XFile(image.path)]);
  }


BoxDecoration _tickedViewDecoration() => const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          Color.fromRGBO(120, 120, 120, 1),
          Color.fromRGBO(218, 223, 223, 1),
          // Color.fromRGBO(21,176,179, 1),
        ]));
