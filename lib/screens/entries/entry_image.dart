import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../../utils/helper.dart';
import 'camera_preview.dart';
import '../../widgets/base_widgets/bottom_button.dart';
import '../../widgets/custom_widgets/main_bar.dart';

class EntryImageScreen extends StatefulWidget {
  final imageWidgetData;
  final Function addValue;

  EntryImageScreen(this.imageWidgetData, this.addValue);

  @override
  State<EntryImageScreen> createState() => _EntryImageScreenState();
}

class _EntryImageScreenState extends State<EntryImageScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(),
      body: Column(
        children: [
          Container(
              child: _imagePreview(),
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
                child: BottomButton(
                  'Avançar',
                  () {
                    if (imageFile != null) {
                      widget.addValue([
                        {
                          'widgetId': widget.imageWidgetData['widgetId'],
                          'name': widget.imageWidgetData['name'],
                          'type': 'img',
                          'value': imageFile
                        }
                      ]);
                      Navigator.of(context).pop();
                      Helper.showSnack(
                        context,
                        'Imagem adicionada!',
                      );
                    } else {
                      Helper.showWarningDialog(
                        context,
                        'É necessário adicionar uma imagem',
                      );
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
