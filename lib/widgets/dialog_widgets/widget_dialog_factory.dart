
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
        dialog = RadioWidgetFormDialog();
        break;
      default:
        dialog = AlertWidgetFormDialog();
        break;
    }
    return dialog;
  }

  


}