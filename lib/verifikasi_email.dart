
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';

class VerifikasiEmailPage extends StatefulWidget {
  const VerifikasiEmailPage({super.key});

  @override
  State<VerifikasiEmailPage> createState() =>
      _VerifikasiEmailPageState();
}

class _VerifikasiEmailPageState
    extends State<VerifikasiEmailPage> {
  static const Color greenColor = Color(0xFF1A6556);
  static const Color topColor = Color(0xFFDCEAE7);
  static const Color blueColor = Color(0xFF00BDEB);

  final List<TextEditingController> otpControllers =
      List.generate(4, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
      List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in otpControllers) {
      controller.dispose();
    }

    for (final node in focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  // =====================================
  // INPUT KODE OTP
  // =====================================
  Widget otpBox(int index) {
    return SizedBox(
      height: 76,
      child: TextField(
        controller: otpControllers[index],
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
  // FUNGSI KIRIM
  // =====================================
  void kirimVerifikasi() {
    String kode = '';

    for (final controller in otpControllers) {
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
  // FUNGSI KIRIM ULANG
  // =====================================
  void kirimUlangKode() {
    for (final controller in otpControllers) {
      controller.clear();
    }

    focusNodes[0].requestFocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Simulasi kirim ulang kode ke Email',
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

    final double headerHeight =
        statusBarHeight + 210;

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

        body: Stack(
          children: [
            // =====================================
            // BACKGROUND PUTIH FULL LAYAR
            // =====================================
            const Positioned.fill(
              child: ColoredBox(
                color: Colors.white,
              ),
            ),

            // =====================================
            // BACKGROUND HIJAU MUDA DI ATAS
            // =====================================
            Positioned(
              top: 0,
              left: 0,
              right: 0,

              child: ClipPath(
                clipper: HeaderEmailClipper(),

                child: Container(
                  height: headerHeight,
                  width: double.infinity,
                  color: topColor,
                ),
              ),
            ),

            // =====================================
            // HEADER TETAP + FORM SCROLL
            // =====================================
            Column(
              children: [
                // =====================================
                // LOGO ECOWALK
                // =====================================
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
                Expanded(
                  child: SafeArea(
                    top: false,

                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior
                              .onDrag,

                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),

                        child: Column(
                          children: [
                            const SizedBox(height: 5),

                            // =========================
                            // JUDUL VERIFIKASI
                            // =========================
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
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            // =========================
                            // INFORMASI EMAIL
                            // =========================
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
                                          text:
                                              'contohsampel@gmail.com',
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 42),

                            // =========================
                            // EMPAT KOTAK OTP
                            // =========================
                            Row(
                              children: [
                                Expanded(
                                  child: otpBox(0),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: otpBox(1),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: otpBox(2),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: otpBox(3),
                                ),
                              ],
                            ),

                            const SizedBox(height: 32),

                            // =========================
                            // VERIFIKASI NO HP
                            // =========================
                            Align(
                              alignment: Alignment.centerLeft,

                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },

                                child: const Text(
                                  'Verifikasi menggunakan No. Hp',
                                  style: TextStyle(
                                    color: blueColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),

                            // =========================
                            // TOMBOL KIRIM
                            // =========================
                            SizedBox(
                              width: double.infinity,
                              height: 45,

                              child: ElevatedButton(
                                onPressed: kirimVerifikasi,

                                style: ElevatedButton
                                    .styleFrom(
                                  backgroundColor:
                                      greenColor,
                                  foregroundColor:
                                      Colors.white,
                                  elevation: 0,

                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(
                                      5,
                                    ),
                                  ),
                                ),

                                child: const Text(
                                  'KIRIM',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // =========================
                            // KIRIM ULANG KODE
                            // =========================
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
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================
// CLIPPER BACKGROUND DIAGONAL
// =====================================
class HeaderEmailClipper extends CustomClipper<Path> {
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
