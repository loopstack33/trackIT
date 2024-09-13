import 'package:track_it/views/welcome.dart';

import '../enums/dependencies.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoggedIn();
  }

  var autController = Get.put(AuthController());

  checkLoggedIn() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var isLoggedIn = prefs.getBool("IsLoggedIn");
    var uid = prefs.getString("uid");

    if(isLoggedIn==true && uid!=null){
      autController.getUserData(uid,true);
    }
    else if(isLoggedIn==false && uid=="null" ){
      Future.delayed(const Duration(seconds: 1),(){
        Get.offAll(()=> const Login(from: false));
      });
    }
    else{
      Future.delayed(const Duration(seconds: 1),(){
        Get.offAll(()=> const Welcome());
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          gradient: AppColors.splashGradient
        ),
        child: Center(
          child: TextWidget(text: "TrackIt", size: 50, fontFamily: "bold", color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
