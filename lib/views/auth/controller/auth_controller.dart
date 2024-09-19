
import 'package:track_it/enums/dependencies.dart';


class AuthController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController email2 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController cfPassword = TextEditingController();
  TextEditingController income = TextEditingController();
  TextEditingController balance = TextEditingController();

  TextEditingController forgetEmail = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();

  var pass = true.obs;
  togglePassword(){
    pass.value = !pass.value;
    update();
  }

  var pass1 = true.obs;
  togglePassword1(){
    pass1.value = !pass1.value;
    update();
  }
  var pass2 = true.obs;
  togglePassword2(){
    pass2.value = !pass2.value;
    update();
  }

  resetVal(){
    pass1.value = true;
    pass2.value = true;
    password2.text="";
    cfPassword.text="";
    email2.text = "";
    name.text = "";
    income.text = "";
    balance.text = "";
    update();
  }

  var rememberMe = false.obs;

  ////////// HANDLE REMEMBER ME FUNCTION \\\\\\\\\\
  void handleRememberMe(bool? value) async {

    SharedPref.saveRememberMe(value!);

    rememberMe.value = !rememberMe.value ;
    update();

    if(value==true){
     SharedPref.saveEmail(email.text);
     SharedPref.saveUserPassword(password.text);
    }
    else{
     SharedPref.saveEmail("");
     SharedPref.saveUserPassword("");
    }

  }

  ////////// LOAD USER AND PASSWORD \\\\\\\\\\
  void loadUserEmailPassword() async {
    var username = await SharedPref.getEmail();
    var password2 = await SharedPref.getUserPassword();
    var rememberMe2 = await SharedPref.getRememberMe();

    if (rememberMe2!=null && rememberMe2==true) {
      rememberMe.value = true;
      email.text = username.toString();
      password.text = password2.toString();
      update();
    }

    else {
      rememberMe.value = false;
      email.text = "";
      password.text = "";
      update();
    }
  }


  final auth = FirebaseAuth.instance;
  var userID = "".obs;
  var userEmail = "".obs;
  var userName = "".obs;
  var userIncome = 0.obs;
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  //SIGN IN
  void signIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
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

    try {
      await auth
          .signInWithEmailAndPassword(email: email.text.toString().trim(), password: password.text.toString().trim())
          .then((uid) {

        if(auth.currentUser?.emailVerified==true){

          firebaseFireStore.collection('users').doc(auth.currentUser!.uid.toString()).get().then((value) {
            if(value.exists){
              if(value.get("status").toString()=="Active"){

                preferences.setString("uid", auth.currentUser!.uid.toString());
                preferences.setBool("IsLoggedIn", true);
                preferences.setString("email", email.text.toString().trim());
                preferences.setString("password", password.text.toString().trim());
                getUserData(auth.currentUser!.uid.toString(),false);
                BotToast.closeAllLoading();


              }
              else{
                BotToast.closeAllLoading();
                BotToast.showText(text: "Your Account Status is Pending, Contact Admin Support");
              }
            }
            else{
              BotToast.closeAllLoading();
              BotToast.showText(text: "No User Record Found.");
            }
          });
        }
        else{
          sendEmailVerification(false);
        }

      });
    } on FirebaseAuthException catch (error) {
      BotToast.showText(text: error.message.toString());
      BotToast.closeAllLoading();

    }
  }

  //SIGN UP
  void signUp() async {

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

    try {
      await auth.createUserWithEmailAndPassword(email: email2.text.toString(),
          password: cfPassword.text.toString())
          .then((value) {

        firebaseFireStore.collection("users").doc(auth.currentUser!.uid.toString()).set({
          "email": email2.text.toString().trim(),
          "password": cfPassword.text.toString().trim(),
          "uid": auth.currentUser!.uid.toString(),
          "date": DateTime.now(),
          "type": "user",
          "address": "",
          "dob": "",
          "dialCode": "",
          "countryCode": "",
          "phone": "",
          "name": name.text.toString().trim(),
          "status": "Active",
          "balance": int.parse(balance.text.toString().trim()),
          "income": int.parse(income.text.toString().trim())
        });

        sendEmailVerification(true);

      });
    } on FirebaseAuthException catch (error) {
      BotToast.closeAllLoading();
      BotToast.showText(text: "${error.message}");
    }
  }

  //EMAIL VERIFICATION
  Future<void> sendEmailVerification(from) async{
    try{

      await auth.currentUser?.sendEmailVerification().then((value) {
        BotToast.closeAllLoading();

        if(from){
          BotToast.showText(text: "Email sent, Please verify in order to login");
          Future.delayed(const Duration(seconds: 1),(){
            Get.offAll(()=> const Login());
          });
        }
        else{
          BotToast.showText(text: "Email resent, Please verify in order to login");
        }


      }).catchError((e) {
        BotToast.closeAllLoading();

        if(e.toString().contains("firebase_auth/too-many-requests]")){
          BotToast.showText(text: "Please wait a minute before sending another verification request.");
        }
        else{
          BotToast.showText(text: "$e");
        }

      });

    }
    on FirebaseAuthException catch (e){
      BotToast.closeAllLoading();
      if(e.code=="too-many-requests"){
        BotToast.showText(text: "Please wait a minute before sending another verification request.");
      }
      else{
        BotToast.showText(text: "${e.message}");
      }

    }
  }

  //GET USER DATA
  Future<void> getUserData(uid,from) async{
    if(from){
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
    }


    SharedPreferences preferences = await SharedPreferences.getInstance();

    await firebaseFireStore
        .collection('users').
    doc(uid)
        .get()
        .then((value) {

      if(value.exists){
        preferences.setString("uid", value.data()!["uid"]);
        preferences.setString("email", value.data()!["email"]);
        preferences.setString("name", value.data()!["name"]);
        userID.value = auth.currentUser!.uid.toString();
        userEmail.value = value.data()!["email"].toString();
        userName.value = value.data()!["name"].toString();
        userIncome.value = int.parse(value.data()!["income"].toString());
        update();
        BotToast.closeAllLoading();
        Future.delayed(const Duration(seconds: 1),(){
          Get.offAll(()=> const Dashboard());
        });
      }
    }).catchError((e) async {
      BotToast.closeAllLoading();
    });
  }

  Future<void> sendResetLink(context) async{
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

    try {
      await auth.sendPasswordResetEmail(email: forgetEmail.text.toString()).then((value) {
        BotToast.showText(text: "A Password Reset Link Has Been Sent To  Your Email Please Check This Can Take A Few Minutes.",);
        forgetEmail.text="";
        update();
        BotToast.closeAllLoading();
        Get.back();

      });
    }  on FirebaseAuthException catch (error) {
      BotToast.closeAllLoading();
      BotToast.showText(text: error.message.toString());


    }

  }
}