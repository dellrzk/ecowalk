import 'package:flutter/material.dart';
import 'lupa_sandi_hp.dart';
import 'verifikasi_lupa_sandi.dart';

class LupaSandiPage extends StatefulWidget {
  const LupaSandiPage({super.key});

  @override
  State<LupaSandiPage> createState() => _LupaSandiPageState();
}

class _LupaSandiPageState extends State<LupaSandiPage> {
  static const Color greenColor = Color(0xFF1A6556);
  static const Color topColor = Color(0xFFDCEAE7);
  static const Color blueColor = Color(0xFF00BDEB);

  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void kirimKode() {
  if (emailController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Masukkan alamat email terlebih dahulu',
        ),
      ),
    );
    return;
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => VerifikasiLupaSandiPage(
        viaEmail: true,
        tujuan: emailController.text.trim(),
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
            // =====================================
            // HEADER
            // =====================================
            SizedBox(
              height: 265,
              child: Stack(
                children: [
                  // Background atas miring
                  ClipPath(
                    clipper: LupaSandiClipper(),
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

            // =====================================
            // ISI
            // =====================================
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 18),

                  // Informasi
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.notifications_none,
                        color: Colors.black,
                        size: 27,
                      ),

                      SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          'Periksa dan masukan alamat Email untuk mendapatkan\nkode verifikasi',
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

                  // =====================================
                  // ALAMAT EMAIL
                  // =====================================
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,

                    decoration: const InputDecoration(
                      labelText: 'Alamat Email',

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

                  // =====================================
                  // GUNAKAN NOMOR HP
                  // =====================================
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const LupaSandiHpPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Gunakan Nomor Hp',
                        style: TextStyle(
                          color: blueColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 36),

                  // =====================================
                  // TOMBOL KIRIM
                  // =====================================
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
                          borderRadius: BorderRadius.circular(5),
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


// =====================================
// BACKGROUND MIRING
// =====================================
class LupaSandiClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Atas kiri
    path.moveTo(0, 0);

    // Atas kanan
    path.lineTo(size.width, 0);

    // Bawah kanan
    path.lineTo(size.width, 260);

    // Bawah kiri
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