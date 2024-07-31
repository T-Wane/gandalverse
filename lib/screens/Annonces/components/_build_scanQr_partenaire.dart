import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gandalverse/components/default_btn.dart';
import 'package:gandalverse/screens/Annonces/components/annonceCard.dart';
import 'package:gandalverse/core/themes/images/appImages.dart';
import 'package:gandalverse/widgets/bottomSheet_cardContent.dart';
import 'package:gandalverse/widgets/customImageView.dart';

class buildScanQrPartenaire extends StatefulWidget {
  const buildScanQrPartenaire({
    super.key,
    required this.Color3,
  });

  final Color Color3;

  @override
  State<buildScanQrPartenaire> createState() => _buildScanQrPartenaireState();
}

class _buildScanQrPartenaireState extends State<buildScanQrPartenaire> {
  @override
  Widget build(BuildContext context) {
    return AnnonceCard(
        title: 'Scanner & Gagner',
        text: 'Scanner codeQr de nos partenaires et gagner des Go coins',
        imagePath: Images.black_barcodescanner,
        backColors: const [
          Colors.white,
          Colors.white,
        ],
        fit: BoxFit.contain,
        press: () {
          CardContentBottomSheet.show(context,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Scanner & Gagner",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15,
                          color: widget.Color3,
                          fontFamily: "Aller",
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AutoSizeText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla non tincidunt odio. Nunc id tellus lectus.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: widget.Color3.withOpacity(0.95),
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomImageView(
                          imagePath: Images.gvt,
                          fit: BoxFit.contain,
                          height: 40,
                          width: 40,
                        ),
                        AutoSizeText(
                          ' ??????? ',
                          maxLines: 1,
                          presetFontSizes: [23, 22, 20, 18, 15, 14],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: widget.Color3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DefaultButton(
                      backColor: Colors.purple.shade400,
                      text: 'Faire un scan',
                      elevation: 1.0,
                      textColor: Colors.white,
                      fontSize: 15,
                      height: 50,
                      press: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AiBarcodeScanner(
                              onDispose: () {
                                /// This is called when the barcode scanner is disposed.
                                /// You can write your own logic here.
                                debugPrint("Barcode scanner disposed!");
                              },
                              hideGalleryButton: true,
                              hideSheetDragHandler: true,
                              hideSheetTitle: true,
                              controller: MobileScannerController(
                                detectionSpeed: DetectionSpeed.noDuplicates,
                              ),
                              onDetect: (BarcodeCapture capture) {
                                /// The row string scanned barcode value
                                final String? scannedValue =
                                    capture.barcodes.first.rawValue;
                                debugPrint("Barcode scanned: $scannedValue");

                                /// The `Uint8List` image is only available if `returnImage` is set to `true`.
                                final Uint8List? image = capture.image;
                                debugPrint("Barcode image: $image");

                                /// row data of the barcode
                                final Object? raw = capture.raw;
                                debugPrint("Barcode raw: $raw");

                                /// List of scanned barcodes if any
                                final List<Barcode> barcodes = capture.barcodes;
                                debugPrint("Barcode list: $barcodes");
                              },
                              validator: (value) {
                                if (value.barcodes.isEmpty) {
                                  return false;
                                }
                                if (!(value.barcodes.first.rawValue
                                        ?.contains('flutter.dev') ??
                                    false)) {
                                  return false;
                                }
                                return true;
                              },
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              fit: BoxFit.contain,
              setCircle: false,
              image: Images.black_barcodescanner);
        },
        textColor: Colors.black,
        titleColor: widget.Color3);
  }
}
