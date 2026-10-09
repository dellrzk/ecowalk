
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';

class UbahSandiPage extends StatefulWidget {
  const UbahSandiPage({super.key});

  @override
  State<UbahSandiPage> createState() => _UbahSandiPageState();
}

class _UbahSandiPageState extends State<UbahSandiPage> {
  static const Color greenColor = Color(0xFF1A6556);
  static const Color topColor = Color(0xFFDCEAE7);

  final TextEditingController passwordBaruController =
      TextEditingController();

  final TextEditingController konfirmasiPasswordController =
      TextEditingController();

  bool hidePasswordBaru = true;
  bool hideKonfirmasiPassword = true;

  @override
  void dispose() {
    passwordBaruController.dispose();
    konfirmasiPasswordController.dispose();
    super.dispose();
  }

  // =====================================
  // FUNGSI UBAH KATA SANDI
  // =====================================
  void ubahKataSandi() {
    String passwordBaru = passwordBaruController.text;
    String konfirmasi = konfirmasiPasswordController.text;

    if (passwordBaru.isEmpty || konfirmasi.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kata sandi harus diisi'),
        ),
      );
      return;
    }

    if (passwordBaru != konfirmasi) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Konfirmasi kata sandi tidak sama'),
        ),
      );
      return;
    }

    // Simulasi berhasil ubah kata sandi.
    // Kembali ke halaman Login.
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
      (route) => false,
    );
  }

  // =====================================
  // TAMPILAN HALAMAN
  // =====================================
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),

      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,

        // Tidak menggunakan SafeArea di atas
        // supaya warna header sampai ke status bar.
        body: Stack(
          children: [

            // =====================================
            // BACKGROUND HIJAU MUDA FULL ATAS
            // =====================================
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: UbahSandiClipper(),
                child: Container(
                  height: 265,
                  width: double.infinity,
                  color: topColor,
                ),
              ),
            ),

            // =====================================
            // ISI HALAMAN
            // =====================================
            SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    // HEADER
                    SizedBox(
                      height: 265,
                      child: Stack(
                        children: [

                          // LOGO ECOWALK
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

                          // JUDUL
                          const Positioned(
                            top: 202,
                            left: 0,
                            right: 0,
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
                    // FORM UBAH KATA SANDI
                    // =====================================
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SizedBox(height: 36),

                          // JUDUL KECIL
                          const Text(
                            'Masukan Kata Sandi Baru',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 37),

                          // =====================================
                          // KATA SANDI BARU
                          // =====================================
                          TextField(
                            controller: passwordBaruController,
                            obscureText: hidePasswordBaru,

                            decoration: InputDecoration(
                              hintText: 'Kata Sandi Baru',

                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                              ),

                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.grey,
                                size: 20,
                              ),

                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePasswordBaru =
                                        !hidePasswordBaru;
                                  });
                                },
                                icon: Icon(
                                  hidePasswordBaru
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ),

                              enabledBorder:
                                  const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                ),
                              ),

                              focusedBorder:
                                  const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: greenColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          // =====================================
                          // KONFIRMASI KATA SANDI
                          // =====================================
                          TextField(
                            controller:
                                konfirmasiPasswordController,
                            obscureText: hideKonfirmasiPassword,

                            decoration: InputDecoration(
                              hintText: 'Konfirmasi Kata Sandi',

                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                              ),

                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.grey,
                                size: 20,
                              ),

                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hideKonfirmasiPassword =
                                        !hideKonfirmasiPassword;
                                  });
                                },
                                icon: Icon(
                                  hideKonfirmasiPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ),

                              enabledBorder:
                                  const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                ),
                              ),

                              focusedBorder:
                                  const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: greenColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 56),

                          // =====================================
                          // TOMBOL UBAH KATA SANDI
                          // =====================================
                          SizedBox(
                            width: double.infinity,
                            height: 45,

                            child: ElevatedButton(
                              onPressed: ubahKataSandi,

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
                                'UBAH KATA SANDI',
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
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================
// BACKGROUND MIRING FULL ATAS
// =====================================
class UbahSandiClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
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
