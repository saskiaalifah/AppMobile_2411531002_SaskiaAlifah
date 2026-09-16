// =============================================================
// PRAKTIKUM II : Layouting & Styling
// Row, Column, Container, dan ListTile
// File Langkah Praktikum — lanjutan dari praktikum1_tugas.dart
//
// Komponen lanjutan dari Modul 1 (dipertahankan):
//   - Tema teal (hasil Tugas 1 Praktikum 1)
//   - Kartu saldo bergradasi + teks "No. Rekening" (hasil Tugas 2 Praktikum 1)
//
// Komponen BARU Modul 2:
//   - ActionButtonsWidget  -> Row + Container (padding, margin, warna)
//   - RecentTransactionsWidget -> Column + ListTile
//   - SingleChildScrollView agar layar tidak overflow
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
// 2. HALAMAN UTAMA (Scaffold) — DIPERBARUI
//    Dibungkus SingleChildScrollView agar bisa di-scroll vertikal
// -------------------------------------------------------------
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktikum 2: Layouting'),
        backgroundColor: Colors.teal,
      ),
      // MENGGUNAKAN SingleChildScrollView agar layar bisa di-scroll
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingWidget(), // Dari Modul 1
              SizedBox(height: 20),
              BalanceCardWidget(), // Dari Modul 1
              SizedBox(height: 20),
              ActionButtonsWidget(), // WIDGET BARU MODUL 2 (Row)
              SizedBox(height: 20),
              RecentTransactionsWidget(), // WIDGET BARU MODUL 2 (Column + ListTile)
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// 3. STATELESS WIDGET (Sapaan Pengguna) — Dari Modul 1
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
// 4. STATEFUL WIDGET (Kartu Saldo dengan Toggle) — Dari Modul 1
//    Tetap membawa hasil Tugas 1 & 2 Praktikum 1
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
              // Baris atas kartu: Teks "Saldo Utama" & Tombol Ikon
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
              // Teks Nominal Saldo
              Text(
                _isBalanceVisible ? _balance : 'Rp *********',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // Nomor rekening (hasil Tugas 2 Praktikum 1)
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
// 5. WIDGET TOMBOL AKSI (ROW + CONTAINER) — BARU MODUL 2
//    mainAxisAlignment: spaceEvenly -> ruang kosong dibagi rata
// -------------------------------------------------------------
class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan Row untuk menata tombol secara horizontal
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Jarak dibagi rata
      children: [
        _buildActionButton(Icons.arrow_downward, 'Pemasukan', Colors.green),
        _buildActionButton(Icons.arrow_upward, 'Pengeluaran', Colors.red),
        _buildActionButton(Icons.swap_horiz, 'Transfer', Colors.teal),
      ],
    );
  }

  // Fungsi pembantu agar kode tombol tidak berulang
  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        // Container: mengatur padding, warna background, dan sudut membulat
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15), // Warna transparan
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
// 6. WIDGET DAFTAR TRANSAKSI (COLUMN + LISTTILE) — BARU MODUL 2
//    leading (ikon) - title (judul) - trailing (nominal)
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
        // Card agar daftar transaksi memiliki bayangan/bingkai
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              // Item Transaksi 1
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  child: Icon(Icons.fastfood, color: Colors.white),
                ),
                title: const Text('Makan Siang'),
                subtitle: const Text('13 Sep 2026'),
                trailing: const Text(
                  '- Rp 50.000',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(height: 1), // Garis pemisah
              // Item Transaksi 2
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.attach_money, color: Colors.white),
                ),
                title: const Text('Gaji Bulanan'),
                subtitle: const Text('01 Sep 2026'),
                trailing: const Text(
                  '+ Rp 5.000.000',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(height: 1),

              // Item Transaksi 3
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.directions_car, color: Colors.white),
                ),
                title: const Text('Isi Bensin'),
                subtitle: const Text('10 Sep 2026'),
                trailing: const Text(
                  '- Rp 150.000',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
