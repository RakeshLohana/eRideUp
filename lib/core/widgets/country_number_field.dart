
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../constants/app_colors.dart';

class TextInputPhone extends StatelessWidget {
  const TextInputPhone({
    this.suffixIcon,
    this.currentLocale = "en",
    this.hint,
    this.floatingLabel,
    this.inputAction,
    this.controller,
    this.validator,
    this.initialCountryCode,
    this.onChanged,
    this.onCountryChanged,
    super.key,
  });

  final Widget? suffixIcon;
  final String? currentLocale;
  final String? hint;
  final String? floatingLabel;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? initialCountryCode;
  final void Function(PhoneNumber)? onChanged;
  final void Function(Country, PhoneNumber)? onCountryChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: IntlPhoneField(

        initialCountryCode: initialCountryCode ?? 'IN',
        controller: controller,
        onChanged: onChanged,
        onCountryChanged: (country) {
          final updatedPhoneNumber = PhoneNumber(
            countryISOCode: country.code,
            countryCode: country.dialCode,
            number: "",
          );
          onCountryChanged?.call(country, updatedPhoneNumber);
        },
        autofocus: false,
        decoration: InputDecoration(
          suffixIcon:suffixIcon ,
          labelText: floatingLabel,
          labelStyle: TextStyle(
            fontSize: 14.sp,
            // fontFamily: MyAssets.fontAlJazeera,
            color: AppColor.textInputLabel,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 16.sp,
            // fontFamily: MyAssets.fontAlJazeera,
            color: AppColor.textInputHint,
          ),
          helperMaxLines: 2,
          helperStyle: TextStyle(
            fontSize: 11.sp,
            // fontFamily: MyAssets.fontAlJazeera,
            color: AppColor.textInputLabel,
          ),
          errorMaxLines: 2,
          errorStyle: TextStyle(
            fontSize: 11.sp,
            // fontFamily: MyAssets.fontAlJazeera,
            color: AppColor.redColor,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.w,
            horizontal: 16.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.w),
            borderSide: const BorderSide(
              color: AppColor.textInputLabel,
              width: 1.0,
            ),
          ),
        ),
        style: TextStyle(
          fontSize: 16.sp,
          // fontFamily: MyAssets.fontAlJazeera,
          color: Colors.black,
        ),
        dropdownTextStyle: TextStyle(
          fontSize: 16.sp,
          // fontFamily: MyAssets.fontAlJazeera,
          color: Colors.black,
        ),
        flagsButtonMargin: currentLocale == "en"
            ? EdgeInsets.only(left: 12.w)
            : EdgeInsets.only(right: 12.w),
        showDropdownIcon: false,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w),
        ),
        textInputAction: inputAction,
        invalidNumberMessage: "Please enter a valid phone number",
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        pickerDialogStyle: PickerDialogStyle(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          backgroundColor: AppColor.white,
          countryCodeStyle: TextStyle(
            fontSize: 14.sp,
            color: AppColor.textInputLabel,
          ),
          countryNameStyle: TextStyle(
            fontSize: 14.sp,
            // fontFamily: MyAssets.fontAlJazeera,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          listTileDivider: const SizedBox(),
          searchFieldInputDecoration: InputDecoration(
            labelText:"Search",
            labelStyle: TextStyle(
              fontSize: 14.sp,
              // fontFamily: MyAssets.fontAlJazeera,
              color: AppColor.textInputLabel,
            ),
          ),
        ),
      ),
    );
  }
}
