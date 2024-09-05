import 'package:track_it/views/profile/widgets/profile_widget.dart';

import '../../enums/dependencies.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          image: DecorationImage(
            image: AssetImage(AppImages.top),
            alignment: Alignment.topCenter
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.whiteColor,
                  ),
                  const SizedBox(height: 10),
                  TextWidget(text: "Mohammad Manan", size: 16, fontFamily: "semi", color: AppColors.whiteColor),
                  TextWidget(text: "loopsstack@gmail.com", size: 12, fontFamily: "medium", color: AppColors.whiteColor),
                ],
              ),
            ),
            const Spacer(),
            ProfileWidget(image: AppImages.send, title: "Invite Friends"),
            const SizedBox(height: 10),
            Center(child: SizedBox(width: MediaQuery.of(context).size.width*0.9,
                child: Divider(color: Colors.grey.withOpacity(0.25)))),
            const SizedBox(height: 10),
            ProfileWidget(image: AppImages.user2, title: "Account Info"),
            ProfileWidget(image: AppImages.users, title: "Personal Profile"),
            ProfileWidget(image: AppImages.email, title: "Message Center"),
            ProfileWidget(image: AppImages.shield, title: "Login and security"),
            ProfileWidget(image: AppImages.lock, title: "Data and privacy"),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
