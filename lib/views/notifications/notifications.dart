import '../../enums/dependencies.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 110,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    image: DecorationImage(
                        image: AssetImage(AppImages.top),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover
                    ),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))
                ),
                padding: const EdgeInsets.only(left: 20,right: 20,top: 40),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,size: 20)
                    ),
                    const SizedBox(width: 20),
                    TextWidget(text: "Notifications", size: 20, fontFamily: "semi", color: AppColors.whiteColor),

                  ],
                )),
            Expanded(child:  Container(
              padding: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,

              ),
              child:  SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset("assets/images/noData.png"),
                    TextWidget(text: "Under Development", size: 20, fontFamily: "semi", color: AppColors.primaryColor),
                    TextWidget(text: "Coming soon....", size: 14, fontFamily: "regular", color: AppColors.primaryColor)
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
