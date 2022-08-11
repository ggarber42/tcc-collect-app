
import '../base_widgets/base_factory.dart';
import '../dialog_widgets/form_dialog_interface.dart';
import '../dialog_widgets/alert_widget_dialog.dart';
import '../dialog_widgets/text_widget_dialog.dart';
import '../dialog_widgets/radio_widget_dialog.dart';

class WidgetDialogFactory {
  final String selectedValue;

  WidgetDialogFactory(this.selectedValue);
  
  dynamic makeWidget() {
    var dialog;
    switch(selectedValue){
      case 'text':
        dialog = TextWidgetFormDialog();
        break;
      case 'radio':
        dialog = AlertWidgetFormDialog();
        break;
      default:
        dialog = AlertWidgetFormDialog();
        break;
    }
    return dialog;
  }

  


}