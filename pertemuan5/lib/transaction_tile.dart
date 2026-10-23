import 'package:flutter/material.dart';
import 'transaction_data.dart';
import 'transaction_detail_screen.dart';

class TransactionTile extends StatelessWidget {
  final TransactionItem item;

  const TransactionTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: item.isIncome ? Colors.green : Colors.orange,
        child: Icon(item.icon, color: Colors.white),
      ),
      title: Text(item.title),
      subtitle: Text(item.date),
      trailing: Text(
        item.amount,
        style: TextStyle(
          color: item.isIncome ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        // NAVIGASI PUSH DENGAN DATA (Passing Data)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailScreen(
              title: item.title,
              amount: item.amount,
              category: item.category,
              date: item.date,
            ),
          ),
        );
      },
    );
  }
}
