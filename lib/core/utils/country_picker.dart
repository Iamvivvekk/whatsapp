import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/core/constants/colors.dart';

void countrypicker(
    {required BuildContext context,
    required void Function(Country country) onSelect}) {
  showCountryPicker(
      context: context,
      countryListTheme: const CountryListThemeData(
        backgroundColor: AppColor.backgroundColor,
        flagSize: 18,
        inputDecoration: InputDecoration(
          labelStyle: TextStyle(fontSize: 14),
          labelText: "Search",
          prefixIcon: Icon(
            Icons.search,
            color: AppColor.greyColor,
          ),
          hintText: "Search",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.tabColor),
          ),
        ),
        searchTextStyle: TextStyle(
          fontSize: 14,
        ),
      ),
      onSelect: onSelect);
}
