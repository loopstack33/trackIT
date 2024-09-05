import '../enums/dependencies.dart';

class CustomDialog extends StatelessWidget {
  final String image,name;
  final bool isPng,isCancel;
  final VoidCallback? onTap;
  final String? btnText;
  const CustomDialog({super.key, required this.image, required this.name,this.isPng=false,this.onTap,this.btnText,this.isCancel=true});

  @override
  Widget build(BuildContext context) {
    bool isTablet = ResponsiveLayout.isTablet(context);
    return Dialog(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(24)), //this right here
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(24)
          ),
          clipBehavior: Clip.antiAlias,
          width:isTablet? MediaQuery.of(context).size.width*0.7:
          MediaQuery.of(context).size.width*0.9,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(image,width: 200,height:200),
                const SizedBox(height: 20),
                TextWidget(text: name, size: 18, fontFamily: "medium", color: AppColors.blackColor,
                    textAlign: TextAlign.center),
                const SizedBox(height: 20),
                isCancel?CustomButton(onTap:onTap??(){
                  Get.back();
                }, text:btnText?? "Continue",color: AppColors.primaryColor,
                borderColor: AppColors.primaryColor,textColor: Colors.white,):
                CustomButton(onTap:onTap??(){
                  Get.back();
                }, text:btnText?? "Continue"),
                const SizedBox(height: 10),
              ],
            ),
          ),
        )
    );
  }
}
