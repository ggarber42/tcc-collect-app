import 'package:collect_app/dao/model_form_dao.dart';
import 'package:collect_app/models/model_form.dart';
import 'package:flutter/material.dart';

import '../widgets/base_widgets/main_bar.dart';
import '../widgets/base_widgets/main_drawer.dart';
import '../widgets/dialog_widgets/alert_widget_dialog.dart';
import '../widgets/dialog_widgets/dialog_new_field.dart';
import '../widgets/dummy_widgets/dummy_field_factory.dart';

class AddFormFieldsScreen extends StatefulWidget {
  static const routeName = '/add-fields';

  @override
  _AddFormFieldsScreenState createState() => _AddFormFieldsScreenState();
}

class _AddFormFieldsScreenState extends State<AddFormFieldsScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var fieldList = [];

  Future _showFieldDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DialogNewField();
        });
  }

  _showWarningDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertWidgetFormDialog('Adicione pelo menos um campo!');
        });
  }

  _handleFieldDialog(BuildContext context) async {
    var selectedValue = await _showFieldDialog(context);
    if (selectedValue == null) return;
    var newFormField =
        await DummyFactoryField().createFormField(context, selectedValue);
    setState(() {
      fieldList.add(newFormField);
    });
  }

  _handleSubmit() {
    var hasFieldAdded = fieldList.length > 0;
    if (!hasFieldAdded) {
      _showWarningDialog(context);
    }
    if (_formKey.currentState!.validate() && hasFieldAdded) {
      var modelName = _textEditingController.value.text;
      var modelForm = ModelForm(modelName);
      modelForm.addFields(fieldList);
      ModelFormDAO modelFormDao = ModelFormDAO();
      modelFormDao.add(modelForm);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(
        windowTitle: 'Novo modelo',
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _textEditingController,
                    decoration: InputDecoration(labelText: 'Nome do modelo *'),
                    textInputAction: TextInputAction.done,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Esse campo não pode ser nulo';
                      }
                      return null;
                    },
                  ),
                )),
            SingleChildScrollView(
              child: Container(
                height: 400,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: ListView.builder(
                    itemCount: fieldList.length,
                    itemBuilder: (ctx, index) {
                      return fieldList[index].getWidgetBody();
                    }),
              ),
            )
          ],
        ),
      ),
      drawer: MainDrawer(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton.extended(
            label: Text("Campo de entrada"),
            icon: Icon(Icons.add),
            onPressed: () => _handleFieldDialog(context)),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          color: Theme.of(context).colorScheme.primary,
          textColor: Colors.white,
          elevation: 0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Text('Salvar Modelo', style: TextStyle(fontSize: 20)),
          onPressed: _handleSubmit,
        ),
      ),
    );
  }
}
