

import 'package:track_it/views/wallet/components/wallet_details.dart';

import '../../enums/dependencies.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                      TextWidget(text: "Wallet", size: 18, fontFamily: "semi", color: AppColors.whiteColor),
                      Icon(Icons.notifications_active_rounded,color: AppColors.whiteColor)
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
                    TextWidget(text: "\$ 2,570", size: 30, fontFamily: "semi", color: AppColors.blackColor),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.to(()=> const TransactionAdd());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.primaryColor)
                                ),
                                child: Image.asset(AppImages.plus),
                              ),
                              const SizedBox(height: 5),
                              TextWidget(text: "Add", size: 14, fontFamily: "medium", color: AppColors.blackColor),
                            ],
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.primaryColor)
                              ),
                              child: Image.asset(AppImages.qr),
                            ),
                            const SizedBox(height: 5),
                            TextWidget(text: "Pay", size: 14, fontFamily: "medium", color: AppColors.blackColor),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.primaryColor)
                              ),
                              child: Image.asset(AppImages.send),
                            ),
                            const SizedBox(height: 5),
                            TextWidget(text: "Send", size: 14, fontFamily: "medium", color: AppColors.blackColor),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    PreferredSize(
                      preferredSize: const Size.fromHeight(40),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(40)),
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            color: Color(0xFFF4F6F6),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(6),
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              dividerColor: Colors.transparent,
                              indicator: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                              ),
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.black54,
                              tabs: [
                                TabItem(title: 'Transactions'),
                                TabItem(title: 'Upcoming Bills'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const WalletDetails(),

                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );

  }
}
