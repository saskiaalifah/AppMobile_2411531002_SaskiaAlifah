import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/app_user.dart';
import '../models/transaction_model.dart';
import '../utils/helpers.dart';
import '../utils/session.dart';
import '../widgets/transaction_tile.dart';
import 'transaction_detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  AppUser? _user;
  int _income = 0;
  int _expense = 0;
  List<TransactionModel> _recent = [];
  bool _isBalanceVisible = true; // Praktikum 1: toggle saldo
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final id = await Session.getUserId();
    if (id == null) return;
    final db = DatabaseHelper.instance;
    final user = await db.getUserById(id);
    final totals = await db.getTotals(id);
    final recent = await db.getTransactions(id, limit: 5);
    if (!mounted) return;
    setState(() {
      _user = user;
      _income = totals['income']!;
      _expense = totals['expense']!;
      _recent = recent;
      _loading = false;
    });
  }

  Future<void> _openAdd([String? type]) async {
    await Navigator.pushNamed(context, '/add', arguments: type);
    _load();
  }

  Future<void> _openDetail(TransactionModel t) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionDetailScreen(transaction: t),
      ),
    );
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final balance = _income - _expense;
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
        onPressed: () => _openAdd(),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(balance),
                    const SizedBox(height: 20),
                    _buildActionButtons(),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildRecent(),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildHeader(int balance) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 20, 20, 24),
      decoration: const BoxDecoration(
        color: Color(0xFFF59E0B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, ${_user?.name ?? ''}!',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      _isBalanceVisible
                          ? '${balance < 0 ? '- ' : ''}${formatRupiah(balance)}'
                          : 'Rp *********',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _isBalanceVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () => setState(
                          () => _isBalanceVisible = !_isBalanceVisible),
                    ),
                  ],
                ),
                Text(
                  _isBalanceVisible
                      ? 'Masuk ${formatRupiah(_income)}  •  Keluar ${formatRupiah(_expense)}'
                      : 'Masuk Rp ***  •  Keluar Rp ***',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 28, color: Color(0xFFF59E0B)),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _actionButton(Icons.arrow_downward, 'Pemasukan', Colors.amber,
            () => _openAdd('income')),
        _actionButton(Icons.arrow_upward, 'Pengeluaran', Colors.red,
            () => _openAdd('expense')),
        _actionButton(Icons.swap_horiz, 'Transfer', Colors.blue, () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Fitur transfer belum tersedia')),
          );
        }),
      ],
    );
  }

  Widget _actionButton(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Transaksi Terakhir',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        if (_recent.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: Text('Belum ada transaksi')),
            ),
          )
        else
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                for (var i = 0; i < _recent.length; i++) ...[
                  if (i > 0) const Divider(height: 1),
                  TransactionTile(
                    transaction: _recent[i],
                    onTap: () => _openDetail(_recent[i]),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}
