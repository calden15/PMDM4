import 'package:flutter/material.dart';

import '../widgets/scan_tiles.dart';

class MapasScreen extends StatelessWidget {
  const MapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Mostra una llista de coordenades
    return ScanTiles(tipus: "geo");
  }
}
