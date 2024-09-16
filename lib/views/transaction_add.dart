import '../enums/dependencies.dart';

class TransactionAdd extends StatelessWidget {
  final bool isEdit;
  const TransactionAdd({super.key,this.isEdit=false});

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
                      TextWidget(text:isEdit?"Update Transcation":"Add Transaction", size: 18, fontFamily: "semi", color: AppColors.whiteColor),
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
                    key: walletController.formKey,
                    child:isEdit? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(text: "NAME", size: 12, fontFamily: "medium", color: AppColors.textColor),
                        const SizedBox(height: 5),
                        CustomField(hint: "Enter Name", controller: walletController.name,
                          validator: (value) {
                            if(value ==null || value.isEmpty){
                              return "Please Enter Your Name";

                            }
                            return null;
                          },),
                        const SizedBox(height: 10),
                        TextWidget(text: "DATE", size: 12, fontFamily: "medium", color: AppColors.textColor),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: (){
                            walletController.selectDateTime(context);
                          },
                          child: AbsorbPointer(
                              absorbing: true,
                              child: CustomField(hint: "Select Date", controller: walletController.date,
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
                        const SizedBox(height: 20),
                        CustomButton(onTap: (){
                          if (walletController.formKey.currentState!.validate()) {
                            if(isEdit){
                              walletController.updateTransaction2(walletController.docID.value, autController.userID.value);
                            }
                           else{
                              walletController.addTransaction(autController.userID.value);
                            }
                          }
                        }, text:isEdit? "Update" :"Submit",
                          color: AppColors.whiteColor,textColor: AppColors.primaryColor,
                          borderColor: AppColors.primaryColor,)
                      ],
                    ):
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(text: "NAME", size: 12, fontFamily: "medium", color: AppColors.textColor),
                        const SizedBox(height: 5),
                        CustomField(hint: "Enter Name", controller: walletController.name,
                          validator: (value) {
                            if(value ==null || value.isEmpty){
                              return "Please Enter Your Name";

                            }
                            return null;
                          },),
                        const SizedBox(height: 10),
                        TextWidget(text: "AMOUNT", size: 12, fontFamily: "medium", color: AppColors.textColor),
                        const SizedBox(height: 5),
                        CustomField(hint: "Enter Amount", controller: walletController.amount,
                          validator: (value) {
                            if(value ==null || value.isEmpty){
                              return "Please Enter Your Amount";

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
                            walletController.selectDateTime(context);
                          },
                          child: AbsorbPointer(
                              absorbing: true,
                              child: CustomField(hint: "Select Date", controller: walletController.date,
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
                        Obx(()=> CustomDropDown(dropdownValue: walletController.selectedType.value,items: walletController.types,onChanged: (val){
                          walletController.changeType(val);
                        },)),
                        const SizedBox(height: 10),
                        TextWidget(text: "STATUS", size: 12, fontFamily: "medium", color: AppColors.textColor),
                        const SizedBox(height: 5),
                        Obx(()=> CustomDropDown(dropdownValue: walletController.selectedStatus.value,items: walletController.statues,onChanged: (val){
                          walletController.changeStatus(val);
                        },)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(()=>Checkbox(
                              activeColor: AppColors.primaryColor,
                              value: walletController.isBill.value,
                              onChanged: walletController.changeBill,
                              side:  BorderSide(
                                color: AppColors.textColor,
                              ),
                            )),
                            Text('Is Bill',style: MyTextStyle.montserratSemiBold(14, AppColors.textColor)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomButton(onTap: (){
                          if (walletController.formKey.currentState!.validate()) {
                            walletController.addTransaction(autController.userID.value);
                          }
                        }, text:isEdit? "Update" :"Submit",
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
