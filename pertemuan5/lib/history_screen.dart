import 'package:flutter/material.dart';
import 'transaction_data.dart';
import 'transaction_tile.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        backgroundColor: Colors.amber[800],
        foregroundColor: Colors.white,
      ),
      body: dummyTransactions.isEmpty
          ? const Center(child: Text('Belum ada transaksi', style: TextStyle(fontSize: 18)))
          : ListView.separated(
              itemCount: dummyTransactions.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return TransactionTile(item: dummyTransactions[index]);
              },
            ),
    );
  }
}
