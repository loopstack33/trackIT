
import '../enums/dependencies.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selected = 0;
  bool heart = false;
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));

    return Scaffold(
      body: SafeArea(
        top: false,
        child: PageView(

          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: const [
            HomeScreen(),
            StatsScreen(),
            WalletScreen(),
            ProfileScreen()
          ],
        ),
      ),
      bottomNavigationBar: StylishBottomBar(
        option: AnimatedBarOptions(
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.simple,
        ),
        items: [
          BottomBarItem(
            icon: Image.asset(AppImages.home,color:selected==0? AppColors.primaryColor:AppColors.iconColor,height: 25,width: 25),
            selectedColor: AppColors.primaryColor,
            unSelectedColor: AppColors.iconColor,
            title: const SizedBox(),
          ),
          BottomBarItem(
            icon: Image.asset(AppImages.stats,color:selected==1? AppColors.primaryColor:AppColors.iconColor,height: 25,width: 25,),
            selectedColor: AppColors.primaryColor,
            unSelectedColor: AppColors.iconColor,
            title: const SizedBox(),
          ),
          BottomBarItem(
            icon: Image.asset(AppImages.wallet,color:selected==2? AppColors.primaryColor:AppColors.iconColor,height: 25,width: 25,),
            selectedColor: AppColors.primaryColor,
            unSelectedColor: AppColors.iconColor,
            title: const SizedBox(),
          ),
          BottomBarItem(
            icon: Image.asset(AppImages.user,color:selected==3? AppColors.primaryColor:AppColors.iconColor,height: 25,width: 25,),
            selectedColor: AppColors.primaryColor,
            unSelectedColor: AppColors.iconColor,
            title: const SizedBox(),
          ),
        ],
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        currentIndex: selected,
        notchStyle: NotchStyle.circle,
        onTap: (index) {
          if (index == selected) return;
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Get.to(()=> const TransactionAdd());
        },
        backgroundColor: AppColors.primaryColor,
        child: Image.asset(AppImages.plus,color: AppColors.whiteColor,width: 25,height: 25,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
