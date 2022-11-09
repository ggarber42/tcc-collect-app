import 'package:flutter/material.dart';

import '../../facades/firestore.dart';
import '../../widgets/custom_widgets/main_bar.dart';

class ListImageFielsScreen extends StatefulWidget {
  final String userId;
  static const routeName = '/list_image_files';

  ListImageFielsScreen(this.userId);

  @override
  State<ListImageFielsScreen> createState() => _ListImageFielsScreenState();
}

class _ListImageFielsScreenState extends State<ListImageFielsScreen> {
  final fireFacade = FirestoreFacade();

  @override
  void initState() {
    fireFacade.getImagesFromUser(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(),
    );
  }
}
