
import '../enums/dependencies.dart';

class NoData extends StatelessWidget {
  final String image, name;
  final bool isPng;
  const NoData({super.key, this.image="assets/images/noData.png", this.name="No Graph Data Found", this.isPng=false});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Image.asset(image,height: 200),
        const SizedBox(height: 20),
        TextWidget(text: name, size: 22, fontFamily: "medium", color: AppColors.blackColor),
      ],
    ));
  }
}
