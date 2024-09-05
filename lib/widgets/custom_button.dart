
import '../enums/dependencies.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final double? height;
  final List<BoxShadow>? boxShadow;
  final double? width;
  final Color? color;
  final Color? borderColor;
  final String text;
  final String? family;
  final bool isGradient;
  final Color? textColor;
  final Color? imageColor;
  final LinearGradient? gradient;
  final String? image;
  final bool hasShadow;
  final double? size;
  const CustomButton({super.key, this.borderColor,this.isGradient=false,this.imageColor,this.image,required this.onTap, this.height, this.color, required this.text,this.hasShadow=true, this.family, this.textColor, this.size, this.width, this.gradient, this.boxShadow});

  @override
  Widget build(BuildContext context) {

    bool isTablet = ResponsiveLayout.isTablet(context);
    bool isDesktop = ResponsiveLayout.isDesktop(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width?? MediaQuery.of(context).size.width*0.9,
        height: height ?? (isDesktop?60:50),
        decoration: BoxDecoration(
          gradient: isGradient? gradient : null,
          border: Border.all(color: borderColor ?? AppColors.primaryColor,width: 1),
          color:isGradient==false? color ?? AppColors.whiteColor : null,
          borderRadius: BorderRadius.circular(40),
          boxShadow: boxShadow
        ),
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        child: image!=null?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image!,color: imageColor,width: 25,height: 25,),
              const SizedBox(width: 10),
              TextWidget(text: text, size: size!=null?size!: isTablet? 16:14, color: textColor?? AppColors.whiteColor,fontFamily: family ?? "semi",),
            ],
          ):
        TextWidget(text: text, size: size!=null?size!: isTablet? 16:14, color: textColor?? AppColors.whiteColor,fontFamily: family ?? "semi",),
      ),
    );
  }
}
