import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/models/product_id_model.dart';
import 'package:odc/modules/scan/cubit/states.dart';
import 'package:odc/shared/components/constants.dart';
import 'package:odc/shared/network/remote/dio_helper.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanCubit extends Cubit<ScanStates> {
  ScanCubit() : super(InitialScanState());

  static ScanCubit get(context) => BlocProvider.of(context);

  QRViewController? controller;

  final qrKey = GlobalKey(debugLabel: "QR");

  ProductIdModel? productIdModel;

  Barcode? barcode;

  void start() async {
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }

    controller!.resumeCamera();
  }

  void onQRViewCreated(QRViewController controller) {
    emit(LoadingScanState());
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      barcode = event;
      DioHelper.getData(
              url: "/api/v1/products/{productId}",
              query: {"productId": barcode},
              token: token)
          .then((value) {
        productIdModel = ProductIdModel.fromJson(value.data);
        this.controller?.stopCamera();
        emit(SuccessScanState());
      }).catchError((error) {
        print(error.toString());
      });
    });

    emit(ClosedScanState());
  }
}
