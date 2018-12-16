import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voice/model/category.dart';
import 'package:voice/model/country.dart';
import 'package:voice/widget/document_content.dart';

class PlatformContent {

  List<Widget> generate(int categoryIndex, int selectedCountryIndex) {
    return _buildContentWidgets(categoryIndex, selectedCountryIndex);
  }

  List<Widget> _buildContentWidgets(
      int categoryIndex, int selectedCountryIndex) {
    if (Platform.isAndroid) {
      return [
        categoryIndex == 3
            ? _buildContentWidget(3, categoryIndex)
            : _buildContentWidget(0, categoryIndex),
        _buildContentWidget(1, categoryIndex),
        _buildContentWidget(2, categoryIndex)
      ];
    } else {
      return categoryIndex == 3
          ? [_buildContentWidget(3, categoryIndex)]
          : [_buildContentWidget(selectedCountryIndex, categoryIndex)];
    }
  }

  Widget _buildContentWidget(int selectedCountryIndex, int navigationIndex) {
    return SafeArea(
        child: DocumentContent(
      selectedCategory: categories[navigationIndex].documentName,
      selectedCountry: countries[selectedCountryIndex].country,
    ));
  }
}
