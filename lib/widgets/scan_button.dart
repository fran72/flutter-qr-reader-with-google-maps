import 'package:flutter/material.dart';
import 'package:flutter_app_cap9/utils/utils.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.DEFAULT,);
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    return FloatingActionButton(
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666',
          'Cancel',
          true,
          ScanMode.QR,
        );
        // print(barcodeScanRes);
        if (barcodeScanRes != '-1') {
          // tenemos resuiltado para procesar

          scanListProvider
              .newScan(barcodeScanRes)
              .then((newScan) => launchUrlFuture(context, newScan));
        } else {
          // el user ha cancelado
          return;
        }
      },
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
