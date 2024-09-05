


import '../enums/dependencies.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double size;
  final String fontFamily;
  final Color color;
  final TextAlign textAlign;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final int? maxLines;
  const TextWidget({super.key, required this.text, required this.size, required this.fontFamily,this.decoration, required this.color,this.textAlign=TextAlign.start, this.overflow, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:fontFamily=="regular"? MyTextStyle.montserratRegular(size, color):
      fontFamily=="medium"? MyTextStyle.montserratMedium(size, color):
      fontFamily=="semi"? MyTextStyle.montserratSemiBold(size, color):
      MyTextStyle.montserratBold(size, color),
      textAlign:textAlign,
      overflow: overflow,
      maxLines: maxLines,

    );
  }
}
