
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:track_it/enums/dependencies.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController{

  var payList = [
    {"name":"Pay Contact","image": AppImages.person},
    {"name":"Bills","image": AppImages.bill},
    {"name":"Internet","image": AppImages.internet},
    {"name":"Bank Transfer","image": AppImages.transfer},
    {"name":"Donation","image": AppImages.charity},
  ];

  final contactList = RxList<Contact>([]);
  final selectedContact = "".obs;
  final contactFetchLoader = false.obs;
  final contactAccessPermission = Rxn<PermissionStatus>();

  var biller = "".obs;

  setBiller(value){
    biller.value = value;
    update();
  }

  checkContactAccessPermission() async {
    contactAccessPermission.value = await Permission.contacts.status;
    if (contactAccessPermission.value == PermissionStatus.granted) {
      await getContactList();
    }
  }

  getContactsAccessPermission() async {
    if (contactAccessPermission.value == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    } else {
      contactAccessPermission.value = await Permission.contacts.request();
    }
    if (contactAccessPermission.value == PermissionStatus.granted) {
      await getContactList();
    }
  }

  getContactList() async {
    contactFetchLoader(true);
    update();
    contactList.clear();
    contactList.value = await FastContacts.getAllContacts(
      fields: [
        ContactField.displayName,
        ContactField.phoneNumbers,
      ],
      batchSize: 100,
    );
    contactFetchLoader(false);
    update();
  }

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

  quickPay(userID,bill,String from) async {
    var bankName;
    var billerName;
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

    if(from.contains("Transfer")){
      bankName = await store.collection("banks").doc(bank.value).get().then((val){
        return val.get("name");
      });

    }

    if(from=="Bills"){
      billerName = await store.collection("biller").doc(biller.value).get().then((val){
        return val.get("name");
      });
    }


    String id = const Uuid().v1().toString();
    store.collection("transactions").doc(id).set({
      "amount" : int.parse(amount.text.toString().trim()),
      "date": selectedDate.value,
      "isBill":bill? true : false,
      "name" : from.contains("Contact")? "Paid To (${name.text.trim().toString()})":
        from.contains("Transfer")? "Bank Transfer ($bankName)":
        from=="Bills"? "Bill Payment ($billerName)"
       : name.text.trim().toString(),
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


  var bank = "".obs;

  setBank(value){
    bank.value = value;
    update();
  }

  resetValues(){
    name.text = "";
    selectedContact.value = "";
    amount.text = "";
    selectedType.value = "Income";
    selectedDate.value = DateTime.now();
    date.text = "";
    selectedStatus.value = "Paid";
    biller.value = "";
    bank.value = "";
    update();
  }

}