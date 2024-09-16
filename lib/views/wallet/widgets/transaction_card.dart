import 'package:intl/intl.dart';

import '../../../enums/dependencies.dart';

class TransactionCard extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback onTap2;
  final QueryDocumentSnapshot<Object?> data;
  final bool isPay;
  const TransactionCard({super.key,this.isPay=false, this.onTap, required this.onTap2, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap2,
      behavior: HitTestBehavior.translucent,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F6F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                        data.get("name").toString().trim().contains("Withdraw")?
                        AppImages.withdraw:
                        data.get("name").toString().trim().contains("Cash") || data.get("name").toString().trim().contains("Credit") || data.get("name").toString().trim().contains("Amount")?
                        AppImages.cash:
                        data.get("name").toString().trim().contains("Bank")?
                        AppImages.bankIcon:
                        AppImages.bill),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: TextWidget(text: data.get("name").toString().trim(), size: 12, fontFamily: "medium", color: AppColors.blackColor),
                      ),
                      TextWidget(text: DateFormat("MMM dd, yyyy").format((data.get("date") as Timestamp).toDate()), size: 10, fontFamily: "regular", color: AppColors.textColor)
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextWidget(text:data.get("type").toString()=="Income"? "+ ${NumberFormat.currency(locale: "ur_PK", symbol: "Rs ",decimalDigits: 0).format( data.get("amount"))}":
                  "- ${NumberFormat.currency(locale: "ur_PK", symbol: "Rs ",decimalDigits: 0).format( data.get("amount"))}", size: 14, fontFamily: "semi", color: data.get("type").toString()=="Income"?
                  AppColors.incomeColor:
                  AppColors.outComeColor),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: data.get("paid")==true?AppColors.incomeColor.withOpacity(0.25):AppColors.outComeColor.withOpacity(0.25)
                    ),
                    child:  TextWidget(text: data.get("paid")==true?"Paid":"Un-Paid", size: 8, fontFamily: "semi", color: data.get("paid")==true?AppColors.incomeColor:AppColors.outComeColor),
                  )
                ],
              )
            ],
          ))
    );
  }
}
