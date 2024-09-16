

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
                    return ListView.builder(

                        padding: const EdgeInsets.only(top: 10),
                        itemBuilder: (context,index){
                          var data = snapshot.data!.docs[index];
                          return  TransactionCard(isPay:false,
                              onTap2: (){
                                Get.to(()=> TransactionDetail(data: data));
                              },
                              data: data
                          );
                        },
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length);
                  }
                  else {
                    return const NoData(name: "No Transactions Yet",);
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
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("transactions").where("userID",isEqualTo:autController.userID.value)
                  .where("isBill",isEqualTo:true).orderBy("date",descending: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if(snapshot.data!.docs.isNotEmpty){
                    return ListView.builder(

                        padding: const EdgeInsets.only(top: 10),
                        itemBuilder: (context,index){
                          var data = snapshot.data!.docs[index];
                          return  TransactionCard(isPay: true,
                              onTap2: (){
                                Get.to(()=>  TransactionDetail(
                                  isIncome: false,
                                  data: data
                                ));
                              },
                              onTap: (){},
                              data: data
                          );
                        },
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length);
                  }
                  else {
                    return const NoData(name: "No Transactions Yet",);
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
        ));
  }
}
