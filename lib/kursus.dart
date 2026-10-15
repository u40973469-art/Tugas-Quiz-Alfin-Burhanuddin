import 'package:flutter/material.dart';

class KursusPage extends StatelessWidget {
  const KursusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LamanKursus();
  }
}

class LamanKursus extends StatefulWidget {
  const LamanKursus({super.key});

  @override
  State<LamanKursus> createState() => _LamanKursusState();
}

class _LamanKursusState extends State<LamanKursus> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController noPesanan = TextEditingController();
  final TextEditingController nama = TextEditingController();
  final TextEditingController noTelp = TextEditingController();

  String statusVal = "Mahasiswa";

  Map<String, bool> daftarKursus = {
    'Bhs Inggris': false,
    'Python': false,
    'Mobile Flutter': false,
    'Web': false,
  };

  final Map<String, int> hargaKursus = {
    'Bhs Inggris': 150000,
    'Python': 175000,
    'Mobile Flutter': 200000,
    'Web': 225000,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text('Input Kursus'),
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
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              TextFormField(
                controller: noPesanan,
                decoration: InputDecoration(
                  labelText: 'No Pesanan :',
                  icon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'No Pesanan tidak boleh kosong';
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
                controller: noTelp,
                decoration: InputDecoration(
                  labelText: 'No Telp :',
                  icon: const Icon(Icons.phone),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'No Telp tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text("Status : ", style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: Row(
                      children: [
                        RadioMenuButton<String>(
                          value: "Mahasiswa",
                          groupValue: statusVal,
                          onChanged: (value) {
                            setState(() => statusVal = value!);
                          },
                          child: const Text("Mahasiswa"),
                        ),
                        RadioMenuButton<String>(
                          value: "Umum",
                          groupValue: statusVal,
                          onChanged: (value) {
                            setState(() => statusVal = value!);
                          },
                          child: const Text("Umum"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Text("Pilih Kursus :", style: TextStyle(fontWeight: FontWeight.bold)),
              Column(
                children: daftarKursus.keys.map((String key) {
                  int harga = hargaKursus[key] ?? 0;
                  return CheckboxListTile(
                    title: Text("$key (Rp $harga)"),
                    value: daftarKursus[key],
                    activeColor: Colors.deepOrangeAccent,
                    onChanged: (bool? value) {
                      setState(() {
                        daftarKursus[key] = value!;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    List<String> tmpArray = [];
                    int totalBiaya = 0;

                    daftarKursus.forEach((key, value) {
                      if (value == true) {
                        tmpArray.add(key);
                        totalBiaya += hargaKursus[key] ?? 0;
                      }
                    });

                    Navigator.pop(context, {
                      'noPesanan': noPesanan.text,
                      'nama': nama.text,
                      'noTelp': noTelp.text,
                      'status': statusVal,
                      'kursus': tmpArray,
                      'total': totalBiaya,
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
