import 'package:track_it/enums/dependencies.dart';

class AppColors {
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;
  static Color primaryColor = const Color(0xFF2F7E79);
  static Color primaryLight = const Color(0xFFECF9F8);
  static Color textColor = const Color(0xFF444444);
  static Color incomeColor = const Color(0xFF25A969);
  static Color outComeColor = const Color(0xFFF95B51);
  static Color iconColor = const Color(0xFFAAAAAA);
  static Color fieldColor = const Color(0xFFDDDDDD);
  static LinearGradient primaryGradient =  LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[const Color(0xFF69AEA9).withOpacity(0), const Color(0xFF3F8782)]);
  static LinearGradient splashGradient =  const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Color(0xFF69AEA9), Color(0xFF3F8782)]);


  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
}