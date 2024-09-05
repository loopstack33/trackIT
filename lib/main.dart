import 'dart:io';
import 'enums/dependencies.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(Platform.isIOS){
    await Firebase.initializeApp();
  }
  else{
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAAuFrEPjy1ANe7Dr_peeNIyvrZyOyl1Ao",
          authDomain: "track-it-2d364.firebaseapp.com",
          projectId: "track-it-2d364",
          storageBucket: "track-it-2d364.appspot.com",
          messagingSenderId: "389047656366",
          appId: "1:389047656366:web:32b0449f35e4543d1d323f",
          measurementId: "G-7HE26D295C"
      ),
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final botToastBuilder = BotToastInit();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TrackIt',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.whiteColor,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        dropdownMenuTheme: const DropdownMenuThemeData(
            inputDecorationTheme:InputDecorationTheme(
              fillColor: Colors.white,
            )
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        tabBarTheme: const TabBarTheme(
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent
        ),
        iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
                iconColor: MaterialStateProperty.all(AppColors.whiteColor)
            )
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: AppColors.whiteColor,
            centerTitle: true,
            elevation: 0,
            titleTextStyle: GoogleFonts.montserrat(
                fontSize: 18, fontWeight: FontWeight.w600)),
      ),
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: (context, child) {

        child = botToastBuilder(context,child);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child,
        );
      },
      home: const Splash(),
    );
  }
}
