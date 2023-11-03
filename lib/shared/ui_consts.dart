import 'package:flutter/material.dart';

// TextStyles

final TextStyle superTitleStyle = TextStyle(
  fontSize: 48,
  fontWeight: FontWeight.bold,
  color: colors.background,
);

final TextStyle titleStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
  color: colors.background,
);

final TextStyle subtitleStyle = TextStyle(
  fontSize: 20,
  color: colors.background,
);

// Colors

final colors = ColorScheme.fromSeed(seedColor: Colors.deepPurple);

// PercentIndicator

const double lineWidthPercentIndicator = 5.0;

// Navbar

const double navbarRadius = 50.0;

const double paddingWidth = 0.2;
const double paddingHeight = 0.05;
const double height = 0.155;

const double boxShadowOpacity = 0.5;
const double boxBlurRadius = 30.0;
const double boxOffsetX = 0.0;
const double boxOffsetY = 10.0;

// API
const imageUri = 'https://image.tmdb.org/t/p/w500';
