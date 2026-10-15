import 'dart:io';
import 'package:intent/biodata.dart';
import 'package:intent/tampilbiodata.dart';
import 'package:intent/kursus.dart';
import 'package:intent/tampilkursus.dart';
import 'package:intent/pesanan.dart';
import 'package:intent/tampilpesanan.dart';
import 'package:flutter/material.dart';

class HalamanHome extends StatefulWidget {
  const HalamanHome({super.key});

  @override
  State<HalamanHome> createState() => _HalamanHomeState();
}

class _HalamanHomeState extends State<HalamanHome> {
  List<Map<String, dynamic>> listBiodata = [];
  List<Map<String, dynamic>> listKursus = [];
  List<Map<String, dynamic>> listPesanan = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text('Menu Drawer'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.assignment, size: 150, color: Colors.deepOrangeAccent),
              SizedBox(height: 20),
              Text(
                "Selamat Datang Di Aplikasi",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text("Terima Kasih", style: TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepOrange),
              child: Center(
                child: Icon(Icons.account_circle, size: 90, color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text('Input Biodata'),
              leading: const Icon(Icons.person_add),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BiodataPage()),
                );
                if (result != null && result is Map<String, dynamic>) {
                  setState(() {
                    listBiodata.add(result);
                  });
                }
              },
            ),
            ListTile(
              title: const Text('Input Kursus'),
              leading: const Icon(Icons.book),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const KursusPage()),
                );
                if (result != null && result is Map<String, dynamic>) {
                  setState(() {
                    listKursus.add(result);
                  });
                }
              },
            ),
            ListTile(
              title: const Text('Input Pesanan'),
              leading: const Icon(Icons.add_shopping_cart),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PesananPage()),
                );
                if (result != null && result is Map<String, dynamic>) {
                  setState(() {
                    listPesanan.add(result);
                  });
                }
              },
            ),
            ListTile(
              title: const Text('Tampil Biodata'),
              leading: const Icon(Icons.portrait),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TampilBiodata(listData: listBiodata),
                  ),
                ).then((_) => setState(() {}));
              },
            ),
            ListTile(
              title: const Text('Tampil Kursus'),
              leading: const Icon(Icons.assignment_turned_in),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TampilKursus(listData: listKursus),
                  ),
                ).then((_) => setState(() {}));
              },
            ),
            ListTile(
              title: const Text('Tampil Pesanan'),
              leading: const Icon(Icons.shopping_bag_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TampilPesanan(listData: listPesanan),
                  ),
                ).then((_) => setState(() {}));
              },
            ),
            ListTile(
              title: const Text('Keluar'),
              leading: const Icon(Icons.close),
              onTap: () => exit(0),
            ),
          ],
        ),
      ),
    );
  }
}
