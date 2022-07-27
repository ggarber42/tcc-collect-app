import 'form_field_interface.dart';

class FormFieldRadio extends FormField {
  String? name;

  FormFieldRadio();

  FormFieldRadio.dialog(this.name);

  @override
  void showCreateDialog() {
    // TODO: implement showCreateDialog
    print('kkk');
  }
 

}