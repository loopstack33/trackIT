import 'package:track_it/enums/dependencies.dart';

class WalletController extends GetxController {

  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController date = TextEditingController();
  var selectedDate = DateTime.now().obs;

  var types = ["Income","Expense"];
  var selectedType = "Income".obs;

  changeType(val){
    selectedType.value = val;
    update();
  }

}