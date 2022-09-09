import 'package:collect_app/utils/arguments.dart';
import 'package:collect_app/widgets/form_widgets/form_body.dart';
import 'package:flutter/material.dart';

import '../../widgets/base_widgets/main_bar.dart';

class ModelDetailScreen extends StatelessWidget {
  static const routeName = '/model_detail';

  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context)!.settings.arguments as ModelArguments;
    return Scaffold(
      appBar: MainBar(),
      body: FormBody(
        arguments.modelId,
        arguments.modelName,
      ),
    );
  }
}
