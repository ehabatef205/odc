import 'dart:io';

import 'package:flutter/material.dart';
import 'package:odc/models/product_id_model.dart';
import 'package:odc/modules/show_details/show_details_screen.dart';
import 'package:odc/shared/components/components.dart';
import 'package:odc/shared/components/constants.dart';
import 'package:odc/shared/network/remote/dio_helper.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  QRViewController? controller;

  final qrKey = GlobalKey(debugLabel: "QR");

  Barcode? barcode;

  ProductIdModel? productIdModel;

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }

    controller!.resumeCamera();
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
              borderWidth: 10,
              borderLength: MediaQuery.of(context).size.height * 0.07,
              borderRadius: 10,
              cutOutSize: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
          barcode != null
              ? Positioned(
            bottom: 10,
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                Colors.white70,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                onTap: () {
                  navigateTo(context,
                      ShowDetailsScreen(productIdModel: productIdModel!));
                },
                title: Text(
                 productIdModel!.data!.name!,
                  maxLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  productIdModel!.data!.description!,
                  maxLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 18),
                ),
                trailing: Container(
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    color: buttonColor,
                  ),
                  child: InkWell(
                      onTap: () {},
                      child: const Center(
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ))),
                )
              ),
            ),
          )
              : const SizedBox()
        ],
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((barcode) {
      setState(() => this.barcode = barcode);

      controller.stopCamera().whenComplete(() {
        getProductId();
      });
    });
  }

  void getProductId() {
    DioHelper.getData(
            url: "/api/v1/products/{productId}",
            query: {"productId": barcode},
            token: token)
        .then((value) {
      productIdModel = ProductIdModel.fromJson(value.data);
      print("Hi $productIdModel");
      controller!.stopCamera();
    }).catchError((error) {
      print(error.toString());
    });
  }
}
