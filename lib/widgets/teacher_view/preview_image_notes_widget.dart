// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tutr_frontend/constants/app_colors.dart';

import 'package:tutr_frontend/core/common/custom_loading_widget.dart';

class PreviewImageNotesWidget extends StatefulWidget {
  const PreviewImageNotesWidget({
    super.key,
    required this.imageURL,
    required this.fileName,
  });
  final String imageURL;
  final String fileName;

  @override
  State<PreviewImageNotesWidget> createState() => _PreviewImageNotesWidgetState();
}

class _PreviewImageNotesWidgetState extends State<PreviewImageNotesWidget> {
  bool _showOverlays = true;

  void _toggleOverlay() {
    setState(() {
      _showOverlays = !_showOverlays;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleOverlay,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Stack(
            children: [
              PhotoView(
                imageProvider: NetworkImage(
                  widget.imageURL,
                ),
                enableRotation: false,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 2.5,
                loadingBuilder: (context, event) {
                  return CustomLoadingWidget();
                },
                basePosition: Alignment.center,
                initialScale: PhotoViewComputedScale.contained,
              ),
              AnimatedOpacity(
                opacity: _showOverlays ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black26, Colors.black45, Colors.black87],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter)),
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
            ],
          ),
        ),
      ),
    );
  }
}
