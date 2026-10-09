
import 'package:flutter/material.dart';
import 'daftar.dart';
import 'lupa_sandi.dart';
import 'profil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const Color greenColor = Color(0xFF1A6556);
  static const Color blueColor = Color(0xFF00BDEB);

  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // =====================================
  // FUNGSI LOGIN
  // =====================================
  void prosesLogin() {
    String username = usernameController.text.trim();
    String password = passwordController.text;

    // Memeriksa apakah kolom kosong
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Nama pengguna dan kata sandi wajib diisi!',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Username dan password untuk simulasi login
    if (username == 'user1122' && password == '123456') {
      // Jika benar, pindah ke halaman Profil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfilPage(),
        ),
      );
    } else {
      // Jika username atau password salah
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Nama pengguna atau kata sandi salah!',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // =====================================
  // TAMPILAN HALAMAN LOGIN
  // =====================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const SizedBox(height: 60),

                // =====================================
                // JUDUL MASUK
                // =====================================
                const Text(
                  'MASUK',
                  style: TextStyle(
                    color: greenColor,
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 14),

                // =====================================
                // LOGO ECOWALK
                // =====================================
                Image.asset(
                  'lib/images/logo2.png',
                  width: 235,
                  height: 47,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 66),

                // =====================================
                // NAMA PENGGUNA
                // =====================================
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nama Pengguna',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 7),

                SizedBox(
                  height: 48,
                  child: TextField(
                    controller: usernameController,
                    textInputAction: TextInputAction.next,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF8F8F8),

                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 20,
                      ),

                      contentPadding:
                          const EdgeInsets.symmetric(
                        vertical: 14,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFFC2C2C2),
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
                ),

                const SizedBox(height: 20),

                // =====================================
                // KATA SANDI
                // =====================================
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Kata Sandi',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 7),

                SizedBox(
                  height: 48,
                  child: TextField(
                    controller: passwordController,
                    obscureText: hidePassword,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => prosesLogin(),

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF8F8F8),

                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.grey,
                        size: 20,
                      ),

                      // Tombol mata
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
                          size: 20,
                        ),
                      ),

                      contentPadding:
                          const EdgeInsets.symmetric(
                        vertical: 14,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFFC2C2C2),
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
                ),

                const SizedBox(height: 55),

                // =====================================
                // TOMBOL MASUK
                // =====================================
                SizedBox(
                  width: double.infinity,
                  height: 45,

                  child: ElevatedButton(
                    onPressed: prosesLogin,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),

                    child: const Text(
                      'MASUK',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // =====================================
                // LUPA KATA SANDI
                // =====================================
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const LupaSandiPage(),
                      ),
                    );
                  },

                  child: const Text(
                    'Lupa Kata Sandi?',
                    style: TextStyle(
                      color: blueColor,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // =====================================
                // GARIS ATAU
                // =====================================
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color(0xFFE7E7E7),
                        thickness: 1,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                      ),

                      child: Text(
                        'Atau',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 10,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Divider(
                        color: Color(0xFFE7E7E7),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // =====================================
                // TOMBOL GOOGLE
                // =====================================
                SizedBox(
                  width: double.infinity,
                  height: 48,

                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Login Google belum tersedia',
                          ),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 3,
                      shadowColor: Colors.black38,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'lib/images/google.png',
                          width: 22,
                          height: 22,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(width: 14),

                        const Text(
                          'Lanjutkan dengan Google',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 42),

                // =====================================
                // BELUM PUNYA AKUN? DAFTAR
                // =====================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Tidak punya akun? ',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const DaftarPage(),
                          ),
                        );
                      },

                      child: const Text(
                        'Daftar disini',
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
    );
  }
}
