// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tutr_frontend/constants/app_colors.dart';

class PreviewPdfImage extends StatefulWidget {
  const PreviewPdfImage({
    super.key,
    required this.fileName,
    required this.pdfLink,
  });
  final String fileName;
  final String pdfLink;

  @override
  State<PreviewPdfImage> createState() => _PreviewPdfImageState();
}

class _PreviewPdfImageState extends State<PreviewPdfImage> {
  bool _showOverlays = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            AnimatedOpacity(
              opacity: _showOverlays ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                height: 80,
                decoration: BoxDecoration(color: AppColors.backgroundColor),
                alignment: Alignment.center,
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.white,
                        )),
                    Flexible(
                      child: Text(
                        widget.fileName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SfPdfViewer.network(
                widget.pdfLink,
                canShowPasswordDialog: true,
                interactionMode: PdfInteractionMode.pan,
                canShowPageLoadingIndicator: true,
                canShowScrollHead: true,
                canShowTextSelectionMenu: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
