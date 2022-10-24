import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class CameraPreviewScreen extends StatefulWidget {
  final Function printHandler;
  CameraPreviewScreen(this.printHandler);

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  List<CameraDescription> cameras = [];
  CameraController? _cameraController;
  Size? size;
  XFile? image;

  @override
  void initState() {
    super.initState();
    _loadCameras();
  }

  void _loadCameras() async {
    try {
      cameras = await availableCameras();
      _startCamera();
    } on CameraException catch (e) {
      debugPrint(e.description);
    }
  }

  void _startCamera() async {
    if (cameras.isEmpty) {
      debugPrint('Câmera não foi encontrada');
    } else {
      final CameraController cameraController = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      _cameraController = cameraController;

      try {
        await cameraController.initialize();
      } on CameraException catch (e) {
        debugPrint(e.description);
      }

      if (mounted) {
        setState(() {});
      }
    }
  }

  Widget _cameraPreviewWidget(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const Text(
        'Widget para Câmera que não está disponível',
        style: TextStyle(
          color: Colors.white,
        ),
      );
    } else {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CameraPreview(_cameraController!),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.black.withOpacity(0.5),
              child: IconButton(
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: _takePicture,
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _imagePreview(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image.file(
          File(image!.path),
          fit: BoxFit.contain,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: CircleAvatar(
            radius: 32,
            backgroundColor: Colors.black.withOpacity(0.5),
            child: IconButton(
              icon: const Icon(
                Icons.save,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => _savePicture(context),
            ),
          ),
        )
      ],
    );
  }

  void _takePicture() async {
    if (_cameraController!.value.isInitialized) {
      try {
        XFile file = await _cameraController!.takePicture();
        if (mounted)
          setState(() {
            image = file;
          });
      } on CameraException catch (e) {
        debugPrint(e.description);
      }
    }
  }

  void _savePicture(BuildContext context) async {
    widget.printHandler(image);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Câmera'),
          backgroundColor: Colors.grey[900],
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          color: Colors.grey[900],
          child: Center(
            child: SizedBox(
              width: size!.width - 50,
              height: size!.height - (size!.height / 3),
              child: image == null
                  ? _cameraPreviewWidget(context)
                  : _imagePreview(context),
            ),
          ),
        ));
  }
}
