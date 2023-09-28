import 'package:flutter/material.dart';

enum VideoCategory { budget, invest, debt, tax }

class VidCategory {
  const VidCategory(this.title);

  final String title;
}

const vidcategories = {
  VideoCategory.budget : VidCategory('Budgeting'),
  VideoCategory.invest : VidCategory('Investing and Saving'),
  VideoCategory.debt : VidCategory('Debt Management'),
  VideoCategory.tax : VidCategory('Tax Planning'),

};
