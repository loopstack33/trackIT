import 'package:share_plus/share_plus.dart';
import 'package:track_it/views/profile/components/account_detail.dart';
import 'package:track_it/views/profile/components/personal_detail.dart';
import 'package:track_it/views/profile/widgets/profile_widget.dart';
import '../../enums/dependencies.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var autController = Get.put(AuthController());

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          image: DecorationImage(
            image: AssetImage(AppImages.top),
            alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 85),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.whiteColor,
                    backgroundImage: AssetImage(AppImages.logo),
                  ),
                  const SizedBox(height: 10),
                  TextWidget(text: autController.userName.value.toString(), size: 16, fontFamily: "semi", color: AppColors.whiteColor),
                  TextWidget(text: autController.userEmail.value.toString(), size: 12, fontFamily: "medium", color: AppColors.whiteColor),
                ],
              ),
            ),
            const Spacer(),
            ProfileWidget(image: AppImages.send, title: "Invite Friends",onTap: (){
              var url = "https://drive.google.com/drive/folders/1S9GgccgnI5-Xul7fFDffWiC7x8jvJLEk?usp=sharing";
              Share.share('Track your finances together! Share TrackIT with friends and start managing income and expenses as a team.\n Download Today: $url');

            },),
            const SizedBox(height: 10),
            Center(child: SizedBox(width: MediaQuery.of(context).size.width*0.9, child: Divider(color: Colors.grey.withOpacity(0.25)))),
            const SizedBox(height: 10),
            ProfileWidget(image: AppImages.profile, title: "Account Info",
            onTap: (){
              Get.to(()=> const AccountDetail());
            }),
            ProfileWidget(image: AppImages.account, title: "Personal Profile",
              onTap: (){
                Get.to(()=> const PersonalDetail());
              }),
            ProfileWidget(image: AppImages.logout, title: "Log Out",onTap: () async{
              SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.setString("uid", "null");
              preferences.setBool("IsLoggedIn", false);
              Get.offAll(()=> const Login(from: false));
            }),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
