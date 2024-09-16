import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../enums/dependencies.dart';

class PhoneTextField extends StatelessWidget {
  final String hintText, label, countryCode;
  final Color themeColor;
  final String? value;
  final PhoneNumber? Function(PhoneNumber?)? onChanged;
  final ValueChanged<Country>? onChangeCountry;
  final TextEditingController? controller;
  final String? Function(PhoneNumber?)? function;
  final bool readOnly;

  const PhoneTextField({
    this.readOnly = false,
    required this.hintText,
    this.label = "",
    super.key,
    this.themeColor = Colors.black,
    this.onChanged,
    this.onChangeCountry,
    this.controller,
    this.value,
    required this.countryCode, this.function,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: IntlPhoneField(
          readOnly: readOnly ,
          controller: controller,
          showDropdownIcon: true,
          flagsButtonPadding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          textAlignVertical: TextAlignVertical.center,
          cursorColor: AppColors.primaryColor,
          dropdownIconPosition: IconPosition.trailing,
          showCountryFlag: true,
          autovalidateMode: AutovalidateMode.disabled,
          textInputAction: TextInputAction.done,
          initialValue: value,
          initialCountryCode: countryCode,
          onChanged:readOnly? null: onChanged,
          onCountryChanged:readOnly? null:onChangeCountry,
          dropdownTextStyle: MyTextStyle.montserratRegular(12, AppColors.textColor),
          flagsButtonMargin: const EdgeInsets.all(4),
          cursorHeight: 18,
          cursorWidth: 1,
          pickerDialogStyle: PickerDialogStyle(
            width: context.width * 0.85,
            countryNameStyle: MyTextStyle.montserratRegular(12, AppColors.textColor),
            countryCodeStyle: MyTextStyle.montserratRegular(12, AppColors.textColor),
            listTilePadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 5,
            ),
            listTileDivider:  Divider(
              height: 2,
              color: AppColors.iconColor,
              thickness: 1.5,
            ),
            backgroundColor: AppColors.whiteColor,
            searchFieldPadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 5,
            ),
            searchFieldInputDecoration: InputDecoration(
              isDense: true,
              hintText: 'Search for Country',
              hintStyle:MyTextStyle.montserratRegular(14, AppColors.textColor),
              suffixIcon:  Icon(
                Icons.search,
                color: AppColors.fieldColor,
              ),
              contentPadding: const EdgeInsets.only(top: 10,bottom: 10,left: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(
                  width: 1,
                  color: AppColors.fieldColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide:  BorderSide(
                  width: 1,
                  color: AppColors.fieldColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(
                  width: 1,
                  color: AppColors.fieldColor,
                ),
              ),
            ),
          ),

          style: MyTextStyle.montserratRegular(14, AppColors.textColor),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp("[0-9]"),
            ),
            FilteringTextInputFormatter.deny(
              RegExp('[\\#]'),
            ),
          ],
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 10,bottom: 10,left: 10),
              fillColor: Colors.transparent,
              filled: true,
              labelText: label,
              labelStyle:  MyTextStyle.montserratRegular(12, AppColors.textColor),
              hintText: hintText,
              hintStyle: MyTextStyle.montserratRegular(12, AppColors.textColor),
              counterText: "",
              disabledBorder: InputBorder.none,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide:  BorderSide(
                  width: 1,
                  color: AppColors.fieldColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(
                  width: 1,
                  color: AppColors.fieldColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(
                  width: 1,
                  color: AppColors.fieldColor,
                ),
              ),
              errorStyle: MyTextStyle.montserratRegular(10, Colors.red),
              errorBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.red,
                ),
              )
          ),


        )
    );
  }
}