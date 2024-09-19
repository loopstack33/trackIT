import 'package:intl/intl.dart';
import 'package:track_it/enums/dependencies.dart';
import 'package:uuid/uuid.dart';

class WalletController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var docID = "".obs;
  final formKey2 = GlobalKey<FormState>();
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

  var statues = ["Paid","Un-Paid"];
  var selectedStatus = "Paid".obs;

  changeStatus(val){
    selectedStatus.value = val;
    update();
  }

  var isBill = false.obs;

  changeBill(bool? value){
    isBill.value = !isBill.value;
    update();
  }

  selectDateTime(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(1980),
        lastDate: DateTime(2500),
        builder: (BuildContext? context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme:  ColorScheme.dark(
                  primary: AppColors.primaryColor,
                  onPrimary: Colors.white,
                  surface: AppColors.whiteColor,
                  onSurface: AppColors.primaryColor
              ),
              dialogBackgroundColor: AppColors.primaryLight,
            ),
            child: child!,
          );
        });

    if(newSelectedDate!=null){
      selectedDate.value = newSelectedDate;
      date.text = DateFormat("dd-MM-yyyy").format(selectedDate.value);
      update();
    }

  }

  FirebaseFirestore store = FirebaseFirestore.instance;

  addTransaction(userID){
    BotToast.showCustomLoading(
        clickClose: false,
        allowClick: false,
        backButtonBehavior: BackButtonBehavior.none,
        ignoreContentClick: false,
        animationDuration:
        const Duration(milliseconds:  200),
        animationReverseDuration:
        const Duration(milliseconds: 200),
        backgroundColor: const Color(0x42000000),
        align: Alignment.center,
        toastBuilder: (cancelFunc) {
          return CustomLoading(cancelFunc: cancelFunc);
        });

    String id = const Uuid().v1().toString();
    store.collection("transactions").doc(id).set({
      "amount" : int.parse(amount.text.toString().trim()),
      "date": selectedDate.value,
      "isBill": isBill.value,
      "name" : name.text.trim().toString(),
      "type" : selectedType.value,
      "userID": userID,
      "uid": id,
      "paid": selectedStatus.value=="Paid"? true : false
    }).then((val){

      if(selectedType.value=="Expense" && selectedStatus.value=="Paid"){
        store.collection("users").doc(userID).update({
          "balance": FieldValue.increment(-int.parse(amount.text.toString().trim()))
        });
      }
      else if(selectedType.value=="Income" && selectedStatus.value=="Paid"){
        store.collection("users").doc(userID).update({
          "balance": FieldValue.increment(int.parse(amount.text.toString().trim()))
        });
      }

      BotToast.closeAllLoading();
      BotToast.showText(text: "Transaction Added Successfully");
      resetValues();
      Get.back();

    }).catchError((e){
      BotToast.closeAllLoading();
      BotToast.showText(text: "Failed to add transaction.");
    });
  }

  updateTransaction2(id,userID){

    BotToast.showCustomLoading(
        clickClose: false,
        allowClick: false,
        backButtonBehavior: BackButtonBehavior.none,
        ignoreContentClick: false,
        animationDuration:
        const Duration(milliseconds:  200),
        animationReverseDuration:
        const Duration(milliseconds: 200),
        backgroundColor: const Color(0x42000000),
        align: Alignment.center,
        toastBuilder: (cancelFunc) {
          return CustomLoading(cancelFunc: cancelFunc);
        });

    store.collection("transactions").doc(id).update({
      "date": selectedDate.value,
      "name": name.text.toString().trim(),
    }).then((val){

      resetValues();
      BotToast.closeAllLoading();
      BotToast.showText(text: "Transaction Updated Successfully");
      Get.back();
      Get.back();


    }).catchError((e){
      Get.back();
      BotToast.closeAllLoading();
      BotToast.showText(text: "Failed to update transaction.");
    });
  }

  updateTransaction(id,userID,amount){

    BotToast.showCustomLoading(
        clickClose: false,
        allowClick: false,
        backButtonBehavior: BackButtonBehavior.none,
        ignoreContentClick: false,
        animationDuration:
        const Duration(milliseconds:  200),
        animationReverseDuration:
        const Duration(milliseconds: 200),
        backgroundColor: const Color(0x42000000),
        align: Alignment.center,
        toastBuilder: (cancelFunc) {
          return CustomLoading(cancelFunc: cancelFunc);
        });

    store.collection("transactions").doc(id).update({
      "paid": true,
    }).then((val){

      store.collection("users").doc(userID).update({
        "balance": FieldValue.increment(-int.parse(amount.toString().trim()))
      });

      BotToast.closeAllLoading();
      BotToast.showText(text: "Transaction Updated Successfully");
      Get.back();
      Get.back();

    }).catchError((e){
      Get.back();
      BotToast.closeAllLoading();
      BotToast.showText(text: "Failed to update transaction.");
    });
  }

  addIncome(id,userID,amount,type){

    BotToast.showCustomLoading(
        clickClose: false,
        allowClick: false,
        backButtonBehavior: BackButtonBehavior.none,
        ignoreContentClick: false,
        animationDuration:
        const Duration(milliseconds:  200),
        animationReverseDuration:
        const Duration(milliseconds: 200),
        backgroundColor: const Color(0x42000000),
        align: Alignment.center,
        toastBuilder: (cancelFunc) {
          return CustomLoading(cancelFunc: cancelFunc);
        });

    store.collection("transactions").doc(id).update({
      "paid": true,
    }).then((val){

      if(type=="Income"){
        store.collection("users").doc(userID).update({
          "balance": FieldValue.increment(int.parse(amount.toString().trim()))
        });
      }
      else{
        store.collection("users").doc(userID).update({
          "balance": FieldValue.increment(-int.parse(amount.toString().trim()))
        });
      }


      BotToast.closeAllLoading();
      BotToast.showText(text: "Transaction Updated Successfully");
      Get.back();
      Get.back();

    }).catchError((e){
      Get.back();
      BotToast.closeAllLoading();
      BotToast.showText(text: "Failed to update transaction.");
    });
  }

  resetValues(){
    name.text = "";
    amount.text = "";
    isBill.value = false;
    selectedType.value = "Income";
    selectedDate.value = DateTime.now();
    date.text = "";
    selectedStatus.value = "Paid";
    docID.value = "";
    update();
  }

  setValues(QueryDocumentSnapshot<Object?> data){
    name.text = data.get("name");
    selectedDate.value = (data.get("date") as Timestamp).toDate();
    date.text = DateFormat("dd-MM-yyyy").format((data.get("date") as Timestamp).toDate());
    docID.value = data.get("uid");
    update();
  }

  final formKey1 = GlobalKey<FormState>();
  TextEditingController accountHolder = TextEditingController();
  TextEditingController accountNumber = TextEditingController();

  var bank = "".obs;
  var docID2 = "".obs;

  setBank(value){
    bank.value = value;
    update();
  }

  setBankDetails(QueryDocumentSnapshot<Object?> data){
    bank.value = data.get("bankID");
    docID2.value = data.get("uid");
    accountNumber.text = data.get("accountNumber");
    accountHolder.text = data.get("accountHolder");
    update();
  }
  resetBankDetails(){
    bank.value = "";
    docID2.value = "";
    accountNumber.text = "";
    accountHolder.text = "";
    update();
  }

  addBank(userID){
    BotToast.showCustomLoading(
        clickClose: false,
        allowClick: false,
        backButtonBehavior: BackButtonBehavior.none,
        ignoreContentClick: false,
        animationDuration:
        const Duration(milliseconds:  200),
        animationReverseDuration:
        const Duration(milliseconds: 200),
        backgroundColor: const Color(0x42000000),
        align: Alignment.center,
        toastBuilder: (cancelFunc) {
          return CustomLoading(cancelFunc: cancelFunc);
        });

    String id = const Uuid().v1().toString();
    store.collection("users").doc(userID).collection("banks").doc(id).set({
      "date": DateTime.now(),
      "accountNumber" : accountNumber.text.trim().toString(),
      "accountHolder" : accountHolder.text.toString().trim(),
      "userID": userID,
      "uid": id,
      "bankID": bank.value
    }).then((val){

      BotToast.closeAllLoading();
      BotToast.showText(text: "Bank Added Successfully");
      accountNumber.text = "";
      accountHolder.text = "";
      bank.value = "";
      update();
      Get.back();

    }).catchError((e){
      BotToast.closeAllLoading();
      BotToast.showText(text: "Failed to add bank.");
    });
  }

  updateBank(userID){
    BotToast.showCustomLoading(
        clickClose: false,
        allowClick: false,
        backButtonBehavior: BackButtonBehavior.none,
        ignoreContentClick: false,
        animationDuration:
        const Duration(milliseconds:  200),
        animationReverseDuration:
        const Duration(milliseconds: 200),
        backgroundColor: const Color(0x42000000),
        align: Alignment.center,
        toastBuilder: (cancelFunc) {
          return CustomLoading(cancelFunc: cancelFunc);
        });

    store.collection("users").doc(userID).collection("banks").doc(docID2.value).update({
      "accountNumber" : accountNumber.text.trim().toString(),
      "accountHolder" : accountHolder.text.toString().trim(),
      "bankID": bank.value
    }).then((val){

      BotToast.closeAllLoading();
      BotToast.showText(text: "Bank Updated Successfully");
      accountNumber.text = "";
      accountHolder.text = "";
      bank.value = "";
      update();
      Get.back();

    }).catchError((e){
      BotToast.closeAllLoading();
      BotToast.showText(text: "Failed to update bank.");
    });
  }

}