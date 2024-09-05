import '../../../enums/dependencies.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
          TextWidget(text: "Rs 25000", size: 20, fontFamily: "bold", color: AppColors.whiteColor),
          const SizedBox(height: 50),
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
                  TextWidget(text: "Rs 40000", size: 16, fontFamily: "bold", color: AppColors.whiteColor),
                ],
              ),
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
                        child: Icon(Icons.arrow_upward,color: AppColors.whiteColor,size: 16),
                      ),
                      const SizedBox(width: 5),
                      TextWidget(text: "Expense", size: 12, fontFamily: "regular", color: AppColors.whiteColor)
                    ],
                  ),
                  const SizedBox(height: 5),
                  TextWidget(text: "Rs 20000", size: 16, fontFamily: "bold", color: AppColors.whiteColor),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
