import '../../../enums/dependencies.dart';

class ProfileWidget extends StatelessWidget {
  final String image, title;
  final VoidCallback? onTap;
  const ProfileWidget({super.key, required this.image, required this.title,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ?? (){},
      child: ListTile(
        leading:image==AppImages.logout? Image.asset(image,width: 22,height: 22,):
        Image.asset(image,width: 25,height: 25,),
        title: TextWidget(text: title, size: 14, fontFamily: "medium", color: AppColors.blackColor),
      )
    );
  }
}
