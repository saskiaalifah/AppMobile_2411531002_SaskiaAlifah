import 'package:flutter/material.dart';
import 'transaction_data.dart';
import 'transaction_tile.dart';

class DashboardScreen extends StatelessWidget {
  final String email;

  const DashboardScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    // Ambil 3 transaksi terbaru saja untuk ditampilkan di dashboard
    final recent = dummyTransactions.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Keuangan'),
        backgroundColor: Colors.amber[800],
        foregroundColor: Colors.white,
      ),
      // Tombol mengambang (FAB) untuk tambah transaksi
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
        onPressed: () {
          // Memanggil Rute yang sudah didaftarkan di main.dart
          Navigator.pushNamed(context, '/add');
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Halo, $email', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildBalanceCard(),
            const SizedBox(height: 20),
            const Text('Transaksi Terakhir', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              child: Column(
                children: [
                  for (int i = 0; i < recent.length; i++) ...[
                    TransactionTile(item: recent[i]),
                    if (i < recent.length - 1) const Divider(height: 1),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Card(
      elevation: 4,
      color: Colors.amber[700],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Saldo Utama', style: TextStyle(fontSize: 16, color: Colors.white70)),
            SizedBox(height: 8),
            Text('Rp 5.000.000', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
