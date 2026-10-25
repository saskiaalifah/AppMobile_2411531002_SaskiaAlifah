# Expense Tracker (Gabungan Praktikum 1-5)

Aplikasi pencatat keuangan Flutter dengan penyimpanan lokal SQLite.

## Fitur

- Register & Login (data user di SQLite, password di-hash SHA-256, sesi disimpan di shared_preferences)
- Dashboard: sapaan, kartu saldo (toggle sensor), tombol aksi, transaksi terakhir
- Tambah transaksi: judul, nominal, kategori (dropdown), jenis, tanggal (date picker), validasi
- Detail transaksi (Navigator.push + constructor) dan hapus
- Riwayat transaksi lengkap
- Profil + logout
- Named Routes + BottomNavigationBar

## Struktur

```
lib/
  main.dart            -> MaterialApp + named routes
  db/                  -> DatabaseHelper (SQLite)
  models/              -> AppUser, TransactionModel
  screens/             -> login, register, splash, main, dashboard, history, profile, add, detail
  widgets/             -> TransactionTile
  utils/               -> format helper, session
```

## Cara menjalankan

```
flutter pub get
flutter run
```

## Build APK

```
flutter build apk --release
```

Hasil: build/app/outputs/flutter-apk/app-release.apk
