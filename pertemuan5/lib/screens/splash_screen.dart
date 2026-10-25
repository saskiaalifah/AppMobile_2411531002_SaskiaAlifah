import 'package:flutter/material.dart';
import '../utils/session.dart';

/// Mengecek sesi login: sudah login -> /main, belum -> /login
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _check();
  }

  Future<void> _check() async {
    final id = await Session.getUserId();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, id == null ? '/login' : '/main');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
