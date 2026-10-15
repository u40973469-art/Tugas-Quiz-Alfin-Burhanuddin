import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intent/tampilpesanan.dart';

class PesananPage extends StatefulWidget {
  const PesananPage({super.key});

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController nama = TextEditingController();
  final TextEditingController noTelp = TextEditingController();
  final TextEditingController alamat = TextEditingController();

  String jenisKendaraan = "Pejalan";
  String keanggotaan = "Perunggu";
  String metodeBayar = "Tunai";

  final Map<String, int> hargaKendaraan = {
    'Pejalan': 0,
    'Motor': 5000,
    'Mobil': 10000,
    'Sepeda': 3000,
  };

  final Map<String, bool> menuTerpilih = {
    'Teh Poci': false,
    'Susu': false,
    'Gado-Gado': false,
    'Bakso': false,
  };

  final Map<String, int> hargaMenu = {
    'Teh Poci': 15000,
    'Susu': 20000,
    'Gado-Gado': 10000,
    'Bakso': 17500,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text('Input Pesanan Makanan'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
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
                controller: nama,
                decoration: InputDecoration(
                  labelText: 'Nama Pelanggan :',
                  icon: const Icon(Icons.person),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
                ),
                validator: (value) => (value == null || value.isEmpty) ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: noTelp,
                decoration: InputDecoration(
                  labelText: 'No Telp :',
                  icon: const Icon(Icons.phone),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
                ),
                validator: (value) => (value == null || value.isEmpty) ? 'No Telp tidak boleh kosong' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: alamat,
                decoration: InputDecoration(
                  labelText: 'Alamat Pengiriman :',
                  icon: const Icon(Icons.home),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
                ),
                validator: (value) => (value == null || value.isEmpty) ? 'Alamat tidak boleh kosong' : null,
              ),
              const SizedBox(height: 15),
              
              const Text("Kartu Keanggotaan :", style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                initialValue: keanggotaan,
                decoration: const InputDecoration(icon: Icon(Icons.card_membership)),
                items: const [
                  DropdownMenuItem(value: "Gold", child: Text("Gold (10%)")),
                  DropdownMenuItem(value: "Silver", child: Text("Silver (5%)")),
                  DropdownMenuItem(value: "Perunggu", child: Text("Perunggu (2.5%)")),
                  DropdownMenuItem(value: "Umum", child: Text("Umum (1%)")),
                ],
                onChanged: (newValue) {
                  setState(() => keanggotaan = newValue!);
                },
              ),
              const SizedBox(height: 15),

              const Text("Jenis Pembayaran : ", style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  RadioMenuButton<String>(
                    value: "Tunai",
                    groupValue: metodeBayar,
                    onChanged: (value) => setState(() => metodeBayar = value!),
                    child: const Text("Tunai"),
                  ),
                  RadioMenuButton<String>(
                    value: "Transfer",
                    groupValue: metodeBayar,
                    onChanged: (value) => setState(() => metodeBayar = value!),
                    child: const Text("Transfer"),
                  ),
                  RadioMenuButton<String>(
                    value: "QRIS",
                    groupValue: metodeBayar,
                    onChanged: (value) => setState(() => metodeBayar = value!),
                    child: const Text("QRIS"),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              const Text("Jenis Kendaraan : ", style: TextStyle(fontWeight: FontWeight.bold)),
              Column(
                children: [
                  RadioMenuButton<String>(
                    value: "Pejalan",
                    groupValue: jenisKendaraan,
                    onChanged: (value) => setState(() => jenisKendaraan = value!),
                    child: const Text("Pejalan Rp0)"),
                  ),
                  RadioMenuButton<String>(
                    value: "Sepeda",
                    groupValue: jenisKendaraan,
                    onChanged: (value) => setState(() => jenisKendaraan = value!),
                    child: const Text("Sepeda (Rp3rb)"),
                  ),
                  RadioMenuButton<String>(
                    value: "Motor",
                    groupValue: jenisKendaraan,
                    onChanged: (value) => setState(() => jenisKendaraan = value!),
                    child: const Text("Motor (5rb)"),
                  ),
                  RadioMenuButton<String>(
                    value: "Mobil",
                    groupValue: jenisKendaraan,
                    onChanged: (value) => setState(() => jenisKendaraan = value!),
                    child: const Text("Mobil (10rb)"),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              const Text("Pilih Menu Makanan/Minuman :", style: TextStyle(fontWeight: FontWeight.bold)),
              Column(
                children: menuTerpilih.keys.map((String key) {
                  int harga = hargaMenu[key] ?? 0;
                  return CheckboxListTile(
                    title: Text("$key (Rp $harga)"),
                    value: menuTerpilih[key],
                    activeColor: Colors.deepOrangeAccent,
                    onChanged: (bool? value) {
                      setState(() => menuTerpilih[key] = value!);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              
              ElevatedButton(
  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      List<String> listMenu = [];
      int totalHargaAwal = 0;

      menuTerpilih.forEach((key, value) {
        if (value == true) {
          listMenu.add(key);
          totalHargaAwal += hargaMenu[key] ?? 0;
        }
      });

      double diskonPersen = 0.025;
      String teksAnggota = "Perunggu (2.5%)";
      if (keanggotaan == "Gold") {
        diskonPersen = 0.10;
        teksAnggota = "Gold (10%)";
      }
      if (keanggotaan == "Silver") {
        diskonPersen = 0.05;
        teksAnggota = "Silver (5%)";
      }
      if (keanggotaan == "Umum") {
        diskonPersen = 0.01;
        teksAnggota = "Umum (1%)";
      }
      
      double ppnPersen = 0.03;
      String teksBayar = "Tunai (3%)";
      if (metodeBayar == "Transfer") {
        ppnPersen = 0.02;
        teksBayar = "Transfer (2%)";
      }
      if (metodeBayar == "QRIS") {
        ppnPersen = 0.01;
        teksBayar = "QRIS (1%)";
      }

      int biayaTransport = hargaKendaraan[jenisKendaraan] ?? 0;

      double jumlahDiskon = totalHargaAwal * diskonPersen;
      double setelahDiskon = totalHargaAwal - jumlahDiskon;
      
      double jumlahPPN = setelahDiskon * ppnPersen;
      
      int totalAkhir = ((setelahDiskon - jumlahPPN)).round();

      int randomNum = Random().nextInt(9000) + 1000;
      String noPesananRandom = "K-$randomNum";

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TampilPesanan(
            listData: [
              {
                'noPesanan': noPesananRandom,
                'nama': nama.text,
                'noTelp': noTelp.text,
                'alamat': alamat.text,
                'anggota': teksAnggota, 
                'bayar': teksBayar,    
                'kendaraan': jenisKendaraan,
                'biayaKendaraan': biayaTransport, 
                'menu': listMenu,
                'diskon': jumlahDiskon.round(),
                'ppn': jumlahPPN.round(),
                'total': totalAkhir,
              }
            ],
          ),
        ),
      );
    }
  },
  child: const Text("Kirim Data Pesanan", style: TextStyle(color: Colors.white)),
),
            ],
          ),
        ),
      ),
    );
  }
}