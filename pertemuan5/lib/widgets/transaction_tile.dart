import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../utils/helpers.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback onTap;

  const TransactionTile({
    super.key,
    required this.transaction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = transaction;
    final color = t.isIncome ? Colors.green : Colors.red;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Icon(categoryIcon(t.category), color: Colors.white),
      ),
      title: Text(t.title),
      subtitle: Text(formatDate(t.date)),
      trailing: Text(
        '${t.isIncome ? '+' : '-'} ${formatRupiah(t.amount)}',
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    );
  }
}
