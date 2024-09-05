import '../../../enums/dependencies.dart';

class TransactionCard extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback onTap2;
  final bool isPay;
  const TransactionCard({super.key,this.isPay=false, this.onTap, required this.onTap2});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap2,
      child: Padding(padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F6F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(AppImages.currency),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(text: "Transfer", size: 14, fontFamily: "medium", color: AppColors.blackColor),
                      TextWidget(text: "Jan 30, 2024", size: 12, fontFamily: "regular", color: AppColors.textColor)
                    ],
                  )
                ],
              ),
              if(isPay)...[
                CustomButton(onTap: onTap!, text: "Pay",color: AppColors.primaryLight,
                  textColor: AppColors.primaryColor,width: 80,height: 35,borderColor: AppColors.primaryLight,
                  size: 12,)
              ]
              else...[
                TextWidget(text: "+ \$850", size: 16, fontFamily: "semi", color: AppColors.incomeColor)
              ]
            ],
          ))
    );
  }
}
