import 'form_widget_interface.dart';
import 'form_widget_radio.dart';

class FormWidgetFactory {
  FormWidget createFormField(String name){
    if(name == 'radio'){
      FormWidgetRadio radio = new FormWidgetRadio();
      radio.showCreateDialog();
      return radio;
    }
    return new FormWidgetRadio();
  }
}