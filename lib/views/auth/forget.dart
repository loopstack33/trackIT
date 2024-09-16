import '../../enums/dependencies.dart';

class Forget extends StatelessWidget {
  const Forget({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Get.put(AuthController());

    return Scaffold(
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
              key: authController.formKey3,
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
                              child:const Icon(Icons.arrow_back_ios_new,color: Colors.white)
                          ),
                          TextWidget(text:"FORGET PASSWORD", size: 18, fontFamily: "semi", color: AppColors.whiteColor),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        TextWidget(text: "EMAIL", size: 12, fontFamily: "medium", color: AppColors.textColor),
                        const SizedBox(height: 5),
                        CustomField(hint: "Enter Email", controller: authController.forgetEmail,
                            suffixIcon: const Icon(Icons.mail_rounded,color: Color(0xFF979C9E)),
                          validator: (value) {
                            if(value ==null || value.isEmpty){
                              return "Email Cannot Be Empty";
                            }
                            else if((RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value) ==
                                false) ){
                              return "Enter A Valid Email";
                            }

                            return null;
                          },),
                        const SizedBox(height: 10),
                        Center(child: TextWidget(text: "Don’t worry!  We will send a verification code  to reset your password", size: 12, fontFamily: "regular", color: AppColors.textColor)),
                        const SizedBox(height: 20),
                        CustomButton(onTap: (){
                          if (authController.formKey3.currentState!.validate()) {
                            authController.signIn();
                          }
                        }, text: "Send",
                          color: AppColors.primaryColor,textColor: AppColors.whiteColor,
                          borderColor: AppColors.primaryColor,),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),


                ],
              )
            )
        ),
      ),
    );
  }
}
