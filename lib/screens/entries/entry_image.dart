import 'dart:io';
import 'package:collect_app/models/entry_image.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'camera_preview.dart';
import 'entry_confirmation.dart';
import '../../utils/helper.dart';
import '../../widgets/base_widgets/bottom_button.dart';
import '../../models/entry_value.dart';
import '../../widgets/base_widgets/main_bar.dart';

class EntryImageScreen extends StatefulWidget {
  final int modelId;
  final String entryName;
  final List<EntryValue> values;
  final List<EntryImage> images;
  final StackHelper<dynamic> imgFields;

  EntryImageScreen(
    this.modelId,
    this.entryName,
    this.values,
    this.images,
    this.imgFields,
  );

  @override
  State<EntryImageScreen> createState() => _EntryImageScreenState();
}

class _EntryImageScreenState extends State<EntryImageScreen> {
  dynamic _currentImgField;
  XFile? imageFile;

  void setImage(newValue) {
    setState(() {
      imageFile = newValue;
    });
  }

  Widget _imagePreview() {
    if (imageFile == null) {
      return Text('Sem imagens adicionadas');
    }
    return Container(
      height: 250.0,
      alignment: Alignment.center,
      child: Image.file(
        File(imageFile!.path),
        fit: BoxFit.scaleDown,
      ),
    );
  }

  @override
  void initState() {
    _currentImgField = widget.imgFields.pop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(),
      body: Column(
        children: [
          Container(
              child: Column(
                children: [
                  Text(_currentImgField['name']),
                  _imagePreview(),
                ],
              ),
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 35,
              )),
          ElevatedButton(
            child: const Icon(Icons.camera_alt),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CameraPreviewScreen(setImage),
                fullscreenDialog: true,
              ),
            ),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: BottomButton('Avançar', () {
                      if (widget.imgFields.isEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EntryConfirmationScreen(
                                widget.modelId,
                                widget.entryName,
                                widget.values, [
                              EntryImage.fromField(
                                _currentImgField['name'],
                                imageFile,
                              )
                            ]),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EntryImageScreen(
                              widget.modelId,
                              widget.entryName,
                              widget.values,
                              [
                                ...widget.images,
                                EntryImage.fromField(
                                  _currentImgField['name'],
                                  imageFile,
                                )
                              ],
                              widget.imgFields,
                            ),
                          ),
                        );
                      }
                    }))),
          )
        ],
      ),
    );
  }
}
