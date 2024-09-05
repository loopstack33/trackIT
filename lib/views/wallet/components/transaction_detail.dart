import '../../../enums/dependencies.dart';

class TransactionDetail extends StatelessWidget {
  final bool isIncome;
  const TransactionDetail({super.key, this.isIncome=true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
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
                padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Image.asset(AppImages.arrow,width: 20,height: 20,)
                    ),
                    TextWidget(text:isIncome? "Transaction Details": "Bill Details", size: 18, fontFamily: "semi", color: AppColors.whiteColor),
                    Image.asset(AppImages.dots,width: 20,height: 20,),
                  ],
                )),
            Expanded(child: Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: AppColors.whiteColor,),
              child: Column(
                children: [
                  TextWidget(text: "Total Balance", size: 16, fontFamily: "medium", color: AppColors.iconColor),


                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
