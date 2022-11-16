import 'package:flutter/material.dart';

import '../../facades/share.dart';
import '../../facades/firestore.dart';
import '../../utils/helper.dart';
import '../dialog_widgets/delete_model_dialog.dart';

class UploadedImageTile extends StatelessWidget {
  final String imageUrl;
  final VoidCallback updateState;
  final fireFacade = FirestoreFacade();
  final shareFacade = ShareFacade();

  UploadedImageTile(this.imageUrl, this.updateState);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton.icon(
                  onPressed: () async {
                    final res = await showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return DeleteModelDialog(
                            0,
                            'Deseja deletar a imagem?',
                          );
                        });
                    if (res) {
                      await fireFacade.deleteImage(imageUrl);
                      Helper.showSnack(context, 'Imagem deletada');
                      updateState();
                    }
                  },
                  icon: Icon(Icons.delete_forever),
                  label: Text(''),
                ),
                TextButton.icon(
                  onPressed: () {
                    shareFacade.shareImageFromNetwork(imageUrl);
                  },
                  icon: Icon(Icons.download),
                  label: Text(''),
                )
              ]),
              Container(
                height: 250.0,
                alignment: Alignment.center,
                child: Image.network(imageUrl),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
