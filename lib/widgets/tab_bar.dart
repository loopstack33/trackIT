
import 'package:track_it/enums/dependencies.dart';

class TabItem extends StatelessWidget {
  final String title;

  const TabItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: TextWidget(text: title, size: 12, fontFamily: "semi", color: AppColors.textColor),
    );
  }
}