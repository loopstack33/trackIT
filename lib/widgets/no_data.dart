
import '../enums/dependencies.dart';

class NoData extends StatelessWidget {
  final String image, name;
  final bool isPng;
  const NoData({super.key, this.image="assets/images/sLogo.svg", this.name="No Graph Data Found", this.isPng=false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image),
        const SizedBox(height: 20),
        TextWidget(text: name, size: 22, fontFamily: "medium", color: AppColors.blackColor),
      ],
    );
  }
}
