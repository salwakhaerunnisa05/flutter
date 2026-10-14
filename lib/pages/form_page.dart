import 'package:flutter/material.dart';



class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  //kunci global key
  final _formKey = GlobalKey<FormState>();

  //variable textbox
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _jenisKelaminController = TextEditingController();
  var _outputName = '';
  var _outputTanggalLahir = '';
  var _outputJenisKelamin = '';

  @override
  void dispose() {
    //menghapus inputan yang sudah di isi 
    _nameController.dispose();
    _tanggalLahirController.dispose();
    _jenisKelaminController.dispose();
    //mengeksekusi method dispose
    super.dispose();
  }

  void _submitForm() {
    setState(() {
      _outputName = _nameController.text;
      _outputTanggalLahir = _tanggalLahirController.text;
    });

    print(
      "Nama Lengkap : ${_nameController.text}"
      "Tanggal Lahir : ${_tanggalLahirController.text}"
      "Jenis Kelamin : ${_jenisKelaminController.text}"
      );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(
        "Nama Lengkap : ${_nameController.text} | Tanggal Lahir : ${_tanggalLahirController} | Jenis Kelamin : ${_jenisKelaminController} ")),
      );
      //mengambil ,ethod clear
      //_clearInput();
  }

  void _clearInput() {
    //membersihkan isi text box
    _nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('my form app')),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'isi name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Nama Tidak Boleh Kosong";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                  padding: EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _tanggalLahirController,
                      decoration: InputDecoration(
                        labelText: 'Isi Tanggal Lahir',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Nama Tidak Boleh Kosong";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                  padding: EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _jenisKelaminController,
                      decoration: InputDecoration(
                        labelText: 'isi Jenis Kelamin',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Nama Tidak Boleh Kosong";
                        }
                        return null;
                      },
                    ),
                  ),
                  
                  SizedBox(height: 20,),
                  OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitForm();
                      }
                     _submitForm();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.brown, width: 1),
                    ),
                    child: Text("Simpan"),
                  ),
                  Text('Nama: ${_outputName.isEmpty ? "-" : _outputName}',
                  style: const TextStyle(fontSize: 16),
                  ),
                  Text('Tanggal Lahir: ${_outputTanggalLahir.isEmpty ? "-" : _outputTanggalLahir}',
                  style: const TextStyle(fontSize: 16),
                  ),
              ],
            )
          ),
        ),
      );
  }
}