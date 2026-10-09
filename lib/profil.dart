import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  static const Color greenColor = Color(0xFF1A6556);
  static const Color topColor = Color(0xFF35776A);

  // Kosongkan dulu karena foto akan dimasukkan nanti.
  static const String fotoProfil = 'lib/images/foto.jpeg';

  void tampilPesan(BuildContext context, String halaman) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Halaman $halaman belum dibuat'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void keluarAkun(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Keluar Akun'),
          content: const Text(
            'Apakah kamu yakin ingin keluar dari akun?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false,
                );
              },
              child: const Text(
                'Keluar',
                style: TextStyle(color: greenColor),
              ),
            ),
          ],
        );
      },
    );
  }

  // =====================================
  // FOTO PROFIL
  // =====================================
  Widget fotoPengguna() {
    return Container(
      width: 132,
      height: 132,
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Container(
          color: const Color(0xFFE6EFEC),
          child: fotoProfil.isEmpty
              ? const Icon(
                  Icons.person,
                  color: greenColor,
                  size: 85,
                )
              : Image.asset(
                  fotoProfil,
                  width: 124,
                  height: 124,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  // =====================================
  // MENU PROFIL
  // =====================================
  Widget menuProfil({
    required String judul,
    IconData? ikon,
    required VoidCallback onTap,
    bool garis = true,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 55,
            child: Row(
              children: [
                SizedBox(
                  width: 46,
                  child: ikon == null
                      ? const SizedBox.shrink()
                      : Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            ikon,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                ),

                Expanded(
                  child: Text(
                    judul,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 28,
                ),
              ],
            ),
          ),
        ),

        if (garis)
          const Divider(
            color: Color(0xFFC7C7C7),
            thickness: 1,
            height: 1,
          ),
      ],
    );
  }

  // =====================================
  // ICON NAVIGASI BAWAH
  // =====================================
  Widget itemNavigasi({
    required IconData ikon,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 60,
          child: Center(
            child: Icon(
              ikon,
              size: 27,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget navigasiBawah(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Container(
          height: 60,
          color: greenColor,
          child: Row(
            children: [
              // BERANDA
              itemNavigasi(
                ikon: Icons.home_outlined,
                onTap: () {
                  tampilPesan(context, 'Beranda');
                },
              ),

              // KEAMANAN
              itemNavigasi(
                ikon: Icons.verified_user,
                onTap: () {
                  tampilPesan(context, 'Keamanan');
                },
              ),

              // FAVORIT / PESAN
              itemNavigasi(
                ikon: Icons.mark_unread_chat_alt_rounded,
                onTap: () {
                  tampilPesan(context, 'Pesan');
                },
              ),

              // AKUN (SEDANG AKTIF)
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: -36,
                      child: Column(
                        children: [
                          Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: greenColor,
                                width: 9,
                              ),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: greenColor,
                              size: 30,
                            ),
                          ),

                          const SizedBox(height: 4),

                          const Text(
                            'AKUN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================
  // TAMPILAN HALAMAN PROFIL
  // =====================================
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: topColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,

        // NAVIGASI BAWAH
        bottomNavigationBar: navigasiBawah(context),

        // ISI HALAMAN
        body: SingleChildScrollView(
          child: Column(
            children: [
              // =================================
              // HEADER ATAS
              // =================================
              Container(
                width: double.infinity,
                color: topColor,
                child: SafeArea(
                  bottom: false,
                  child: const SizedBox(height: 42),
                ),
              ),

              // =================================
              // BACKGROUND HIJAU DAN FOTO PROFIL
              // =================================
              SizedBox(
                height: 154,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 86,
                      color: greenColor,
                    ),

                    Positioned(
                      top: 18,
                      child: fotoPengguna(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // =================================
              // NAMA PENGGUNA
              // =================================
              const Text(
                'ADELIA RIZKA PUTRI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 7),

              // =================================
              // EMAIL PENGGUNA
              // =================================
              Container(
                width: 191,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'adelp0585@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // =================================
              // DAFTAR MENU
              // =================================
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    // PENGATURAN
                    menuProfil(
                      judul: 'Pengaturan',
                      ikon: Icons.settings_outlined,
                      onTap: () {
                        tampilPesan(context, 'Pengaturan');
                      },
                    ),

                    // EDIT PROFIL
                    menuProfil(
                      judul: 'Edit Profil',
                      ikon: Icons.edit_outlined,
                      onTap: () {
                        tampilPesan(context, 'Edit Profil');
                      },
                    ),

                    // KEBIJAKAN PRIVASI
                    menuProfil(
                      judul: 'Kebijakan Privasi',
                      ikon: Icons.lock_outline,
                      onTap: () {
                        tampilPesan(context, 'Kebijakan Privasi');
                      },
                    ),

                    // TENTANG KAMI
                    menuProfil(
                      judul: 'Tentang Kami',
                      ikon: Icons.info_outline,
                      onTap: () {
                        tampilPesan(context, 'Tentang Kami');
                      },
                    ),

                    // KETENTUAN LAYANAN
                    menuProfil(
                      judul: 'Ketentuan Layanan',
                      ikon: Icons.description_outlined,
                      onTap: () {
                        tampilPesan(context, 'Ketentuan Layanan');
                      },
                    ),

                    // KELUAR
                    menuProfil(
                      judul: 'Keluar',
                      ikon: Icons.logout,
                      garis: false,
                      onTap: () {
                        keluarAkun(context);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}