import '../../../enums/dependencies.dart';

class AddBank extends StatefulWidget {
  final bool isEdit;
  const AddBank({super.key, this.isEdit=false});

  @override
  State<AddBank> createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {
  @override
  Widget build(BuildContext context) {

    var walletController = Get.put(WalletController());
    var autController = Get.put(AuthController());

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
                        TextWidget(text: widget.isEdit? "Edit Bank":"Add Bank", size: 18, fontFamily: "semi", color: AppColors.whiteColor),
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
                      key: walletController.formKey1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(text: "ACCOUNT HOLDER NAME", size: 12, fontFamily: "medium", color: AppColors.textColor),
                          const SizedBox(height: 5),
                          CustomField(hint: "Enter Name", controller: walletController.accountHolder,
                            validator: (value) {
                              if(value ==null || value.isEmpty){
                                return "Please Enter Your Account Name";

                              }
                              return null;
                            },),
                          const SizedBox(height: 10),
                          TextWidget(text: "ACCOUNT NUMBER", size: 12, fontFamily: "medium", color: AppColors.textColor),
                          const SizedBox(height: 5),
                          CustomField(hint: "Enter Account Number", controller: walletController.accountNumber,
                            validator: (value) {
                              if(value ==null || value.isEmpty){
                                return "Please Enter Your Account Number";

                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextWidget(text: "SELECT BANK", size: 12, fontFamily: "medium", color: AppColors.textColor),
                          const SizedBox(height: 5),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("banks").snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                if(snapshot.data!.docs.isNotEmpty){
                                  return Obx(()=>CustomDropDown(
                                      dropdownValue: walletController.bank.value,
                                      onChanged: (value){
                                        walletController.setBank(value);
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
                                return  Center(
                                  child: CircularProgressIndicator(color: AppColors.primaryColor),
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomButton(onTap: (){
                            if (walletController.formKey1.currentState!.validate()) {
                              if(widget.isEdit){
                                walletController.updateBank(autController.userID.value);
                              }
                              else{
                                walletController.addBank(autController.userID.value);
                              }
                            }
                          }, text:widget.isEdit? "Update" : "Add",
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
