
import '../../../enums/dependencies.dart';

class AccountDetail extends StatefulWidget {
  const AccountDetail({super.key});

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {

  var profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getAccountDetails();
  }

  @override
  Widget build(BuildContext context) {

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
                key: profileController.formKey1,
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
                                child: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,size: 20)
                            ),
                            TextWidget(text:"Account Detail", size: 18, fontFamily: "semi", color: AppColors.whiteColor),
                            const SizedBox()
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
                            TextWidget(text: "EMAIL", size: 12, fontFamily: "medium", color: AppColors.textColor),
                            const SizedBox(height: 5),
                            CustomField(hint: "Enter Email", controller: profileController.email,
                              suffixIcon: const Icon(Icons.mail_rounded,color: Color(0xFF979C9E)),
                              readOnly: true,
                              keyboard: TextInputType.emailAddress,),
                            const SizedBox(height: 10),
                            TextWidget(text: "PASSWORD", size: 12, fontFamily: "medium", color: AppColors.textColor),
                            const SizedBox(height: 5),
                            Obx(()=>CustomField(hint: "Enter Password", controller: profileController.password,
                              suffixIcon: GestureDetector(
                                  onTap: (){
                                    profileController.togglePassword();
                                  },
                                  child: Icon(profileController.pass.value? Icons.remove_red_eye_rounded:Icons.remove_red_eye_outlined,
                                      color: const Color(0xFF979C9E))
                              ),
                              obscure: profileController.pass.value,
                              readOnly: true,)),
                            const SizedBox(height: 10),
                            TextWidget(text: "MONTHLY INCOME", size: 12, fontFamily: "medium", color: AppColors.textColor),
                            const SizedBox(height: 5),
                            CustomField(hint: "Enter Income", controller: profileController.income,
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
                            CustomField(hint: "Enter Balance", controller: profileController.balance,
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
                              if (profileController.formKey2.currentState!.validate()) {
                                profileController.updateAccountDetails();
                              }
                            }, text: "Update",
                              color: AppColors.primaryColor,textColor: AppColors.whiteColor,
                              borderColor: AppColors.primaryColor,),
                            const SizedBox(height: 20),
                          ],
                        )
                    ),
                  ],
                )
            )
        ),
      ),
    );
  }

}
