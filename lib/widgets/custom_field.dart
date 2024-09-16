

import '../enums/dependencies.dart';

class CustomField extends StatelessWidget {
  final String hint;
  final bool readOnly;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboard;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscure;
  final int maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  const CustomField({super.key, this.onChanged ,this.contentPadding,required this.hint, required this.controller, this.validator,this.keyboard=TextInputType.text, this.inputFormatters, this.suffixIcon, this.obscure=false,this.readOnly=false, this.prefixIcon,
  this.maxLines=1,this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      readOnly: readOnly,
      focusNode:focusNode,
      controller: controller,
      style: MyTextStyle.montserratRegular(14, AppColors.textColor),
      obscureText:obscure,
      obscuringCharacter: "*",
      keyboardType: keyboard,
      onChanged: onChanged,
      cursorColor: AppColors.primaryColor,
      validator: validator,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          maxHeight: 40
        ),
        suffixIconConstraints: const BoxConstraints(
            minWidth: 40,
            maxHeight: 40
        ),
        filled: true,
        hintText: hint,

        hintStyle: MyTextStyle.montserratRegular(12, AppColors.iconColor),
        fillColor: AppColors.whiteColor,
        contentPadding: contentPadding?? const EdgeInsets.all(10),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide(color: AppColors.fieldColor,width: 1)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide(color: AppColors.fieldColor,width: 1)
        ),
        errorStyle: MyTextStyle.montserratRegular(10, Colors.red),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red,width: 1)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide(color: AppColors.fieldColor,width: 1)
        ),
        errorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red,width: 1)
        ),
      ),
    );
  }
}
