import 'package:track_it/views/home/widgets/card.dart';

import '../../enums/dependencies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                alignment: Alignment.topCenter
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Center(
                child: Column(
                  children: [
                    Padding(padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(text: "Welcome", size: 14, fontFamily: "medium", color: AppColors.whiteColor),
                                TextWidget(text: "Mohammad Manan", size: 20, fontFamily: "semi", color: AppColors.whiteColor),
                              ],
                            ),
                            Icon(Icons.notifications_active_rounded,color: AppColors.whiteColor)
                          ],
                        )),
                    const CardWidget(),
                  ],
                )),
            Expanded(
                flex: 2,
                child: Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,

              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(text: "Transactions History", size: 14, fontFamily: "semi", color: AppColors.blackColor),
                        TextWidget(text: "See All", size: 12, fontFamily: "medium", color: AppColors.iconColor)
                      ],
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 10),
                        itemBuilder: (context,index){
                          return  TransactionCard(isPay:false,
                              onTap2: (){
                                Get.to(()=> const TransactionDetail());
                              });
                        },
                        shrinkWrap: true,
                        itemCount: 5)
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
