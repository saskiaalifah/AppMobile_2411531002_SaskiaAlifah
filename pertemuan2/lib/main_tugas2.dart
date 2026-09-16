// =============================================================
// PRAKTIKUM II : Layouting & Styling
// File Tugas — dikembangkan dari praktikum2_main.dart
//
// Tugas 1 (Styling):
//   Pada widget Daftar Transaksi (ListTile), warna trailing text
//   pengeluaran diatur menjadi MERAH (Colors.red) dan pemasukan
//   menjadi HIJAU (Colors.green). Diterapkan lewat helper
//   _buildTransactionTile() agar konsisten di semua item.
//
// Tugas 2 (Tambah Data):
//   Menambahkan 2 transaksi fiktif baru di bawah daftar yang sudah
//   ada, yaitu "Belanja Bulanan" (pengeluaran) dan "Bonus Proyek"
//   (pemasukan).
// =============================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// -------------------------------------------------------------
// 1. WIDGET UTAMA (Root Aplikasi)
// -------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const DashboardScreen(),
    );
  }
}

// -------------------------------------------------------------
// 2. HALAMAN UTAMA (Scaffold)
// -------------------------------------------------------------
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktikum 2: Layouting (Tugas)'),
        backgroundColor: Colors.teal,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingWidget(),
              SizedBox(height: 20),
              BalanceCardWidget(),
              SizedBox(height: 20),
              ActionButtonsWidget(),
              SizedBox(height: 20),
              RecentTransactionsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// 3. STATELESS WIDGET (Sapaan Pengguna) — tidak berubah
// -------------------------------------------------------------
class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.teal,
          child: Icon(Icons.person, size: 30, color: Colors.white),
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, Budi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Selamat datang kembali!',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}

// -------------------------------------------------------------
// 4. STATEFUL WIDGET (Kartu Saldo) — membawa hasil Tugas Modul 1
// -------------------------------------------------------------
class BalanceCardWidget extends StatefulWidget {
  const BalanceCardWidget({super.key});

  @override
  State<BalanceCardWidget> createState() => _BalanceCardWidgetState();
}

class _BalanceCardWidgetState extends State<BalanceCardWidget> {
  bool _isBalanceVisible = true;
  final String _balance = 'Rp 5.000.000';
  final String _noRekening = '1234-5678';

  void _toggleVisibility() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.teal.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.teal.shade400, Colors.teal.shade700],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Saldo Utama',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      letterSpacing: 0.5,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isBalanceVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: _toggleVisibility,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _isBalanceVisible ? _balance : 'Rp *********',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(color: Colors.white24, height: 1),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.credit_card,
                    size: 16,
                    color: Colors.white70,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'No. Rekening: $_noRekening',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// 5. WIDGET TOMBOL AKSI (ROW + CONTAINER)
// -------------------------------------------------------------
class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(Icons.arrow_downward, 'Pemasukan', Colors.green),
        _buildActionButton(Icons.arrow_upward, 'Pengeluaran', Colors.red),
        _buildActionButton(Icons.swap_horiz, 'Transfer', Colors.teal),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        ),
      ],
    );
  }
}

// -------------------------------------------------------------
// 6. WIDGET DAFTAR TRANSAKSI (COLUMN + LISTTILE) — versi Tugas
// -------------------------------------------------------------
class RecentTransactionsWidget extends StatelessWidget {
  const RecentTransactionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transaksi Terakhir',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              // ---------- Data lama ----------
              _buildTransactionTile(
                icon: Icons.fastfood,
                iconColor: Colors.redAccent,
                title: 'Makan Siang',
                date: '13 Sep 2026',
                amount: 'Rp 50.000',
                isIncome: false,
              ),
              const Divider(height: 1),
              _buildTransactionTile(
                icon: Icons.attach_money,
                iconColor: Colors.green,
                title: 'Gaji Bulanan',
                date: '01 Sep 2026',
                amount: 'Rp 5.000.000',
                isIncome: true,
              ),
              const Divider(height: 1),
              _buildTransactionTile(
                icon: Icons.directions_car,
                iconColor: Colors.teal,
                title: 'Isi Bensin',
                date: '10 Sep 2026',
                amount: 'Rp 150.000',
                isIncome: false,
              ),

              // ---------- TUGAS 2: 2 transaksi fiktif baru ----------
              const Divider(height: 1),
              _buildTransactionTile(
                icon: Icons.shopping_cart,
                iconColor: Colors.orange,
                title: 'Belanja Bulanan',
                date: '08 Sep 2026',
                amount: 'Rp 320.000',
                isIncome: false, // pengeluaran -> trailing merah
              ),
              const Divider(height: 1),
              _buildTransactionTile(
                icon: Icons.card_giftcard,
                iconColor: Colors.purple,
                title: 'Bonus Proyek',
                date: '05 Sep 2026',
                amount: 'Rp 750.000',
                isIncome: true, // pemasukan -> trailing hijau
              ),
            ],
          ),
        ),
      ],
    );
  }

  // TUGAS 1 (Styling):
  // Helper ini menentukan warna dan tanda trailing text secara otomatis.
  // isIncome == true  -> hijau (Colors.green) dengan tanda "+"
  // isIncome == false -> merah (Colors.red)  dengan tanda "-"
  Widget _buildTransactionTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String date,
    required String amount,
    required bool isIncome,
  }) {
    final Color trailingColor = isIncome ? Colors.green : Colors.red;
    final String prefix = isIncome ? '+ ' : '- ';

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: iconColor,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title),
      subtitle: Text(date),
      trailing: Text(
        '$prefix$amount',
        style: TextStyle(color: trailingColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
