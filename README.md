# CloudStreamXR-Beta 🚀

Repositori resmi untuk distribusi, metadata rilis, dan pembaruan otomatis versi Beta / Prerelease aplikasi klon **CloudStreamXR-Beta**. Aplikasi ini dikustomisasi secara khusus menggunakan pipeline Android App Cloner dengan penyatuan data kustom dan alur pembaruan in-app yang mulus.

---

## 🌟 Fitur Unggulan CloudStreamXR-Beta

Aplikasi klon versi Beta ini dilengkapi dengan fitur premium berikut:

### 1. 📦 Penyatuan & Pemulihan Data Kustom (Auto-Restore)
* **Data Bundling**: Pengguna dapat menyatukan konfigurasi, daftar putar, riwayat tontonan, dan pengaturan ekstensi bawaan ke dalam satu paket ZIP biner saat proses kloning.
* **Auto-Restore on Launch**: Ketika aplikasi dipasang pertama kali di HP/TV pengguna baru, ia otomatis mendeteksi dan memulihkan seluruh data konfigurasi tersebut ke folder internal aplikasi secara instan tanpa memerlukan akses root manual.

### 2. ⚡ In-App Auto Update (Pembaruan Otomatis)
* **Pengecekan Asinkron**: Setiap kali aplikasi diluncurkan, ia akan membaca konfigurasi jarak jauh `update.json` di latar belakang secara asinkron.
* **Dialog Unduhan Kustom**: Jika tersedia versi terbaru, aplikasi memunculkan dialog pembaruan otomatis. Saat proses download berlangsung, aplikasi menampilkan progress bar horizontal dengan hitungan byte real-time (misal: `Mengunduh: 45% (12.40 MB / 27.50 MB)`).
* **Auto-Installer via FileProvider**: Setelah berkas APK selesai diunduh, aplikasi secara otomatis memicu Android Package Installer menggunakan `FileProvider` resmi bawaan aplikasi secara dinamis.
* **Build-Time Detection**: Deteksi pembaruan menggunakan penanda waktu (timestamp) milidetik yang di-inject otomatis saat proses kloning berjalan. Mencegah error loop update pada nomor versi yang sama.

### 3. 🎨 Kustomisasi Dinamis & Kompatibilitas Luas
* **Dukungan Penuh Android 6 s/d 16 & Android TV**: Dilengkapi Composite TrustManager Root CA modern (*ISRG Root X1/X2, DigiCert, GlobalSign, USERTrust*) dan Smart Fallback DoH untuk menembus sensor ISP secara stabil.
* **Custom Extension Label**: Label ekstensi/plugin dapat disesuaikan untuk melokalisasi menu (misal: *"Ekstensi Saya"*, *"Daftar Provider"*, dll.).
* **QRIS Donation Integration**: Menampilkan dialog donasi QRIS kustom untuk mempermudah donatur melakukan scan kode pembayaran langsung dari dalam aplikasi.

---

## 🔗 Tautan Metadata Pembaruan

Gunakan salah satu URL di bawah ini untuk mengisi opsi **Update JSON URL** di aplikasi **App Cloner** saat membuat klon baru:

* **⭐ Jalur jsDelivr CDN (Direkomendasikan - Bebas Rate Limit 429 & Auto-Purge)**
  ```text
  https://cdn.jsdelivr.net/gh/xr3ed/CloudStreamXR-Beta@main/update.json
  ```

* **Jalur GitHub Raw (Alternatif jika CDN mengalami gangguan)**
  ```text
  https://raw.githubusercontent.com/xr3ed/CloudStreamXR-Beta/main/update.json
  ```

---

## 📋 Struktur Metadata Pembaruan (`update.json`)

Berkas `update.json` di repositori ini berfungsi sebagai pusat kontrol pembaruan aplikasi klon. Format konfigurasinya adalah sebagai berikut:

```json
{
  "versionCode": 79781056,
  "versionName": "4.8.0-BETA",
  "apkUrl": "https://github.com/xr3ed/CloudStreamXR-Beta/releases/download/4.8.0-BETA/CloudStreamXR-Beta.apk",
  "changelog": "Perbaikan SSL Root CA (Android 6 / Android TV), Smart DoH & ExoPlayer OkHttp",
  "forceUpdate": false,
  "buildTime": 1786880000000
}
```

* **`versionCode`**: Kode versi asli APK pembantu.
* **`versionName`**: Label nama rilis yang akan ditampilkan di dialog pembaruan HP pengguna.
* **`apkUrl`**: Link tautan unduhan langsung berkas APK baru (diarahkan ke GitHub Releases).
* **`forceUpdate`**: Jika diset `true`, pengguna tidak bisa melewati dialog update dan tombol negatif akan berubah menjadi tombol keluar aplikasi paksa.
* **`buildTime`**: Penanda unik waktu pembuatan klon untuk mendeteksi update tumpang-tindih.

---

## 🚀 Cara Merilis Update (DevOps Otomatis)

### Opsi A: Menggunakan Script Otomatis Terminal / PowerShell
Jalankan perintah ini di komputer:
```powershell
powershell -ExecutionPolicy Bypass -File "publish_beta.ps1" `
  -ApkPath "E:\proyyek\cloudsterm\CloudStream\app\build\outputs\apk\prerelease\release\app-prerelease-release.apk" `
  -VersionName "4.8.0-BETA" `
  -VersionCode 79781056 `
  -Changelog "Perbaikan SSL Root CA Android 6, Smart DoH & ExoPlayer OkHttp"
```

### Opsi B: Dari Aplikasi App Cloner di HP
1. Buat klon baru di menu **Clone**.
2. Masuk ke tab **History** di Cloner.
3. Klik tombol ikon **Awan (Cloud Upload)** di samping riwayat klon yang baru dibuat.
4. Masukkan nomor versi, tag rilis, dan changelog di dialog pop-up yang muncul.
5. Klik **Push Now**. Aplikasi Cloner akan otomatis membuat rilis baru di GitHub, mengunggah APK, dan memperbarui berkas `update.json` di repositori ini secara instan!

---
*Dikembangkan dengan ❤️ untuk CloudStreamXR Community.*
