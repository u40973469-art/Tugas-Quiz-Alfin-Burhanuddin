import 'package:flutter/material.dart';

class BiodataPage extends StatefulWidget {
  const BiodataPage({super.key});

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController nim = TextEditingController();
  TextEditingController alamat = TextEditingController();
  
  String _radioval = "Laki-Laki";
  
  var items = ["Islam", "Kristen", "Hindu", "Budha"];
  String setSelecteditem = "Islam";
  
  Map<String, bool> hoby = {
    'Menggambar': false,
    'Coding': false,
    'Membaca': false,
  };
  
  List<String> tmpArray = [];

  void getCheckboxItems() {
    tmpArray.clear();
    hoby.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text('Input Biodata'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close_sharp),
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: nim,
                decoration: InputDecoration(
                  labelText: 'NIM :',
                  icon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'NIM tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nama,
                decoration: InputDecoration(
                  labelText: 'Nama :',
                  icon: const Icon(Icons.person),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Nama tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: alamat,
                decoration: InputDecoration(
                  labelText: 'Alamat :',
                  icon: const Icon(Icons.home),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Alamat tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("Jenis Kelamin : ", style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: Row(
                      children: [
                        RadioMenuButton<String>(
                          value: "Laki-Laki",
                          groupValue: _radioval,
                          onChanged: (value) {
                            setState(() => _radioval = value!);
                          },
                          child: const Text("Laki-Laki"),
                        ),
                        RadioMenuButton<String>(
                          value: "Perempuan",
                          groupValue: _radioval,
                          onChanged: (value) {
                            setState(() => _radioval = value!);
                          },
                          child: const Text("Perempuan"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Agama : '),
                  const SizedBox(width: 15),
                  DropdownButton<String>(
                    value: setSelecteditem,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        setSelecteditem = newValue!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text("Pilih Hobi :", style: TextStyle(fontWeight: FontWeight.bold)),
              Column(
                children: hoby.keys.map((String key) {
                  return CheckboxListTile(
                    title: Text(key),
                    value: hoby[key],
                    activeColor: Colors.deepOrangeAccent,
                    onChanged: (bool? value) {
                      setState(() {
                        hoby[key] = value!;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    getCheckboxItems();
                    Navigator.pop(context, {
                      'name': nama.text,
                      'nim': nim.text,
                      'jk': _radioval,
                      'status': setSelecteditem,
                      'hobi': List.from(tmpArray),
                    });
                  }
                },
                child: const Text("Kirim Data", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
