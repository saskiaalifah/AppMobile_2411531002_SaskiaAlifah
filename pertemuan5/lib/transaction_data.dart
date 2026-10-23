import 'package:flutter/material.dart';

class TransactionItem {
  final String title;
  final String amount;
  final String category;
  final String date;
  final bool isIncome;
  final IconData icon;

  const TransactionItem({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.isIncome,
    required this.icon,
  });
}

// Data contoh transaksi (dummy)
const List<TransactionItem> dummyTransactions = [
  TransactionItem(
    title: 'Makan Siang',
    amount: '- Rp 50.000',
    category: 'Makanan',
    date: '13 September 2026',
    isIncome: false,
    icon: Icons.fastfood,
  ),
  TransactionItem(
    title: 'Transport Ojek',
    amount: '- Rp 20.000',
    category: 'Transportasi',
    date: '12 September 2026',
    isIncome: false,
    icon: Icons.two_wheeler,
  ),
  TransactionItem(
    title: 'Beli Buku',
    amount: '- Rp 75.000',
    category: 'Pendidikan',
    date: '10 September 2026',
    isIncome: false,
    icon: Icons.menu_book,
  ),
  TransactionItem(
    title: 'Bayar Listrik',
    amount: '- Rp 350.000',
    category: 'Tagihan',
    date: '5 September 2026',
    isIncome: false,
    icon: Icons.bolt,
  ),
  TransactionItem(
    title: 'Gaji Bulanan',
    amount: '+ Rp 5.000.000',
    category: 'Pemasukan',
    date: '1 September 2026',
    isIncome: true,
    icon: Icons.attach_money,
  ),
];
