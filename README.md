# CloudStreamXR-Beta 🚀

Repositori resmi distribusi pembaruan (OTA Update) dan perilisan versi Beta / Prerelease untuk **CloudStreamXR**.

## 📌 URL Update JSON (jsDelivr CDN)

```text
https://cdn.jsdelivr.net/gh/xr3ed/CloudStreamXR-Beta@main/update.json
```

## 🔄 Alur Pembaruan Otomatis

1. Setiap rilis APK baru akan diunggah ke [GitHub Releases](https://github.com/xr3ed/CloudStreamXR-Beta/releases).
2. File `update.json` diperbarui dengan `versionCode`, `versionName`, dan URL unduhan APK.
3. GitHub Actions (`purge.yml`) akan otomatis membersihkan cache jsDelivr agar notifikasi pembaruan langsung terkirim ke seluruh pengguna seketika.
