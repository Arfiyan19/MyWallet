import 'package:myWallet/helper/dbhelper.dart';
import 'package:myWallet/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myWallet/providers/user_provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  String developerName = "Arfiyan Wahyu Pratama";
  String developerNim = "2141764049";
  String dateApp = "24 September 2023";

  final DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    // Access the UserProvider to get user data
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: const Text(
                "Ubah Password",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Saat Ini",
                labelStyle: TextStyle(color: Color.fromARGB(255, 226, 223, 14)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 226, 223, 14))),
              ),
            ),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Baru",
                labelStyle: TextStyle(color: Color.fromARGB(255, 226, 223, 14)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 226, 223, 14))),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _changePassword(user!);
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)))),
              child: const Text("Simpan Password Baru"),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Kembal
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green.shade800),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)))),
                child: const Text("<< Kembali")),
            const SizedBox(height: 40),
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/images/profile.jpg'), // Gantilah dengan path gambar Anda
                  radius: 50,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // create bold heading style
                      const Text(
                        "About this App",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Text("Aplikasi ini dibuat oleh: "),
                      Text("Nama : $developerName"),
                      Text("Nim : $developerNim"),
                      Text("Tanggal : $dateApp"),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword(User user) {
    String currentPasswordInput = currentPasswordController.text;
    String newPasswordInput = newPasswordController.text;

    if (currentPasswordInput == user.password) {
      // Password saat ini benar, simpan password baru
      dbHelper.changePassword(user.email!, newPasswordInput);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password berhasil diubah."),
      ));
    } else {
      // Password saat ini salah
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password saat ini salah. Ubah password gagal."),
      ));
    }
  }
}
