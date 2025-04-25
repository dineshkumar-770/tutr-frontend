import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/models/arguments/preview_notes_args.dart';
import 'package:tutr_frontend/themes/styles/custom_text_styles.dart';
import 'package:tutr_frontend/utils/helpers.dart';
import 'package:tutr_frontend/widgets/teacher_view/preview_image_notes_widget.dart';

class PreviewNotes extends StatefulWidget {
  const PreviewNotes({super.key, required this.previewNotesArgs});
  final PreviewNotesArgs previewNotesArgs;

  @override
  State<PreviewNotes> createState() => _PreviewNotesState();
}

class _PreviewNotesState extends State<PreviewNotes> {
  PageController pageController = PageController();
  void _setStatusBarDark() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  // void _makeStatusBarTransparent() {
  //   SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(
  //       statusBarColor: Colors.transparent,
  //       statusBarIconBrightness: Brightness.light,
  //     ),
  //   );
  // }

  void _resetStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void initState() {
    _setStatusBarDark();
    // _makeStatusBarTransparent();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    _resetStatusBar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: widget.previewNotesArgs.notesURL.length,
              controller: pageController,
              itemBuilder: (context, index) {
                if (locatorDI<Helper>()
                        .extractMediaTypeFromUrl(widget.previewNotesArgs.notesURL[index].noteUrl ?? "") ==
                    S3URLType.IMAGE) {
                  return PreviewImageNotesWidget(
                    imageURL: widget.previewNotesArgs.notesURL[index].noteUrl ?? "",
                    fileName: widget.previewNotesArgs.notesURL[index].fileName ?? "",
                  );
                } else if (locatorDI<Helper>()
                        .extractMediaTypeFromUrl(widget.previewNotesArgs.notesURL[index].noteUrl ?? "") ==
                    S3URLType.PDF) {
                  return SafeArea(
                    child: SfPdfViewer.network(
                      widget.previewNotesArgs.notesURL[index].noteUrl ?? "",
                      canShowPasswordDialog: true,
                      interactionMode: PdfInteractionMode.pan,
                      canShowPageLoadingIndicator: true,
                      canShowScrollHead: true,
                      canShowTextSelectionMenu: false,
                      enableTextSelection: false,
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      "Invalid file format uploaded.",
                      style: CustomTextStyles.errorTextStyle,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
