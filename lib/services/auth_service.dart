
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Firebase Authentication
  final _auth = FirebaseAuth.instance;

  // Google Sign-In
  static bool _googleReady = false;

  // Memantau status login pengguna
  Stream<User?> get authState => _auth.authStateChanges();

  // REGISTER dengan Email dan Password
  Future<void> register(String email, String password) =>
      _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  // LOGIN dengan Email dan Password
  Future<void> login(String email, String password) =>
      _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  // LOGIN menggunakan Google
  Future<void> signInWithGoogle() async {
    final google = GoogleSignIn.instance;

    // Inisialisasi Google Sign-In satu kali
    if (!_googleReady) {
      await google.initialize(
        serverClientId: 'WEB_CLIENT_ID',
      );

      _googleReady = true;
    }

    // Memilih akun Google
    final account = await google.authenticate();

    // Mengambil ID Token
    final idToken = account.authentication.idToken;

    // Membuat Firebase Credential
    final credential = GoogleAuthProvider.credential(
      idToken: idToken,
    );

    // Login ke Firebase menggunakan akun Google
    await _auth.signInWithCredential(credential);
  }

  // LOGOUT
  Future<void> logout() => _auth.signOut();
}
