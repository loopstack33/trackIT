

import '../../../enums/dependencies.dart';

class WalletDetails extends StatelessWidget {
  const WalletDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var autController = Get.put(AuthController());

    return  Expanded(
        child: TabBarView(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("transactions").where("userID",isEqualTo:autController.userID.value)
            .where("isBill",isEqualTo:false).orderBy("date",descending: true).snapshots(),
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
                                child: TransactionCard(isPay:false,
                                    onTap2: (){
                                      Get.to(()=> TransactionDetail(data: data));
                                    },
                                    data: data
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  else {
                    return const NoData(name: "No Transactions Yet",);
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
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("transactions").where("userID",isEqualTo:autController.userID.value)
                  .where("isBill",isEqualTo:true).orderBy("date",descending: true).snapshots(),
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
                                child: TransactionCard(isPay: true,
                                    onTap2: (){
                                      Get.to(()=>  TransactionDetail(
                                          isIncome: false,
                                          data: data
                                      ));
                                    },
                                    onTap: (){},
                                    data: data
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  else {
                    return const NoData(name: "No Transactions Yet",);
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
            ),
          ],
        ));
  }
}
