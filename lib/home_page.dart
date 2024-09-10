import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String result = "";

  Future<void> startBarcodeScan() async{
    try{
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#FF009688',
          'Cancel Scan',
          true,
          ScanMode.DEFAULT);
      log("print $barcodeScanRes");
      if(barcodeScanRes.isNotEmpty){
        if(mounted){
          setState(() {
            result = barcodeScanRes;
          });
        }
      }


    }catch(e){
      log("Error $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Barcode Scanner', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: ()=> startBarcodeScan(), child: const Text('Scan BARCODE / QR')),
            const SizedBox(height: 10),
            Text('Your Scan Result will be display below:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            Text(result.toString()),
          ],
        ),
      ),
    );
  }
}
