
import 'package:intl/intl.dart';
import 'package:track_it/service/firebase_service.dart';
import 'package:share_plus/share_plus.dart';
import '../../../enums/dependencies.dart';

class TransactionDetail extends StatelessWidget {
  final bool isIncome;
  final QueryDocumentSnapshot<Object?> data;
  const TransactionDetail({super.key, this.isIncome=true, required this.data});

  @override
  Widget build(BuildContext context) {
    var walletController = Get.put(WalletController());
    //ScreenshotController screenshotController = ScreenshotController();

    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 110,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    image: DecorationImage(
                        image: AssetImage(AppImages.top),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover
                    ),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))
                ),
                padding: const EdgeInsets.only(left: 20,right: 20,top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,size: 20)
                    ),
                    TextWidget(text:isIncome? "Transaction Details": "Bill Details", size: 18, fontFamily: "semi", color: AppColors.whiteColor),
                    data.get("paid")? const SizedBox():
                    GestureDetector(
                        onTap: (){
                          walletController.setValues(data);
                          Get.to(()=> const TransactionAdd(isEdit: true));
                        },
                        child: const Icon(Icons.edit_outlined,color: Colors.white,size: 20)
                    ),
                  ],
                )),
            Expanded(child: Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: AppColors.whiteColor,),
              child: Column(
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextWidget(text: data.get("name").toString().trim(), size: 18, fontFamily: "semi", color: AppColors.blackColor)
                              ),
                              const SizedBox(height: 5),
                              TextWidget(text: DateFormat("MMM dd, yyyy").format((data.get("date") as Timestamp).toDate()), size: 14, fontFamily: "regular", color: AppColors.textColor),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: data.get("type").toString().trim()=="Income"?AppColors.incomeColor.withOpacity(0.25):AppColors.outComeColor.withOpacity(0.25)
                            ),
                            child:  TextWidget(text: data.get("type").toString().trim(), size: 12, fontFamily: "semi", color: data.get("type").toString().trim()=="Income"?AppColors.incomeColor:AppColors.outComeColor),
                          )
                        ],
                      ),
                      const SizedBox(height: 40),
                      TextWidget(text: "Transaction Details", size: 14, fontFamily: "medium", color: AppColors.blackColor),
                      const SizedBox(height: 10),
                      Divider(color: AppColors.fieldColor),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(text: "Amount", size: 12, fontFamily: "medium", color: AppColors.iconColor),
                            TextWidget(text: NumberFormat.currency(locale: "ur_PK", symbol: "Rs ",decimalDigits: 0).format( data.get("amount")), size: 14, fontFamily: "semi", color: AppColors.blackColor),
                          ]),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(text: isIncome==false? "Due Date":"Date", size: 12, fontFamily: "medium", color: AppColors.iconColor),
                            TextWidget(text: DateFormat("MMM dd, yyyy").format((data.get("date") as Timestamp).toDate()), size: 12, fontFamily: "medium", color: AppColors.blackColor),
                          ]),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(text: "Status", size: 12, fontFamily: "medium", color: AppColors.iconColor),
                            TextWidget(text: data.get("paid")==true?"Paid":"Un-Paid", size: 12, fontFamily: "medium", color: data.get("paid")==true?
                            AppColors.incomeColor:
                            AppColors.outComeColor),
                          ]),


                    ],
                  )),
                 if(data.get("paid"))...[
                   CustomButton(
                     textColor: AppColors.primaryColor,
                     onTap: (){

                     }, text: "Share Receipt",
                    ),
                 ]
                  else...[
                   CustomButton(
                     onTap: (){
                       showDialog(
                           context: context,
                           builder: (context) {
                             return MyFancyPopup(heading: "Alert!", body: "Are you sure you want to pay for this transaction?",
                                 onClose:(){
                               if(isIncome && data.get("paid")==false){
                                 walletController.addIncome(data.get("uid"), data.get("userID"),data.get("amount"),data.get("type"));
                                }
                                 else{
                                 FirebaseService.checkBalance(data.get("userID"),data.get("amount")).then((val){
                                   if(val==""){
                                     walletController.updateTransaction(data.get("uid"), data.get("userID"),data.get("amount"));
                                   }
                                   else{
                                     BotToast.showSimpleNotification(title: val,titleStyle: MyTextStyle.montserratRegular(14, AppColors.whiteColor),
                                         backgroundColor: AppColors.outComeColor);
                                   }
                                 });
                               }

                                 },
                                 headingStyle: MyTextStyle.montserratSemiBold(18, AppColors.blackColor),
                                 bodyStyle: MyTextStyle.montserratRegular(14, AppColors.blackColor),
                                 type: Type.warning,
                                 buttonText: "Pay",
                                 buttonColor: AppColors.primaryColor,
                                 buttonRadius: 10,
                                 buttonWidth: 150,
                                 buttonHeight: 40,
                                 buttonStyle: MyTextStyle.montserratSemiBold(12, AppColors.whiteColor));
                           });

                     }, text: "Pay",
                     isGradient: true,
                     borderColor: Colors.transparent,
                     gradient: AppColors.splashGradient,),
                 ],
                  const SizedBox(height: 10),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
