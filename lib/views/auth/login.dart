import 'package:track_it/views/auth/forget.dart';
import '../../enums/dependencies.dart';

class Login extends StatefulWidget {
  final bool from;
  const Login({super.key,this.from=true});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var authController = Get.put(AuthController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController.loadUserEmailPassword();
  }

  @override
  Widget build(BuildContext context) {


    return Obx(()=> Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            image: DecorationImage(
                image: AssetImage(AppImages.top),
                alignment: Alignment.topCenter
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              Padding(padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if(widget.from)...[
                        GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: Image.asset(AppImages.arrow,width: 20,height: 20,)
                        ),
                      ],

                      TextWidget(text:"LOGIN", size: 18, fontFamily: "semi", color: AppColors.whiteColor),
                      Icon(Icons.help,color: AppColors.whiteColor),
                    ],
                  )),
              const SizedBox(height: 60),
              Container(
                width: MediaQuery.of(context).size.width*0.9,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.blackColor.withOpacity(0.08),
                          blurRadius: 35,
                          offset: const Offset(0,22)
                      )
                    ]
                ),
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: authController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      TextWidget(text: "EMAIL", size: 12, fontFamily: "medium", color: AppColors.textColor),
                      const SizedBox(height: 5),
                      CustomField(hint: "Enter Email", controller: authController.email,suffixIcon: Image.asset(AppImages.email,width: 25,height: 25,color: const Color(0xFF979C9E)),
                        validator: (value) {
                          if(value ==null || value.isEmpty){
                            return "Please Enter Your Email";

                          }
                          else if((RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value) ==
                              false) ){
                            return "Please Enter Valid Email";
                          }

                          return null;
                        },
                        keyboard: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      TextWidget(text: "PASSWORD", size: 12, fontFamily: "medium", color: AppColors.textColor),
                      const SizedBox(height: 5),
                      CustomField(hint: "Enter Password", controller: authController.password,
                          suffixIcon: GestureDetector(
                              onTap: (){
                                authController.togglePassword();
                              },
                              child: Icon(authController.pass.value? Icons.remove_red_eye_rounded:Icons.remove_red_eye_outlined,color: const Color(0xFF979C9E))
                          ),
                          obscure: authController.pass.value,
                        validator: (value) {
                          if(value ==null || value.isEmpty){
                            return "Please Enter Your Password";

                          }
                          return null;
                        },),
                      const SizedBox(height: 10),
                      GestureDetector(
                          onTap: (){
                            Get.to(()=> const Forget());
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextWidget(text: "Forgot Password?", size: 12, fontFamily: "regular", color: AppColors.primaryColor),
                          )
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            activeColor: AppColors.primaryColor,
                            value: authController.rememberMe.value,
                            onChanged: authController.handleRememberMe,
                            side:  BorderSide(
                              color: AppColors.textColor,
                            ),
                          ),
                          Text('Remember me',style: MyTextStyle.montserratRegular(12, AppColors.textColor)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomButton(onTap: (){
                        if (authController.formKey.currentState!.validate()) {
                          authController.signIn();
                        }
                      }, text: "Login",
                        color: AppColors.primaryColor,textColor: AppColors.whiteColor,
                        borderColor: AppColors.primaryColor,),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: (){
                          authController.resetVal();
                          Get.to(()=> const Register());
                        },
                        child: Center(
                          child: Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "Don’t have any account?",
                                        style: MyTextStyle.montserratRegular(12, AppColors.blackColor)
                                    ),
                                    TextSpan(
                                        text: " Register",
                                        style: MyTextStyle.montserratSemiBold(12, AppColors.primaryColor)
                                    ),
                                  ]
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ),


            ],
          )
        ),
      ),
    ));
  }
}
