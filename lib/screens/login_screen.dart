import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

// Layar form login dengan autentikasi token DRF
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  String _password = '';
  bool _isSubmitting = false;

  // Fungsi pengiriman form login ke server
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      await context.read<AuthState>().login(_username, _password);
      if (!mounted) return;

      // Jika berhasil login, kembali ke layar pemanggil dengan nilai true
      Navigator.pop(context, true);
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Login gagal (${e.statusCode}): Kredensial tidak valid!',
            style: GoogleFonts.jost(),
          ),
          backgroundColor: Colors.red[700],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e', style: GoogleFonts.jost()),
          backgroundColor: Colors.red[700],
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: GoogleFonts.cormorantGaramond(
            color: const Color(0xFFF1DFD3),
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xFF392529),
        iconTheme: const IconThemeData(color: Color(0xFFF1DFD3)),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Masuk ke Akun Anda',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF392529),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Gunakan akun Django untuk menambah atau mengelola proyek.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.jost(
                    fontSize: 13,
                    color: const Color(0xFF855B60),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Input username
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Username',
                  labelText: 'Username',
                  labelStyle: GoogleFonts.jost(color: const Color(0xFF392529)),
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Color(0xFF392529),
                  ),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF392529),
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) => _username = value.trim(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Username cannot be empty!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Input password
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  labelStyle: GoogleFonts.jost(color: const Color(0xFF392529)),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Color(0xFF392529),
                  ),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF392529),
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) => _password = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be empty!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Tombol submit login
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF392529),
                  foregroundColor: const Color(0xFFF1DFD3),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                ),
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFFF1DFD3),
                        ),
                      )
                    : Text(
                        'Login',
                        style: GoogleFonts.jost(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
