import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kalkulator Kabataku'),
        ),
        body: const KalkulatorForm(),
      ),
    );
  }
}

class KalkulatorForm extends StatefulWidget {
  const KalkulatorForm({super.key});

  @override
  State<KalkulatorForm> createState() => _KalkulatorFormState();
}

class _KalkulatorFormState extends State<KalkulatorForm> {
  // Key untuk widget Form, dipakai untuk memanggil validate() dari luar Form
  final _formKey = GlobalKey<FormState>();

  // Controller untuk menampung inputan angka pertama dan angka kedua
  final _angka1Controller = TextEditingController();
  final _angka2Controller = TextEditingController();

  // Variable untuk menyimpan teks hasil operasi yang akan ditampilkan
  String _hasil = 'Hasil akan tampil di sini';

  @override
  void dispose() {
    // Membersihkan controller ketika widget sudah tidak dipakai lagi
    _angka1Controller.dispose();
    _angka2Controller.dispose();
    super.dispose();
  }

  // Method umum untuk menjalankan operasi kabataku (kali, bagi, tambah, kurang)
  // parameter "operator" menentukan operasi apa yang dijalankan
  void _hitung(String operator) {
    // Jalankan validasi dulu, kalau ada field kosong maka proses dihentikan
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Ambil nilai dari controller lalu ubah dari String menjadi angka (double)
    double angka1 = double.parse(_angka1Controller.text);
    double angka2 = double.parse(_angka2Controller.text);

    double hasilOperasi;
    String simbol;

    switch (operator) {
      case 'tambah':
        hasilOperasi = angka1 + angka2;
        simbol = '+';
        break;
      case 'kurang':
        hasilOperasi = angka1 - angka2;
        simbol = '-';
        break;
      case 'kali':
        hasilOperasi = angka1 * angka2;
        simbol = 'x';
        break;
      case 'bagi':
        if (angka2 == 0) {
          // Mencegah pembagian dengan nol yang akan menghasilkan error/infinity
          setState(() {
            _hasil = 'Tidak bisa membagi dengan nol';
          });
          return;
        }
        hasilOperasi = angka1 / angka2;
        simbol = '/';
        break;
      default:
        return;
    }

    // setState() memberitahu Flutter bahwa ada perubahan data,
    // sehingga widget Text hasil perlu di-rebuild dengan nilai yang baru
    setState(() {
      _hasil = '$angka1 $simbol $angka2 = $hasilOperasi';
    });
  }

  // Fungsi validator yang dipakai bersama oleh kedua TextFormField
  String? _validasiAngka(String? value) {
    if (value == null || value.isEmpty) {
      return 'Masukkan angka';
    }
    if (double.tryParse(value) == null) {
      return 'Harus berupa angka';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            // Input widget pertama: angka 1
            TextFormField(
              controller: _angka1Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Angka Pertama',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
              validator: _validasiAngka,
            ),
            const SizedBox(height: 15),
            // Input widget kedua: angka 2
            TextFormField(
              controller: _angka2Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Angka Kedua',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
              validator: _validasiAngka,
            ),
            const SizedBox(height: 20),
            // Baris tombol operasi kabataku: Kali, Bagi, Tambah, Kurang
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton(
                      onPressed: () => _hitung('kali'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Kali'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton(
                      onPressed: () => _hitung('bagi'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Bagi'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton(
                      onPressed: () => _hitung('tambah'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Tambah'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton(
                      onPressed: () => _hitung('kurang'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Kurang'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            // Text widget untuk menampilkan hasil operasi
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                _hasil,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
