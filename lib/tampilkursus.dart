import 'package:flutter/material.dart';

class TampilKursus extends StatefulWidget {
  final List<Map<String, dynamic>> listData;

  const TampilKursus({super.key, required this.listData});

  @override
  State<TampilKursus> createState() => _TampilKursusState();
}

class _TampilKursusState extends State<TampilKursus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text("Daftar Tampil Kursus"),
      ),
      body: widget.listData.isEmpty
          ? const Center(child: Text("Belum ada data kursus yang diinput.", style: TextStyle(fontSize: 16)))
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: widget.listData.length,
              itemBuilder: (context, index) {
                final data = widget.listData[index];
                List<String> kursus = List<String>.from(data['kursus'] ?? []);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Pesanan Ke-${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  widget.listData.removeAt(index);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Pesanan kursus berhasil dihapus!')),
                                );
                              },
                            ),
                          ],
                        ),
                        const Divider(),
                        _buildItemRow("No Pesanan", data['noPesanan'] ?? "-"),
                        _buildItemRow("Nama", data['nama'] ?? "-"),
                        _buildItemRow("No Telp", data['noTelp'] ?? "-"),
                        _buildItemRow("Status", data['status'] ?? "-"),
                        _buildItemRow("Kursus", kursus.isEmpty ? "-" : kursus.join(", ")),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const SizedBox(width: 120, child: Text("Total Biaya", style: TextStyle(fontWeight: FontWeight.bold))),
                            const Text(": ", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Rp ${data['total'] ?? 0}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildItemRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
          const Text(": "),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
