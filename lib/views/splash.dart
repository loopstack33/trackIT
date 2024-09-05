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

  checkLoggedIn(){
    Future.delayed(const Duration(seconds: 2),(){
      Get.to(()=> const Welcome());
    });
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
