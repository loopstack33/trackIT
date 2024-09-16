import '../../../enums/dependencies.dart';
import '../../../widgets/phone_field.dart';

class PersonalDetail extends StatefulWidget {
  const PersonalDetail({super.key});

  @override
  State<PersonalDetail> createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail> {

  var profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getPersonalDetails();
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
                key: profileController.formKey2,
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
                            TextWidget(text:"Personal Detail", size: 18, fontFamily: "semi", color: AppColors.whiteColor),
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
                            TextWidget(text: "NAME", size: 12, fontFamily: "medium", color: AppColors.textColor),
                            const SizedBox(height: 5),
                            CustomField(hint: "Enter Name", controller: profileController.name,
                              validator: (value) {
                                if(value ==null || value.isEmpty){
                                  return "Please Enter Your Name";

                                }
                                return null;
                              },),
                            const SizedBox(height: 10),
                            TextWidget(text: "Contact No", size: 12, fontFamily: "medium", color: AppColors.textColor),
                            const SizedBox(height: 5),
                            PhoneTextField(
                              controller: profileController.phone,
                              hintText: 'Enter Phone no.',
                              countryCode: profileController.phoneCountryCode.value,
                              onChangeCountry: (value) {
                                profileController.changeCode(value);
                              },
                            ),
                            const SizedBox(height: 10),
                            TextWidget(text: "Date Of Birth", size: 12, fontFamily: "medium", color: AppColors.textColor),
                            const SizedBox(height: 5),
                            GestureDetector(
                              onTap: (){
                                profileController.selectDateTime(context);
                              },
                              child: AbsorbPointer(
                                  absorbing: true,
                                  child: CustomField(hint: "Select Date", controller: profileController.dob,
                                    suffixIcon: Icon(Icons.calendar_today_outlined,color: AppColors.iconColor),
                                    readOnly: true,
                                  )
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextWidget(text: "ADDRESS", size: 12, fontFamily: "medium", color: AppColors.textColor),
                            const SizedBox(height: 5),
                            CustomField(hint: "Enter Address", controller: profileController.address,maxLines: 4,keyboard: TextInputType.streetAddress,),
                            const SizedBox(height: 20),
                            CustomButton(onTap: (){
                              if (profileController.formKey2.currentState!.validate()) {
                                profileController.updatePersonalDetails();
                              }

                            }, text: "Update",
                              color: AppColors.primaryColor,textColor: AppColors.whiteColor,
                              borderColor: AppColors.primaryColor,
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
    );
  }
}
