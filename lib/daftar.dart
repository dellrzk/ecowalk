
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'verifikasi.dart';

class DaftarPage extends StatefulWidget {
  const DaftarPage({super.key});

  @override
  State<DaftarPage> createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  static const Color greenColor = Color(0xFF1A6556);
  static const Color blueColor = Color(0xFF00BDEB);
  static const Color borderColor = Color(0xFFC2C2C2);
  static const Color inputColor = Color(0xFFF8F8F8);

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool agree = false;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // =====================================
  // DESAIN FORM INPUT
  // =====================================
  Widget inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,

        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),

        decoration: InputDecoration(
          hintText: hint,

          hintStyle: const TextStyle(
            color: Color(0xFF858585),
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),

          prefixIcon: Icon(
            icon,
            color: const Color(0xFF808080),
            size: 21,
          ),

          suffixIcon: suffixIcon,

          filled: true,
          fillColor: inputColor,
          isDense: true,

          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 12,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: borderColor,
              width: 1,
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
      ),
    );
  }

  // =====================================
  // FUNGSI BUAT AKUN
  // =====================================
  void buatAkun() {
    if (usernameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua kolom harus diisi'),
        ),
      );
      return;
    }

    if (!emailController.text.trim().contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan alamat email yang valid'),
        ),
      );
      return;
    }

    if (passwordController.text !=
        confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Konfirmasi kata sandi tidak sama',
          ),
        ),
      );
      return;
    }

    if (!agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Setujui persyaratan dan privasi pengguna',
          ),
        ),
      );
      return;
    }

    // Simulasi menuju halaman Verifikasi No. HP
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const VerifikasiPage(),
      ),
    );
  }

  // =====================================
  // HALAMAN BUAT AKUN
  // =====================================
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),

      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,

        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,

            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: Column(
                children: [
                  const SizedBox(height: 52),

                  // =====================================
                  // JUDUL DAN LOGO ECOWALK
                  // RATA KIRI DALAM KELOMPOK TENGAH
                  // =====================================
                  Center(
                    child: SizedBox(
                      width: 235,
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          const Text(
                            'BUAT AKUN',
                            style: TextStyle(
                              color: greenColor,
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Image.asset(
                            'lib/images/logo2.png',
                            width: 235,
                            height: 47,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 54),

                  // =====================================
                  // NAMA PENGGUNA
                  // =====================================
                  inputField(
                    controller: usernameController,
                    hint: 'Nama Pengguna',
                    icon: Icons.person,
                  ),

                  const SizedBox(height: 22),

                  // =====================================
                  // EMAIL
                  // =====================================
                  inputField(
                    controller: emailController,
                    hint: 'Email',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 22),

                  // =====================================
                  // NOMOR HP
                  // =====================================
                  inputField(
                    controller: phoneController,
                    hint: 'Nomor Hp',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 22),

                  // =====================================
                  // KATA SANDI
                  // =====================================
                  inputField(
                    controller: passwordController,
                    hint: 'Kata Sandi',
                    icon: Icons.lock,
                    obscureText: hidePassword,

                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },

                      icon: Icon(
                        hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                        size: 21,
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // =====================================
                  // KONFIRMASI KATA SANDI
                  // =====================================
                  inputField(
                    controller: confirmPasswordController,
                    hint: 'Konfirmasi Kata Sandi',
                    icon: Icons.lock,
                    obscureText: hideConfirmPassword,

                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hideConfirmPassword =
                              !hideConfirmPassword;
                        });
                      },

                      icon: Icon(
                        hideConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                        size: 21,
                      ),
                    ),
                  ),

                  const SizedBox(height: 31),

                  // =====================================
                  // CHECKBOX PERSYARATAN
                  // =====================================
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      SizedBox(
                        width: 28,
                        height: 28,

                        child: Transform.scale(
                          scale: 0.85,

                          child: Checkbox(
                            value: agree,
                            activeColor: greenColor,
                            checkColor: Colors.white,

                            materialTapTargetSize:
                                MaterialTapTargetSize
                                    .shrinkWrap,

                            side: const BorderSide(
                              color: Colors.black54,
                              width: 1.5,
                            ),

                            onChanged: (value) {
                              setState(() {
                                agree = value ?? false;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text.rich(
                          const TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'Saya telah membaca dan menyetujui ',

                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),

                              TextSpan(
                                text:
                                    'persyaratan dan\nprivasi pengguna',

                                style: TextStyle(
                                  color: blueColor,
                                ),
                              ),
                            ],
                          ),

                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // =====================================
                  // TOMBOL BUAT AKUN
                  // =====================================
                  SizedBox(
                    width: double.infinity,
                    height: 45,

                    child: ElevatedButton(
                      onPressed: buatAkun,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5),
                        ),
                      ),

                      child: const Center(
                        child: Text(
                          'BUAT AKUN',
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // =====================================
                  // SUDAH PUNYA AKUN?
                  // =====================================
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [
                      const Text(
                        'Sudah punya akun? ',
                        style: TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 12,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const LoginPage(),
                            ),
                          );
                        },

                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            color: blueColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
