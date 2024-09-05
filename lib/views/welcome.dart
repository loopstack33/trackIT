
import '../enums/dependencies.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.whiteColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(AppImages.welcome,width: MediaQuery.of(context).size.width),
              const SizedBox(height: 20),
              TextWidget(text: "Spend Smarter Save More", size: 35, fontFamily: "bold", color: AppColors.primaryColor,textAlign: TextAlign.center,),
              const SizedBox(height: 20),
              CustomButton(onTap: (){
                Get.to(()=> const Register());
                },
                text: "Get Started",
                isGradient: true,gradient: AppColors.splashGradient,
                borderColor: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.25),
                      blurRadius: 5,
                      offset: const Offset(2, 8)
                  )
                ], ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  Get.to(() => const Login());
                },
                child: Text.rich(
                    TextSpan(
                        children: [
                          TextSpan(
                              text: "Already Have An Account?",
                              style: MyTextStyle.montserratRegular(14, AppColors.blackColor)
                          ),
                          TextSpan(
                              text: " Login",
                              style: MyTextStyle.montserratMedium(14, AppColors.primaryColor)
                          )
                        ]
                    )
                )
              )
            ],
          )
        ),
      ),
    );
  }
}
