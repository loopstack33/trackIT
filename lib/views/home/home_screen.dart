
import '../../enums/dependencies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var autController = Get.put(AuthController());

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
                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("transactions").where("userID",isEqualTo:autController.userID.value).orderBy("date",descending: true).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              if(snapshot.data!.docs.isNotEmpty){
                                return ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.only(top: 10),
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
