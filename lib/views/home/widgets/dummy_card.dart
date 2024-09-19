import 'package:intl/intl.dart';

import '../../../enums/dependencies.dart';

class DummyCard extends StatelessWidget {
  const DummyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border:Border.all(color: AppColors.primaryColor)
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
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
                  child: Image.asset(AppImages.bill),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: TextWidget(text: "Transaction Name", size: 12, fontFamily: "medium", color: AppColors.blackColor),
                    ),
                    TextWidget(text: DateFormat("MMM dd, yyyy").format(DateTime.now()), size: 10, fontFamily: "regular", color: AppColors.textColor)
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextWidget(text: "- ${NumberFormat.currency(locale: "ur_PK", symbol: "Rs ",decimalDigits: 0).format( 10000)}", size: 14, fontFamily: "semi", color: AppColors.outComeColor),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.outComeColor.withOpacity(0.25)
                  ),
                  child:  TextWidget(text: "Un-Paid", size: 8, fontFamily: "semi", color: AppColors.outComeColor),
                )
              ],
            )
          ],
        ));
  }
}
