import '../enums/dependencies.dart';

class CustomDropDown extends StatelessWidget {
  final String dropdownValue;
  final Function(String?)? onChanged;
  final List<String>? items;
  final double? width;
  final String hint;
  final List<DropdownMenuItem<String>>? items2;
  const CustomDropDown({super.key, this.hint="",this.width,required this.dropdownValue, this.onChanged,this.items, this.items2});

  @override
  Widget build(BuildContext context) {

    bool isTablet = ResponsiveLayout.isTablet(context);
    bool isDesktop = ResponsiveLayout.isDesktop(context);

    return SizedBox(
        width: width ?? MediaQuery.of(context).size.width,
        height: isDesktop? 60: isTablet? 50: 50,
        child: DecoratedBox(
            decoration: ShapeDecoration(
              color: AppColors.whiteColor,
              shape:  RoundedRectangleBorder(
                  borderRadius:  const BorderRadius.all(Radius.circular(10)),
                  side:  BorderSide(color: AppColors.fieldColor,width: 1)
              ),
            ),
             child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
             child: DropdownButtonHideUnderline(
               child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  menuMaxHeight: 350,
                  focusColor: AppColors.primaryColor,
                  value: dropdownValue==""? null:dropdownValue,
                  dropdownColor: AppColors.whiteColor,
                  isExpanded: true,
                  hint: TextWidget(text: hint, size: 14, fontFamily: "regular", color: AppColors.blackColor),
                  icon: Icon(Icons.keyboard_arrow_down_sharp,color: AppColors.blackColor),
                  elevation: 16,
                  style: MyTextStyle.montserratRegular(14, AppColors.blackColor),
                  underline: Container(
                    height: 2,
                    color: AppColors.blackColor,
                  ),
                  onChanged: onChanged,
                  items: items2 ?? items!.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString(),style:  MyTextStyle.montserratRegular(14, AppColors.blackColor)),
                    );
                  }).toList(),
                )
              )),
        )
        )
    );
  }
}
