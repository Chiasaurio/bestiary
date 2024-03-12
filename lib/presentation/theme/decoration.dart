import 'package:flutter/material.dart';

import 'colors.dart';

const scaffoldDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.3, 1],
    colors: scaffoldColors,
  ),
);
