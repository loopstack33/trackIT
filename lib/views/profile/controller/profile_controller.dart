
import 'package:intl/intl.dart';
import 'package:track_it/enums/dependencies.dart';

class ProfileController extends GetxController{
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController income = TextEditingController();
  TextEditingController balance = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  final phoneDialCode = '+92'.obs;
  final phoneCountryCode = 'PK'.obs;
  var selectedDate = DateTime.now().obs;
  FirebaseFirestore store = FirebaseFirestore.instance;
  var authController = Get.put(AuthController());

  var pass = true.obs;
  togglePassword(){
    pass.value = !pass.value;
    update();
  }

  changeCode(Country value){
    phoneCountryCode.value = value.code;
    phoneDialCode.value = '+${value.dialCode}';
    update();
  }

  selectDateTime(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(1980),
        lastDate: DateTime.now(),
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
      dob.text = DateFormat("dd-MM-yyyy").format(selectedDate.value);
      update();
    }

  }

  getAccountDetails(){
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

    store.collection('users').doc(authController.userID.value).get()
      .then((val){
      income.text = val.get("income").toString();
      balance.text = val.get("balance").toString();
      password.text = val.get("password").toString();
      email.text = val.get("email").toString();
      update();
      BotToast.closeAllLoading();
    }).catchError((e){
      BotToast.closeAllLoading();});
  }

  updateAccountDetails(){
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

    store.collection('users').doc(authController.userID.value).update({
      "income": FieldValue.increment(int.parse(income.text.toString().trim())),
      "balance": FieldValue.increment(int.parse(balance.text.toString().trim())),
    })
    .then((val){
      Get.back();
      BotToast.closeAllLoading();
      BotToast.showText(text: "Account Details Updated Successfully");
    })
    .catchError((e){
      BotToast.closeAllLoading();
      BotToast.showText(text: "Failed to update details $e.");
    });
  }

  getPersonalDetails(){
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

    store.collection('users').doc(authController.userID.value).get()
        .then((val){
      name.text = val.get("name").toString();
      address.text = val.get("address").toString();
      phone.text = val.get("phone").toString();
      if(val.get("dob").toString()!=""){
        selectedDate.value = (val.get("dob") as Timestamp).toDate();
        dob.text = DateFormat("dd-MM-yyyy").format((val.get("dob") as Timestamp).toDate());
      }
      phoneCountryCode.value = val.get("countryCode").toString();
      phoneDialCode.value = '+${val.get("dialCode")}';
      update();
      BotToast.closeAllLoading();
    }).catchError((e){
      BotToast.closeAllLoading();});
  }

  updatePersonalDetails(){
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

    store.collection('users').doc(authController.userID.value).update({
      "address": address.text==""? "": address.text,
      "phone": phone.text==""? "": phone.text,
      "name": name.text,
      "dob": dob.text==""? "": selectedDate.value,
      "countryCode": phoneCountryCode.value,
      "dialCode": phoneDialCode.value,
    })
        .then((val){
      Get.back();
      BotToast.closeAllLoading();
      BotToast.showText(text: "Personal Details Updated Successfully");
    })
        .catchError((e){
      BotToast.closeAllLoading();
      BotToast.showText(text: "Failed to update details $e.");
    });
  }

}