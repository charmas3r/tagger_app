import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanningPage extends StatefulWidget {
  const QRScanningPage({Key? key}) : super(key: key);

  @override
  _QRScanningPage createState() => _QRScanningPage();
}

class _QRScanningPage extends State<QRScanningPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: Stack(
        children: [
          MobileScanner(
              allowDuplicates: false,
              onDetect: (barcode, args) {
                if (barcode.rawValue != null) {
                  const snackBar = SnackBar(
                      content: Text('Successfully scanned barcode!')
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }),
          //overlays a semi-transparent rounded square border that is 60% of screen width
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.white38, width: 4.0),
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              ),
            ),
          ),
        ],
      )
    );
  }
}