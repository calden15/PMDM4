import 'package:flutter/material.dart';
import 'package:qr_scan/providers/db_provider.dart';

import '../models/scan_model.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipusSeleccionat = "http";

  //Afegeix un nou element a la DB
  Future<ScanModel> nouScan(String valor) async {
    final nouScan = ScanModel(valor: valor);
    final id = await DBProvider.db.insertScan(nouScan);
    nouScan.id = id;
    //Si l'element es igual al tipus seleccionat l'afegeix a la llista
    if (nouScan.tipus == tipusSeleccionat) {
      this.scans.add(nouScan);
      notifyListeners();
    }
    return nouScan;
  }

  //Carrega a la llista tots els elements
  carregaScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  //Carrega a la llista nous elements pel tipus
  carregaScansPerTipus(String tipus) async {
    final scans = await DBProvider.db.getScanByTipus(tipus);
    this.scans = [...scans];
    this.tipusSeleccionat = tipus;
    notifyListeners();
  }

  //Esborra tots els elements de la DB i buida la llista
  esborraTots() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  //Esborra segons l'id a la DB i a la llista
  esborraPerId(int id) async {
    await DBProvider.db.deleteScanById(id);
    this.scans.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
