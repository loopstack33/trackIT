import 'package:intl/intl.dart';

import '../../../enums/dependencies.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var autController = Get.put(AuthController());

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width*0.9,
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
                color: AppColors.blackColor.withOpacity(0.08),
                blurRadius: 35,
                offset: const Offset(0, 25)
            )
          ],
          borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: "Total Balance", size: 12, fontFamily: "medium", color: AppColors.whiteColor),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").where("uid",isEqualTo:autController.userID.value).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if(snapshot.data!.docs.isNotEmpty){
                  var balance = snapshot.data!.docs[0].get("balance");
                  return TextWidget(text: NumberFormat.currency(locale: "ur_PK", symbol: "Rs ",decimalDigits: 0).format(balance), size: 20, fontFamily: "bold", color: AppColors.whiteColor);
                }
                else {
                  return TextWidget(text: "Rs 0", size: 20, fontFamily: "bold", color: AppColors.whiteColor);
                }
              }
              else if(snapshot.hasError){
                return TextWidget(text: "Rs 0", size: 20, fontFamily: "bold", color: AppColors.whiteColor);
              }
              else {
                return TextWidget(text: "Rs 0", size: 20, fontFamily: "bold", color: AppColors.whiteColor);
              }
            },
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteColor.withOpacity(0.15)
                        ),
                        child: Icon(Icons.arrow_downward,color: AppColors.whiteColor,size: 16),
                      ),
                      const SizedBox(width: 5),
                      TextWidget(text: "Income", size: 12, fontFamily: "regular", color: AppColors.whiteColor)
                    ],
                  ),
                  const SizedBox(height: 5),
                  TextWidget(text: NumberFormat.currency(locale: "ur_PK", symbol: "Rs ",decimalDigits: 0).format(autController.userIncome.value), size: 16, fontFamily: "bold", color: AppColors.whiteColor),
                ],
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("transactions").where("userID",isEqualTo:autController.userID.value).orderBy("date",descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    if(snapshot.data!.docs.isNotEmpty){
                      int expense = 0;
                      var expenseData = snapshot.data!.docs.where((value)=> value.get("type").toString()=="Expense")
                          .where((value)=> value.get("paid")==true).toList();

                      for (var doc in expenseData) {
                        expense += int.parse(doc['amount'].toString());
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.whiteColor.withOpacity(0.15)
                                ),
                                child: Icon(Icons.arrow_upward,color: AppColors.whiteColor,size: 16),
                              ),
                              const SizedBox(width: 5),
                              TextWidget(text: "Expense", size: 12, fontFamily: "regular", color: AppColors.whiteColor)
                            ],
                          ),
                          const SizedBox(height: 5),
                          TextWidget(text: NumberFormat.currency(locale: "ur_PK", symbol: "Rs ",decimalDigits: 0).format(expense), size: 16, fontFamily: "bold", color: AppColors.whiteColor),
                        ],
                      );
                    }
                    else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.whiteColor.withOpacity(0.15)
                                ),
                                child: Icon(Icons.arrow_upward,color: AppColors.whiteColor,size: 16),
                              ),
                              const SizedBox(width: 5),
                              TextWidget(text: "Expense", size: 12, fontFamily: "regular", color: AppColors.whiteColor)
                            ],
                          ),
                          const SizedBox(height: 5),
                          TextWidget(text: "Rs 0", size: 16, fontFamily: "bold", color: AppColors.whiteColor),
                        ],
                      );
                    }
                  }
                  else if(snapshot.hasError){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.whiteColor.withOpacity(0.15)
                              ),
                              child: Icon(Icons.arrow_upward,color: AppColors.whiteColor,size: 16),
                            ),
                            const SizedBox(width: 5),
                            TextWidget(text: "Expense", size: 12, fontFamily: "regular", color: AppColors.whiteColor)
                          ],
                        ),
                        const SizedBox(height: 5),
                        TextWidget(text: "Rs 0", size: 16, fontFamily: "bold", color: AppColors.whiteColor),
                      ],
                    );
                  }
                  else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.whiteColor.withOpacity(0.15)
                              ),
                              child: Icon(Icons.arrow_upward,color: AppColors.whiteColor,size: 16),
                            ),
                            const SizedBox(width: 5),
                            TextWidget(text: "Expense", size: 12, fontFamily: "regular", color: AppColors.whiteColor)
                          ],
                        ),
                        const SizedBox(height: 5),
                        TextWidget(text: "Rs 0", size: 16, fontFamily: "bold", color: AppColors.whiteColor),
                      ],
                    );
                  }
                },
              )
            ],
          )


        ],
      ),
    );
  }
}
