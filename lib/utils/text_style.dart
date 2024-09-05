


import '../enums/dependencies.dart';

class MyTextStyle {

  ///// Montserrat FONT FAMILY
  static montserratRegular(size,color){
    return GoogleFonts.montserrat(
        fontSize: double.parse(size.toString()),
        fontWeight: FontWeight.w300,
        color: color,
    );
  }

  static montserratMedium(size,color){
    return GoogleFonts.montserrat(
      fontSize: double.parse(size.toString()),
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static montserratSemiBold(size,color){
    return GoogleFonts.montserrat(
      fontSize: double.parse(size.toString()),
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static montserratBold(size,color){
    return GoogleFonts.montserrat(
      fontSize: double.parse(size.toString()),
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

}