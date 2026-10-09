
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'verifikasi_email.dart';
import 'login.dart';

class VerifikasiPage extends StatefulWidget {
  const VerifikasiPage({super.key});

  @override
  State<VerifikasiPage> createState() => _VerifikasiPageState();
}

class _VerifikasiPageState extends State<VerifikasiPage> {
  static const Color greenColor = Color(0xFF1A6556);
  static const Color topColor = Color(0xFFDCEAE7);
  static const Color blueColor = Color(0xFF00BDEB);

  final List<TextEditingController> codeControllers =
      List.generate(4, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
      List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in codeControllers) {
      controller.dispose();
    }

    for (final node in focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  // =====================================
  // KOTAK INPUT VERIFIKASI
  // =====================================
  Widget codeBox(int index) {
    return SizedBox(
      height: 76,
      child: TextField(
        controller: codeControllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xFFFAFAFA),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFD0D0D0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: greenColor,
              width: 1.5,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            focusNodes[index + 1].requestFocus();
          }

          if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  // =====================================
  // FUNGSI KIRIM VERIFIKASI
  // =====================================
  void kirimVerifikasi() {
    String kode = '';

    for (final controller in codeControllers) {
      kode += controller.text;
    }

    if (kode.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Masukkan 4 digit kode verifikasi',
          ),
        ),
      );
      return;
    }

    // Simulasi verifikasi berhasil.
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
  // FUNGSI KIRIM ULANG KODE
  // =====================================
  void kirimUlangKode() {
    for (final controller in codeControllers) {
      controller.clear();
    }

    focusNodes[0].requestFocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Simulasi kirim ulang kode verifikasi',
        ),
      ),
    );
  }

  // =====================================
  // TAMPILAN HALAMAN
  // =====================================
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight =
        MediaQuery.viewPaddingOf(context).top;

    final double headerHeight = statusBarHeight + 210;

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

        // Tidak menggunakan SafeArea di bagian atas.
        body: Stack(
          children: [
            // =====================================
            // BACKGROUND PUTIH
            // =====================================
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
            ),

            // =====================================
            // BACKGROUND HIJAU MUDA FULL ATAS
            // =====================================
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: HeaderVerifikasiHpClipper(),
                child: Container(
                  height: headerHeight,
                  width: double.infinity,
                  color: topColor,
                ),
              ),
            ),

            // =====================================
            // ISI HALAMAN
            // =====================================
            SingleChildScrollView(
              child: Column(
                children: [
                  // HEADER DAN LOGO
                  SizedBox(
                    height: headerHeight,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          top: statusBarHeight + 90,
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
                      ],
                    ),
                  ),

                  // =====================================
                  // FORM VERIFIKASI
                  // =====================================
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),

                        // JUDUL VERIFIKASI
                        const Row(
                          children: [
                            Icon(
                              Icons.check,
                              size: 23,
                              color: Colors.black,
                            ),
                            SizedBox(width: 14),
                            Text(
                              'VERIFIKASI',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        // =================================
                        // KETERANGAN VERIFIKASI NOMOR HP
                        // =================================
                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.phonelink_lock,
                              size: 32,
                              color: Colors.black,
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 13,
                                    height: 1.3,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          'Periksa dan ketik kode verifikasi yang telah dikirimkan\nke ',
                                    ),
                                    TextSpan(
                                      text: '+6212371923719238',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 42),

                        // =================================
                        // EMPAT KOTAK OTP
                        // =================================
                        Row(
                          children: [
                            Expanded(child: codeBox(0)),
                            const SizedBox(width: 12),
                            Expanded(child: codeBox(1)),
                            const SizedBox(width: 12),
                            Expanded(child: codeBox(2)),
                            const SizedBox(width: 12),
                            Expanded(child: codeBox(3)),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // =================================
                        // VERIFIKASI MENGGUNAKAN EMAIL
                        // =================================
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const VerifikasiEmailPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Verifikasi menggunakan Email',
                              style: TextStyle(
                                color: blueColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // =================================
                        // TOMBOL KIRIM
                        // =================================
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: kirimVerifikasi,
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

                        const SizedBox(height: 24),

                        // =================================
                        // KIRIM ULANG KODE
                        // =================================
                        GestureDetector(
                          onTap: kirimUlangKode,
                          child: const Text(
                            'Kirim Ulang Kode',
                            style: TextStyle(
                              color: greenColor,
                              fontSize: 12,
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
          ],
        ),
      ),
    );
  }
}

// =====================================
// BACKGROUND DIAGONAL FULL ATAS
// =====================================
class HeaderVerifikasiHpClipper
    extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height * 0.44);
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
