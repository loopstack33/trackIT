import '../../../enums/dependencies.dart';

class PayWidget extends StatelessWidget {
  final String image, name;
  final VoidCallback onTap;
  const PayWidget({super.key, required this.image, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(right: 12,left: 12),
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.primaryLight,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(image)
          ),
        ),
        const SizedBox(height: 5),
        TextWidget(text: name, size: 12, fontFamily: "medium", color: AppColors.blackColor)
      ],
    ));
  }
}
