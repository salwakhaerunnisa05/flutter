import 'package:flutter/material.dart';
import 'package:flutter_salwa_rpl1/helpers/size_helper.dart';
import 'package:flutter_salwa_rpl1/latihanFormulir/output_page.dart';
import 'package:intl/intl.dart';

class LatihanBelajarForm extends StatefulWidget {
  const LatihanBelajarForm({super.key});

  @override
  State<LatihanBelajarForm> createState() => _BelajarFormState();
}

class _BelajarFormState extends State<LatihanBelajarForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController namaController = TextEditingController();
  TextEditingController tglPendaftaranController = TextEditingController();
  TextEditingController noTelponController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController eskulController = TextEditingController();


  String no_telp = "";
  String email = "";
  String _pilihKelas = "";
  List<String> eskul = [] ;
  String? _eskul;

  final List<String> kelas = [
    "XII RPL 1",
    "XII RPL 2",
    "XII RPL 3",
    "XII TKR 1",
    "XII TKR 2",
    "XII TSM 1",
  ];
  final List<String> daftarEskul = [
    "Futsal",
    "Voly",
    "Badminton",
    "Seni Tari",
    "Seni Krawitan",
    "Basket",
    "Paskibra"
  ];

  @override
  void initState() {
    super.initState();
    tglPendaftaranController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: Color.fromRGBO(221, 189, 213, 1.0),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Color.fromRGBO(89, 101, 111, 1.0)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Formulir Biodata",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 18),

                      TextFormField(
                        controller: namaController,
                        decoration: InputDecoration(
                          hintText: "Nama Lengkap",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return 'Input Nama';
                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: noTelponController,
                        decoration: InputDecoration(
                          hintText: "No Telpon",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return 'Input No Telpon';
                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || ! value.contains("@")) return 'Input Email';
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),

                      //eskul
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ekskul",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      ...daftarEskul.map((item) {
                        return CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(item),
                          value: eskul.contains(item),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) {
                            setState(() {
                              if (value == true && eskul.length < 2) {
                                eskul.add(item);
                              } else {
                                eskul.remove(item);
                              }
                            });
                          },
                        );
                      }),

                      if (eskul.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "Pilih minimal 1 ekstrakurikuler",
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),

                      const SizedBox(height: 18),

                      TextFormField(
                        controller: tglPendaftaranController,
                        decoration: InputDecoration(
                          hintText: "Tanggal Pendaftaran",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Input Tanggal Lahir';
                          }
                          return null;
                        },
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            setState(() {
                              tglPendaftaranController.text = DateFormat(
                                'yyyy-MM-dd'
                                ).format(pickedDate);
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 18),

                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Pilih Kelas",
                          border: OutlineInputBorder(),
                        ),
                        items: kelas
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _pilihKelas = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pilih kelas';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      SizedBox(
                        width: displayWidth(context) * 0.8,
                        height: displayHeight(context) * 0.075,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(247, 177, 176, 1.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                              side: BorderSide(color: Color.fromRGBO(89, 101, 111, 1.0)),
                            ),
                          ),
                          child: Text(
                            "Simpan",
                            style: TextStyle(color: Color.fromRGBO(89, 101, 111, 1.0)),
                          ),
                          onPressed: _submit,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();

    if ( eskul.isEmpty) {
      setState(() => _eskul = 'Pilih Jenis Kelamin');
    }

    if (!isValid || eskul.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LatihanOutputFormScreen(
          nama: namaController.text,
          noTelpon: noTelponController.text,
          email: emailController.text,
          eskul: eskul.join(', '),
          kelas: _pilihKelas,
          tglPendaftaran:  tglPendaftaranController.text,
        ),
      ),
    );
  }
}