
import 'package:track_it/widgets/custom_dropdown.dart';
import 'package:track_it/widgets/custom_field.dart';

import '../enums/dependencies.dart';

class TransactionAdd extends StatelessWidget {
  const TransactionAdd({super.key});

  @override
  Widget build(BuildContext context) {
    var walletController = Get.put(WalletController());

    return Scaffold(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
           Padding(padding: const EdgeInsets.only(left: 20,right: 20),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   GestureDetector(
                       onTap: (){
                         Get.back();
                       },
                       child: Image.asset(AppImages.arrow,width: 20,height: 20,)
                   ),
                   TextWidget(text:"Add Transaction", size: 18, fontFamily: "semi", color: AppColors.whiteColor),
                   Image.asset(AppImages.dots,width: 20,height: 20,),
                 ],
               )),
            const SizedBox(height: 80),
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
                  CustomField(hint: "Enter Name", controller: walletController.name),
                  const SizedBox(height: 20),
                  TextWidget(text: "AMOUNT", size: 12, fontFamily: "medium", color: AppColors.textColor),
                  const SizedBox(height: 5),
                  CustomField(hint: "Enter Amount", controller: walletController.amount,suffixIcon: Image.asset(AppImages.currency,width: 25,height: 25)),
                  const SizedBox(height: 20),
                  TextWidget(text: "DATE", size: 12, fontFamily: "medium", color: AppColors.textColor),
                  const SizedBox(height: 5),
                  CustomField(hint: "Select Date", controller: walletController.date,suffixIcon: Image.asset(AppImages.calendar,width: 25,height: 25)),
                  const SizedBox(height: 20),
                  TextWidget(text: "TYPE", size: 12, fontFamily: "medium", color: AppColors.textColor),
                  const SizedBox(height: 5),
                 Obx(()=> CustomDropDown(dropdownValue: walletController.selectedType.value,items: walletController.types,onChanged: (val){
                   walletController.changeType(val);
                 },)),
                  const SizedBox(height: 40),
                  CustomButton(onTap: (){}, text: "Submit",
                  color: AppColors.whiteColor,textColor: AppColors.primaryColor,
                  borderColor: AppColors.primaryColor,)
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
