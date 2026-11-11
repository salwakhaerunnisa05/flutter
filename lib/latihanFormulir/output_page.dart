import 'package:flutter/material.dart';

class LatihanOutputFormScreen extends StatelessWidget {
  final String nama, noTelpon, email, kelas, eskul, tglPendaftaran ;

  LatihanOutputFormScreen({
    Key? key,
    required this.nama,
    required this.noTelpon,
    required this.email,
    required this.kelas,
    required this.eskul,
    required this.tglPendaftaran,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.black),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textWidget("Nama", nama),
                _textWidget("No Telpon", noTelpon),
                _textWidget("Email", email),
                _textWidget("Kelas", kelas),
                _textWidget("eskul", eskul),
                _textWidget("Tanggal Lahir", tglPendaftaran),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textWidget(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(": $value")),
        ],
      ),
    );
  }
}