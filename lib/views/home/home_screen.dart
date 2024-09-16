
import 'package:track_it/views/home/controller/home_controller.dart';
import 'package:track_it/views/home/widgets/pay_widget.dart';

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
                    const CardWidget(),
                    const SizedBox(height: 30),
                    Padding(padding: const EdgeInsets.only(left: 10,right: 10),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextWidget(text: "Quick Pay", size: 14, fontFamily: "semi", color: AppColors.blackColor),
                          ],
                        )),
                    const SizedBox(height: 10),
                    SizedBox(height: 100,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context,index){
                      var data = homeController.payList[index];
                      return PayWidget(image: data["image"].toString(), name: data["name"].toString(), onTap: (){});
                    },
                      shrinkWrap: true,
                      itemCount: homeController.payList.length,
                      scrollDirection: Axis.horizontal,),),
                    const SizedBox(height: 10),
                   Padding(padding: const EdgeInsets.only(left: 10,right: 10),
                   child:  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       TextWidget(text: "Transactions History", size: 14, fontFamily: "semi", color: AppColors.blackColor),
                       TextWidget(text: "See All", size: 12, fontFamily: "medium", color: AppColors.iconColor)
                     ],
                   )),
                    const SizedBox(height: 10),
                  ],
                )),
            Expanded(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                  ),
                  child:  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("transactions").where("userID",isEqualTo:autController.userID.value).orderBy("date",descending: true).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        if(snapshot.data!.docs.isNotEmpty){
                          return ListView.builder(
                              padding: const EdgeInsets.only(bottom: 10),
                              itemBuilder: (context,index){
                                var data = snapshot.data!.docs[index];
                                return  TransactionCard(
                                    onTap2: (){
                                      Get.to(()=> TransactionDetail(
                                          isIncome: data.get("isBill")? false : true,
                                          data: data
                                      ));
                                    },
                                    data: data
                                );
                              },
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length);
                        }
                        else {
                          return const NoData(name: "No Transactions Yet");
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
            ))
          ],
        ),
      ),
    );
  }
}
