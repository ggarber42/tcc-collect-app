import 'package:flutter/material.dart';

import '../../facades/firestore.dart';
import '../../widgets/base_widgets/error_warning.dart';
import '../../widgets/custom_widgets/main_bar.dart';
import '../../widgets/custom_widgets/uploaded_image_tile.dart';

class ListImageFielsScreen extends StatefulWidget {
  final String userId;
  static const routeName = '/list_image_files';

  ListImageFielsScreen(this.userId);

  @override
  State<ListImageFielsScreen> createState() => _ListImageFielsScreenState();
}

class _ListImageFielsScreenState extends State<ListImageFielsScreen> {
  final fireFacade = FirestoreFacade();

  updateList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(),
      body: FutureBuilder(
          future: fireFacade.getImagesFromUser(widget.userId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data as List;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx, i) => UploadedImageTile(data[i], updateList),
              );
            } else if (snapshot.hasError) {
              return ErrorWarning();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
