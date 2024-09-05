import '../../../enums/dependencies.dart';

class ProfileWidget extends StatelessWidget {
  final String image, title;
  const ProfileWidget({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(image,width: 25,height: 25,),
      title: TextWidget(text: title, size: 14, fontFamily: "semi", color: AppColors.blackColor),
    );
  }
}
