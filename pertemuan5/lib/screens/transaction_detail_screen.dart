import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/transaction_model.dart';
import '../utils/helpers.dart';

/// Praktikum 4: menerima data lewat constructor (passing data)
class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  Future<void> _delete(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Transaksi'),
        content: const Text('Yakin ingin menghapus transaksi ini?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Hapus', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
    if (ok != true) return;
    await DatabaseHelper.instance.deleteTransaction(transaction.id!);
    if (!context.mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaksi dihapus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = transaction;
    final color = t.isIncome ? Colors.green : Colors.red;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(categoryIcon(t.category), size: 36, color: color),
            ),
            const SizedBox(height: 24),
            Text(t.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              '${t.isIncome ? '+' : '-'} ${formatRupiah(t.amount)}',
              style: TextStyle(
                  fontSize: 32, fontWeight: FontWeight.bold, color: color),
            ),
            const Divider(height: 40, thickness: 2),
            _row('Kategori', t.category),
            const SizedBox(height: 16),
            _row('Jenis', t.isIncome ? 'Pemasukan' : 'Pengeluaran'),
            const SizedBox(height: 16),
            _row('Tanggal', formatDate(t.date)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.delete),
                label: const Text('Hapus Transaksi'),
                onPressed: () => _delete(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
        Text(value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
