import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration kinputDecoration = InputDecoration(
    contentPadding: EdgeInsets.only(
      left: 24,
      top: 16,
      bottom: 15,
    ),
    hintStyle: GoogleFonts.openSans(color: Color(0XFFA0A0A0), fontSize: 14),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFF6F6F6)),
        borderRadius: BorderRadius.circular(8)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFF6F6F6)),
        borderRadius: BorderRadius.circular(8)),
    border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFF6F6F6), width: 1.0),
        borderRadius: BorderRadius.circular(8)));
