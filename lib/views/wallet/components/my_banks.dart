import 'package:track_it/views/wallet/widgets/bank_card.dart';
import '../../../enums/dependencies.dart';

class MyBanks extends StatefulWidget {
  const MyBanks({super.key});

  @override
  State<MyBanks> createState() => _MyBanksState();
}

class _MyBanksState extends State<MyBanks> {
  var autController = Get.put(AuthController());
  var walletController = Get.put(WalletController());

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
                    TextWidget(text: "Bank Accounts", size: 18, fontFamily: "semi", color: AppColors.whiteColor),
                    GestureDetector(
                        onTap: (){
                          walletController.resetBankDetails();
                          Get.to(()=> const AddBank());
                        },
                        child: const Icon(Icons.link,color: Colors.white)
                    ),
                  ],
                )),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(20),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users").doc(autController.userID.value).collection("banks").snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    if(snapshot.data!.docs.isNotEmpty){

                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context,index){
                            var data = snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: (){
                                walletController.setBankDetails(data);
                                Get.to(()=> const AddBank(isEdit: true));
                              },
                              child: BankCard(data:data)
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true);
                    }
                    else {
                      return const NoData(name: "No Banks Found");
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
              )
            ))
          ],
        ),
      ),
    );
  }
}
