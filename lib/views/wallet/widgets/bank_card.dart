import '../../../enums/dependencies.dart';

class BankCard extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> data;
  const BankCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child:  StreamBuilder(
          stream: FirebaseFirestore.instance.collection("banks").where("id",isEqualTo: data.get("bankID")).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if(snapshot.data!.docs.isNotEmpty){
                var bankData = snapshot.data!.docs[0];
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.primaryLight,
                          backgroundImage: NetworkImage(bankData.get("image").toString()),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: TextWidget(text: data.get("accountHolder").toString().trim(), size: 14, fontFamily: "regular", color: AppColors.blackColor),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: TextWidget(text: data.get("accountNumber").toString().trim(), size: 14, fontFamily: "medium", color: AppColors.blackColor),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: TextWidget(text: bankData.get("name").toString().trim(), size: 14, fontFamily: "regular", color: AppColors.blackColor),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Divider(color: AppColors.fieldColor)
                  ],
                );
              }
              else {
                return const NoData(name: "No Banks Found");
              }

            }
            else if(snapshot.hasError){
              return Container();
            }
            else {
              return Container();
            }
          },
        ),
       );
  }
}
