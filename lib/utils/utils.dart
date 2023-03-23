import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/scan_model.dart';

//Obri l'URL o mostra el mapa
void launchUrl(BuildContext context, ScanModel scan) async {
  final _url = scan.valor;
  if (scan.tipus == "http") {
    if (!await launch(_url)) throw 'Could not launch $_url';
  } else {
    Navigator.pushNamed(context, "mapa", arguments: scan);
  }
}
