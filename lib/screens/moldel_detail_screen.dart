import 'package:collect_app/widgets/custom_widgets/form_body.dart';
import 'package:flutter/material.dart';

import '../widgets/base_widgets/main_bar.dart';

class ModelDetailScreen extends StatelessWidget {
  static const routeName = '/model_detail';

  @override
  Widget build(BuildContext context) {
    var modelId = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: MainBar(),
      body: FormBody(modelId as int),
    );
  }
}
