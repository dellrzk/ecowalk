
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ubah_sandi.dart';

class VerifikasiLupaSandiPage extends StatefulWidget {
  final bool viaEmail;
  final String tujuan;

  const VerifikasiLupaSandiPage({
    super.key,
    required this.viaEmail,
    required this.tujuan,
  });

  @override
  State<VerifikasiLupaSandiPage> createState() =>
      _VerifikasiLupaSandiPageState();
}

class _VerifikasiLupaSandiPageState
    extends State<VerifikasiLupaSandiPage> {

  static const Color greenColor = Color(0xFF1A6556);
  static const Color topColor = Color(0xFFDCEAE7);
  static const Color blueColor = Color(0xFF00BDEB);

  final List<TextEditingController> otpControllers =
      List.generate(4, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
      List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();

    // Mengizinkan background tampil di belakang status bar.
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
  }

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

  // ==================================
  // KOTAK OTP
  // ==================================
  Widget otpBox(int index) {
    return SizedBox(
      height: 70,
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

  // ==================================
  // KIRIM KODE
  // ==================================
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

    // Simulasi OTP: pindah ke halaman ubah sandi.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UbahSandiPage(),
      ),
    );
  }

  // ==================================
  // KIRIM ULANG KODE
  // ==================================
  void kirimUlangKode() {
    for (final controller in otpControllers) {
      controller.clear();
    }

    focusNodes[0].requestFocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.viaEmail
              ? 'Simulasi kirim ulang kode ke Email'
              : 'Simulasi kirim ulang kode ke Nomor HP',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // Tinggi status bar Android.
    final double statusBarHeight =
        MediaQuery.of(context).padding.top;

    final double headerHeight = statusBarHeight + 235;

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

        // PENTING:
        // Tidak menggunakan SafeArea di bagian atas.
        body: SingleChildScrollView(
          child: Column(
            children: [

              // ==================================
              // HEADER FULL SAMPAI STATUS BAR
              // ==================================
              SizedBox(
                height: headerHeight,
                width: double.infinity,

                child: Stack(
                  children: [

                    // BACKGROUND HIJAU MUDA DIAGONAL
                    ClipPath(
                      clipper: HeaderVerifikasiClipper(),
                      child: Container(
                        width: double.infinity,
                        height: headerHeight,
                        color: topColor,
                      ),
                    ),

                    // LOGO ECOWALK
                    Positioned(
                      top: statusBarHeight + 105,
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

              // ==================================
              // ISI HALAMAN
              // ==================================
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),

                child: Column(
                  children: [

                    const SizedBox(height: 5),

                    // JUDUL
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
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // KETERANGAN VERIFIKASI
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
                            text: TextSpan(
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 13,
                                height: 1.3,
                              ),

                              children: [
                                const TextSpan(
                                  text:
                                      'Periksa dan ketik kode verifikasi yang telah dikirimkan\nke ',
                                ),

                                TextSpan(
                                  text: widget.tujuan,
                                  style: const TextStyle(
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

                    // ==================================
                    // EMPAT KOTAK OTP
                    // ==================================
                    Row(
                      children: [
                        Expanded(child: otpBox(0)),
                        const SizedBox(width: 12),
                        Expanded(child: otpBox(1)),
                        const SizedBox(width: 12),
                        Expanded(child: otpBox(2)),
                        const SizedBox(width: 12),
                        Expanded(child: otpBox(3)),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // JENIS VERIFIKASI
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.viaEmail
                            ? 'Verifikasi menggunakan Email'
                            : 'Verifikasi menggunakan No. Hp',

                        style: const TextStyle(
                          color: blueColor,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ==================================
                    // TOMBOL KIRIM
                    // ==================================
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

                    // KIRIM ULANG
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
      ),
    );
  }
}

// ==========================================
// BACKGROUND DIAGONAL FULL SCREEN ATAS
// ==========================================
class HeaderVerifikasiClipper
    extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    final Path path = Path();

    // Mulai dari pojok kiri atas layar.
    path.moveTo(0, 0);

    // Ke pojok kanan atas.
    path.lineTo(size.width, 0);

    // Turun ke kanan bawah header.
    path.lineTo(size.width, size.height);

    // Garis miring menuju kiri.
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
