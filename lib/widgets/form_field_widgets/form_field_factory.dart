import 'form_field_interface.dart';
import 'form_field_radio.dart';

class FormFieldFactory {
  FormField createFormField(String name){
    if(name == 'radio'){
      FormFieldRadio radio = new FormFieldRadio();
      radio.showCreateDialog();
      return radio;
    }
    return new FormFieldRadio();
  }
}