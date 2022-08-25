import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/models/product_id_model.dart';
import 'package:odc/odc_web/modules/scan/cubit/cubit.dart';
import 'package:odc/odc_web/modules/scan/cubit/states.dart';
import 'package:odc/odc_web/modules/show_details/cubit/states.dart';
import 'package:odc/odc_web/modules/show_details/show_details_screen.dart';
import 'package:odc/shared/components/components.dart';
import 'package:odc/shared/components/constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScanCubit(),
      child: BlocConsumer<ScanCubit, ScanStates>(
        listener: (context, state) {
          if (state is LoadingScanState) {
            ScanCubit.get(context).start();
          }else if(state is SuccessScanState){
          }
        },
        builder: (context, state) {
          ScanCubit cubit = ScanCubit.get(context);
          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                QRView(
                  key: cubit.qrKey,
                  onQRViewCreated: (controller) =>
                      cubit.onQRViewCreated(controller),
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.white,
                    borderWidth: 10,
                    borderLength: MediaQuery.of(context).size.height * 0.07,
                    borderRadius: 10,
                    cutOutSize: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cubit.barcode != null
                          ? Colors.white70
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      onTap: () {
                        navigateTo(
                            context,
                            ShowDetailsScreen(
                                productIdModel: cubit.productIdModel!));
                      },
                      title: Text(
                        cubit.barcode != null
                            ? "${cubit.productIdModel!.data!.name}"
                            : "",
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Text(
                        cubit.barcode != null
                            ? "${cubit.productIdModel!.data!.description}"
                            : "",
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      trailing: cubit.barcode != null
                          ? Container(
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
                          : const SizedBox(),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
