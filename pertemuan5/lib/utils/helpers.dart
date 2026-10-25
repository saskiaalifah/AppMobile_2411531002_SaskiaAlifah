import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

String formatRupiah(int value) {
  final s = value.abs().toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return 'Rp $buf';
}

String formatDate(DateTime d) {
  final dd = d.day.toString().padLeft(2, '0');
  final mm = d.month.toString().padLeft(2, '0');
  return '$dd/$mm/${d.year}';
}

String hashPassword(String password) =>
    sha256.convert(utf8.encode(password)).toString();

const List<String> kCategories = [
  'Makanan',
  'Transportasi',
  'Hiburan',
  'Gaji',
  'Lainnya',
];

IconData categoryIcon(String category) {
  switch (category) {
    case 'Makanan':
      return Icons.fastfood;
    case 'Transportasi':
      return Icons.directions_car;
    case 'Hiburan':
      return Icons.movie;
    case 'Gaji':
      return Icons.attach_money;
    default:
      return Icons.category;
  }
}
