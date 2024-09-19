
import '../../enums/dependencies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var autController = Get.put(AuthController());
  var homeController = Get.put(HomeController());

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 50),
            Padding(padding: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(text: "Welcome", size: 14, fontFamily: "medium", color: AppColors.whiteColor),
                        TextWidget(text: autController.userName.value, size: 20, fontFamily: "semi", color: AppColors.whiteColor),
                      ],
                    ),
                    GestureDetector(
                        onTap: (){
                          Get.to(()=> const Notifications());
                        },
                        child: Icon(Icons.notifications_active_rounded,color: AppColors.whiteColor)
                    )
                  ],
                )),
            const Center(child: CardWidget()),
            const SizedBox(height: 20),
            Padding(padding: const EdgeInsets.only(left: 10,right: 10),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(text: "Quick Pay", size: 14, fontFamily: "semi", color: AppColors.blackColor),
                  ],
                )),
            const SizedBox(height: 10),
            SizedBox(height: 90,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context,index){
                  var data = homeController.payList[index];
                  return PayWidget(image: data["image"].toString(), name: data["name"].toString(), onTap: (){
                    homeController.resetValues();
                    Get.to(()=> QuickPay(from: data["name"].toString()));
                  });
                },
                shrinkWrap: true,
                itemCount: homeController.payList.length,
                scrollDirection: Axis.horizontal,),),
            Padding(padding: const EdgeInsets.only(left: 10,right: 10),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(text: "Transactions History", size: 14, fontFamily: "semi", color: AppColors.blackColor),
                    TextWidget(text: "See All", size: 12, fontFamily: "medium", color: AppColors.iconColor)
                  ],
                )),
            const SizedBox(height: 10),
            Expanded(
             flex: 2,
               child: StreamBuilder(
               stream: FirebaseFirestore.instance.collection("transactions").where("userID",isEqualTo:autController.userID.value).orderBy("date",descending: true).limit(5).snapshots(),
               builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                 if (snapshot.hasData) {
                   if(snapshot.data!.docs.isNotEmpty){
                     return AnimationLimiter(
                       child: ListView.builder(
                         padding: const EdgeInsets.only(top: 10),
                         shrinkWrap: true,
                         itemCount: snapshot.data!.docs.length,
                         itemBuilder: (BuildContext context, int index) {
                           var data = snapshot.data!.docs[index];
                           return AnimationConfiguration.staggeredList(
                             position: index,
                             duration: const Duration(milliseconds: 375),
                             child: SlideAnimation(
                               verticalOffset: 50.0,
                               child: FadeInAnimation(
                                 child: TransactionCard(
                                     onTap2: (){
                                       Get.to(()=> TransactionDetail(
                                           isIncome: data.get("isBill")? false : true,
                                           data: data
                                       ));
                                     },
                                     data: data
                                 )
                               ),
                             ),
                           );
                         },
                       ),
                     );
                   }
                   else {

                     return const NoData(name: "No Transactions Yet");
                   }

                 }
                 else if(snapshot.hasError){
                   return Container();
                 }
                 else {
                   return  Shimmer(
                       linearGradient: AppColors.shimmerGradient,
                       child: ListView.builder(
                           padding: EdgeInsets.zero,
                           shrinkWrap: true,
                           itemCount: 5,
                           itemBuilder: (BuildContext context, int index) {
                             return const ShimmerLoading(
                                 isLoading: true,
                                 child: DummyCard());
                           }));
                 }
               },
           )),


          ],
        ),
      ),
    );
  }
}
