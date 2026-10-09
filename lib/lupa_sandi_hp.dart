import 'package:flutter/material.dart';
import 'verifikasi_lupa_sandi.dart';

class LupaSandiHpPage extends StatefulWidget {
  const LupaSandiHpPage({super.key});

  @override
  State<LupaSandiHpPage> createState() => _LupaSandiHpPageState();
}

class _LupaSandiHpPageState extends State<LupaSandiHpPage> {
  static const Color greenColor = Color(0xFF1A6556);
  static const Color topColor = Color(0xFFDCEAE7);
  static const Color blueColor = Color(0xFF00BDEB);

  final TextEditingController nomorHpController =
      TextEditingController();

  @override
  void dispose() {
    nomorHpController.dispose();
    super.dispose();
  }

  void kirimKode() {
  if (nomorHpController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Masukkan nomor HP terlebih dahulu',
        ),
      ),
    );
    return;
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => VerifikasiLupaSandiPage(
        viaEmail: false,
        tujuan: nomorHpController.text.trim(),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            // =========================
            // HEADER
            // =========================
            SizedBox(
              height: 265,
              child: Stack(
                children: [
                  // Background miring
                  ClipPath(
                    clipper: LupaSandiHpClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 265,
                      color: topColor,
                    ),
                  ),

                  // Logo
                  Positioned(
                    top: 145,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Image.asset(
                        'lib/images/logo2.png',
                        width: 235,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // Judul
                  const Positioned(
                    left: 0,
                    right: 0,
                    bottom: 30,
                    child: Text(
                      'LUPA KATA SANDI',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // =========================
            // ISI
            // =========================
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 18),

                  // Keterangan
                  const Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.notifications_none,
                        color: Colors.black,
                        size: 27,
                      ),

                      SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          'Periksa dan masukan Nomor Hp untuk mendapatkan\nkode verifikasi',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13,
                            height: 1.25,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),

                  // =========================
                  // NOMOR HP
                  // =========================
                  TextField(
                    controller: nomorHpController,
                    keyboardType: TextInputType.phone,

                    decoration: const InputDecoration(
                      labelText: 'Nomor Hp',

                      labelStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),

                      floatingLabelBehavior:
                          FloatingLabelBehavior.always,

                      contentPadding: EdgeInsets.only(
                        bottom: 10,
                      ),

                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black54,
                        ),
                      ),

                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: greenColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 34),

                  // =========================
                  // GUNAKAN EMAIL
                  // =========================
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        // Kembali ke halaman lupa sandi Email
                        Navigator.pop(context);
                      },

                      child: const Text(
                        'Gunakan Email',
                        style: TextStyle(
                          color: blueColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 36),

                  // =========================
                  // TOMBOL KIRIM
                  // =========================
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: kirimKode,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenColor,
                        foregroundColor: Colors.white,
                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5),
                        ),
                      ),

                      child: const Text(
                        'KIRIM',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// =========================
// BACKGROUND MIRING
// =========================
class LupaSandiHpClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, 260);
    path.lineTo(0, 115);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(
    covariant CustomClipper<Path> oldClipper,
  ) {
    return false;
  }
}