import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class AppWidget {
  static TextStyle boldTextFieldStyle() {
    return GoogleFonts.roboto(
      color: Colors.black,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle lightTexFieldStyle() {
    return GoogleFonts.robotoSerif(
      color: Colors.black54,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
  }
  
}
