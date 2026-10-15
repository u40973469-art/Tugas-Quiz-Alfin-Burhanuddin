import 'package:flutter/material.dart';
import 'package:intent/menu.dart';

class TampilPesanan extends StatefulWidget {
  final List<Map<String, dynamic>> listData;

  const TampilPesanan({super.key, required this.listData});

  @override
  State<TampilPesanan> createState() => _TampilPesananState();
}

class _TampilPesananState extends State<TampilPesanan> {
  @override
  Widget build(BuildContext context) {
    final bool isEmpty = widget.listData.isEmpty;
    
    final Map<String, dynamic> data = isEmpty ? {} : widget.listData.last;
    
    final List<dynamic> menuRaw = data['menu'] ?? [];
    final List<String> menu = menuRaw.map((item) => item.toString()).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text("Tampil Data"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HalamanHome()),
            );
          },
        ),
      ),
      body: isEmpty
          ? const Center(
              child: Text(
                "Belum ada data pesanan makanan.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Card(
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            "NOTA PESANAN MASUK",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepOrange),
                          ),
                        ),
                        const Divider(thickness: 2, height: 30),
                        _buildItemRow("No Pesanan", data['noPesanan'] ?? "-"),
                        _buildItemRow("Nama", data['nama'] ?? "-"),
                        _buildItemRow("No HP", data['noTelp'] ?? "-"),
                        _buildItemRow("Kartu Anggota", data['anggota'] ?? "-"),
                        _buildItemRow("Jenis Pembayaran", data['bayar'] ?? "-"),
                        _buildItemRow("Jenis Kendaraan", data['kendaraan'] ?? "-"),
                        _buildItemRow("Pesanan", menu.isEmpty ? "-" : menu.join(", ")),
                        _buildItemRow("Diskon", "Rp ${data['diskon'] ?? 0}"),
                        _buildItemRow("PPN", "Rp ${data['ppn'] ?? 0}"),
                        _buildItemRow("Biaya Kendaraan", "Rp ${data['biayaKendaraan'] ?? 0}"),
                        const Divider(thickness: 2, height: 30),
                        Row(
                          children: [
                            const SizedBox(
                              width: 140, 
                              child: Text(
                                "Total Byr", 
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            const Text(": ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            Expanded(
                              child: Text(
                                "Rp ${data['total'] ?? 0}", 
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildItemRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 140, 
            child: Text(
              label, 
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
          const Text(": "),
          Expanded(
            child: Text(
              value, 
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
