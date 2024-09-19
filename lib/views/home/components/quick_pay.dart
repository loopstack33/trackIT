import 'package:track_it/views/home/components/contacts_list.dart';
import '../../../enums/dependencies.dart';

class QuickPay extends StatelessWidget {
  final String from;
  const QuickPay({super.key, required this.from});

  @override
  Widget build(BuildContext context) {

    var autController = Get.put(AuthController());
    var homeController = Get.put(HomeController());

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
                        TextWidget(text:"Quick Pay", size: 18, fontFamily: "semi", color: AppColors.whiteColor),
                        const SizedBox()
                      ],
                    )),
                const SizedBox(height: 30),
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
                      key: homeController.formKey2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(from.contains("Contact"))...[
                            TextWidget(text: "SELECT CONTACT", size: 12, fontFamily: "medium", color: AppColors.textColor),
                            const SizedBox(height: 10),
                            Obx(()=> homeController.selectedContact.value==""? CustomButton(onTap: (){
                              Get.to(()=> const ContactsList());
                            }, text: "Select Contact Person",
                              textColor: AppColors.primaryColor,
                              width: MediaQuery.of(context).size.width*0.8,
                              height: 40,
                              size: 14,):
                            CustomField(hint: "Enter Name", controller: homeController.name,
                              suffixIcon: GestureDetector(
                                onTap: (){
                                  Get.to(()=> const ContactsList());
                                },
                                child: Icon(Icons.perm_contact_cal_sharp,color: AppColors.iconColor,),
                              ),
                              validator: (value) {
                                if(value ==null || value.isEmpty){
                                  return "Please Enter Your Name";

                                }
                                return null;
                              },)),
                          ]
                          else if(from=="Bills")...[
                            TextWidget(text: "SELECT BILLER", size: 12, fontFamily: "medium", color: AppColors.textColor),
                            const SizedBox(height: 5),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance.collection("billers").snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  if(snapshot.data!.docs.isNotEmpty){
                                    return Obx(()=>CustomDropDown(
                                        dropdownValue: homeController.biller.value,
                                        onChanged: (value){
                                          homeController.setBiller(value);
                                        },
                                        hint: "Select Biller",
                                        items2: snapshot.data!.docs.map((value) {
                                          return DropdownMenuItem<String>(
                                              value: value.get('id'),
                                              child:  Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: AppColors.primaryLight,
                                                    radius: 20,
                                                    backgroundImage: NetworkImage(value.get("image")),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  TextWidget(text: value.get("name"), size: 14, fontFamily: "regular", color: AppColors.blackColor),
                                                ],
                                              )
                                          );
                                        }).toList()
                                    ));
                                  }
                                  else {
                                    return const NoData(name: "No Banks Found");
                                  }

                                }
                                else if(snapshot.hasError){
                                  return Container();
                                }
                                else {
                                  return Container();
                                }
                              },
                            ),
                          ]
                          else if(from.contains("Transfer"))...[
                              TextWidget(text: "SELECT BANK", size: 12, fontFamily: "medium", color: AppColors.textColor),
                              const SizedBox(height: 5),
                              StreamBuilder(
                                stream: FirebaseFirestore.instance.collection("banks").snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    if(snapshot.data!.docs.isNotEmpty){
                                      return Obx(()=>CustomDropDown(
                                          dropdownValue: homeController.bank.value,
                                          onChanged: (value){
                                            homeController.setBank(value);
                                          },
                                          hint: "Select Bank",
                                          items2: snapshot.data!.docs.map((value) {
                                            return DropdownMenuItem<String>(
                                                value: value.get('id'),
                                                child:  Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: AppColors.primaryLight,
                                                      radius: 20,
                                                      backgroundImage: NetworkImage(value.get("image")),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    TextWidget(text: value.get("name"), size: 14, fontFamily: "regular", color: AppColors.blackColor),
                                                  ],
                                                )
                                            );
                                          }).toList()
                                      ));
                                    }
                                    else {
                                      return const NoData(name: "No Banks Found");
                                    }

                                  }
                                  else if(snapshot.hasError){
                                    return Container();
                                  }
                                  else {
                                    return Container();
                                  }
                                },
                              ),
                            ]
                          else...[
                            TextWidget(text: "NAME", size: 12, fontFamily: "medium", color: AppColors.textColor),
                            const SizedBox(height: 5),
                            CustomField(hint: "Enter Name", controller: homeController.name,
                              validator: (value) {
                                if(value ==null || value.isEmpty){
                                  return "Please Enter Your Name";

                                }
                                return null;
                              },),
                          ],
                          const SizedBox(height: 10),
                          TextWidget(text: "AMOUNT", size: 12, fontFamily: "medium", color: AppColors.textColor),
                          const SizedBox(height: 5),
                          CustomField(hint: "Enter Amount", controller: homeController.amount,
                            validator: (value) {
                              if(value ==null || value.isEmpty){
                                return "Please Enter Your Amount";
                              }
                              else if(int.parse(value.toString().trim())==0){
                                return "Amount Should be greater than zero";
                              }
                              return null;
                            },
                            inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[0-9]")),],
                            keyboard: TextInputType.number,),
                          const SizedBox(height: 10),
                          TextWidget(text: "DATE", size: 12, fontFamily: "medium", color: AppColors.textColor),
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: (){
                              homeController.selectDateTime(context);
                            },
                            child: AbsorbPointer(
                                absorbing: true,
                                child: CustomField(hint: "Select Date", controller: homeController.date,
                                  suffixIcon: Icon(Icons.calendar_today_outlined,color: AppColors.iconColor,),
                                  readOnly: true,
                                  validator: (value) {
                                    if(value ==null || value.isEmpty){
                                      return "Please Select Date";

                                    }
                                    return null;
                                  },)
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextWidget(text: "TYPE", size: 12, fontFamily: "medium", color: AppColors.textColor),
                          const SizedBox(height: 5),
                          Obx(()=> CustomDropDown(dropdownValue: homeController.selectedType.value,items: homeController.types,onChanged: (val){
                            homeController.changeType(val);
                          },)),
                          const SizedBox(height: 10),
                          TextWidget(text: "STATUS", size: 12, fontFamily: "medium", color: AppColors.textColor),
                          const SizedBox(height: 5),
                          Obx(()=> CustomDropDown(dropdownValue: homeController.selectedStatus.value,items: homeController.statues,onChanged: (val){
                            homeController.changeStatus(val);
                          },)),
                          const SizedBox(height: 20),
                          CustomButton(onTap: (){
                            if(from.contains("Contact") && homeController.selectedContact.value==""){
                              BotToast.showText(text: "Contact Person Required!!!");
                            }
                            else if(from=="Bills" && homeController.biller.value==""){
                              BotToast.showText(text: "Select Biller First!!");
                            }
                            else if(from.contains("Transfer") && homeController.bank.value==""){
                              BotToast.showText(text: "Select Bank First!!");
                            }
                            else{
                              if (homeController.formKey2.currentState!.validate()) {
                                FirebaseService.checkBalance(autController.userID.value, homeController.amount.text.toString().trim()).then((val){
                                  if(val==""){
                                    homeController.quickPay(autController.userID.value,
                                        from.contains("Contact")? false:
                                        from=="Bills"? true:
                                        from=="Internet"? true:
                                        from.contains("Transfer")? false:
                                        from=="Donation"? false:
                                        false,from);
                                  }
                                  else{
                                    BotToast.showSimpleNotification(title: val,titleStyle: MyTextStyle.montserratRegular(14, AppColors.whiteColor),
                                        backgroundColor: AppColors.outComeColor);
                                  }
                                });


                              }
                            }

                          }, text: "Submit",
                            color: AppColors.whiteColor,textColor: AppColors.primaryColor,
                            borderColor: AppColors.primaryColor,)
                        ],
                      )
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
