import '../../enums/dependencies.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    var authController = Get.put(AuthController());

    return Obx(()=> Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            image: DecorationImage(
                image: AssetImage(AppImages.top),
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth
            )
        ),
        child: SingleChildScrollView(
          child: Form(
            key: authController.formKey2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                Padding(padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back_ios_new,color: Colors.white)
                        ),
                        TextWidget(text:"REGISTER", size: 18, fontFamily: "semi", color: AppColors.whiteColor),
                        Icon(Icons.help,color: AppColors.whiteColor),
                      ],
                    )),
                const SizedBox(height: 40),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(text: "NAME", size: 12, fontFamily: "medium", color: AppColors.textColor),
                        const SizedBox(height: 5),
                        CustomField(hint: "Enter Name", controller: authController.name,
                          validator: (value) {
                            if(value ==null || value.isEmpty){
                              return "Please Enter Your Name";

                            }
                            return null;
                          },),
                        const SizedBox(height: 10),
                        TextWidget(text: "EMAIL", size: 12, fontFamily: "medium", color: AppColors.textColor),
                        const SizedBox(height: 5),
                        CustomField(hint: "Enter Email", controller: authController.email2,suffixIcon:const Icon(Icons.mail_rounded,color: Color(0xFF979C9E)),
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
                          keyboard: TextInputType.emailAddress,),
                        const SizedBox(height: 10),
                        TextWidget(text: "PASSWORD", size: 12, fontFamily: "medium", color: AppColors.textColor),
                        const SizedBox(height: 5),
                        CustomField(hint: "Enter Password", controller: authController.password2,
                            suffixIcon: GestureDetector(
                                onTap: (){
                                  authController.togglePassword1();
                                },
                                child: Icon(authController.pass1.value? Icons.remove_red_eye_rounded:Icons.remove_red_eye_outlined,color: const Color(0xFF979C9E))
                            ),
                            obscure: authController.pass1.value,
                          validator: (value) {
                            if(value ==null || value.isEmpty){
                              return "Please Enter Your Password";
                            }
                            else if(value.length < 6){
                              return "Password must be 6 characters long";
                            }

                            return null;
                          },),
                        const SizedBox(height: 10),
                        TextWidget(text: "CONFIRM PASSWORD", size: 12, fontFamily: "medium", color: AppColors.textColor),
                        const SizedBox(height: 5),
                        CustomField(hint: "Enter Confirm Password", controller: authController.cfPassword,
                            suffixIcon: GestureDetector(
                                onTap: (){
                                  authController.togglePassword2();
                                },
                                child: Icon(authController.pass2.value? Icons.remove_red_eye_rounded:Icons.remove_red_eye_outlined,color: const Color(0xFF979C9E))
                            ),
                            obscure: authController.pass2.value,
                          validator: (value) {
                            if(value ==null || value.isEmpty){
                              return "Please Enter Your Confirm Password";
                            }
                            else if(value.toString()!=authController.password2.text.toString()){
                              return "Password did not matched";
                            }
                            return null;
                          },),
                        const SizedBox(height: 10),
                        TextWidget(text: "MONTHLY INCOME", size: 12, fontFamily: "medium", color: AppColors.textColor),
                        const SizedBox(height: 5),
                        CustomField(hint: "Enter Income", controller: authController.income,
                          validator: (value) {
                            if(value ==null || value.isEmpty){
                              return "Please Enter Your Income";

                            }
                            else if(int.parse(value.toString().trim())==0){
                              return "Income Should be Greater than Zero";
                            }
                            return null;
                          },
                          inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[0-9]")),],
                          keyboard: TextInputType.number,),
                        const SizedBox(height: 10),
                        TextWidget(text: "AVAILABLE BALANCE", size: 12, fontFamily: "medium", color: AppColors.textColor),
                        const SizedBox(height: 5),
                        CustomField(hint: "Enter Balance", controller: authController.balance,
                          validator: (value) {
                            if(value ==null || value.isEmpty){
                              return "Please Enter Your Available Balance";

                            }
                            else if(int.parse(value.toString().trim())==0){
                              return "Balance Should be Greater than Zero";
                            }
                            return null;
                          },
                          inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[0-9]")),],
                          keyboard: TextInputType.number,),
                        const SizedBox(height: 20),
                        CustomButton(onTap: (){
                          if (authController.formKey2.currentState!.validate()) {
                            authController.signUp();
                          }

                        }, text: "Register",
                          color: AppColors.primaryColor,textColor: AppColors.whiteColor,
                          borderColor: AppColors.primaryColor,),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Center(
                            child: Text.rich(
                                TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "Already have any account?",
                                          style: MyTextStyle.montserratRegular(12, AppColors.blackColor)
                                      ),
                                      TextSpan(
                                          text: " Login",
                                          style: MyTextStyle.montserratSemiBold(12, AppColors.primaryColor)
                                      ),
                                    ]
                                )
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    )
                ),
              ],
            )
          )
        ),
      ),
    ));
  }
}
