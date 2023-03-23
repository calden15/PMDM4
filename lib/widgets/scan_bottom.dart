import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        //print('Botó polsat!');
        //String barcodeScanRes = "geo:39.4192308,3.2596469";
        //String barcodeScanRes = "https://google.cat";

        //Llegeix un codi QR i el guarda a un String
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            "#3DC3EF", "Cancel·lar", false, ScanMode.QR);
        print(barcodeScanRes);

        //Crea un Scan, el guarda a la DB i el mostra
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        ScanModel nouScan = ScanModel(valor: barcodeScanRes);
        scanListProvider.nouScan(barcodeScanRes);
        launchUrl(context, nouScan);
      },
    );
  }
}
