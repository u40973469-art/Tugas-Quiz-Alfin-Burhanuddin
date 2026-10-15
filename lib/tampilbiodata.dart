import 'package:flutter/material.dart';

class TampilBiodata extends StatefulWidget {
  final List<Map<String, dynamic>> listData;

  const TampilBiodata({super.key, required this.listData});

  @override
  State<TampilBiodata> createState() => _TampilBiodataState();
}

class _TampilBiodataState extends State<TampilBiodata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text("Daftar Tampil Biodata"),
      ),
      body: widget.listData.isEmpty
          ? const Center(child: Text("Belum ada data biodata yang diinput.", style: TextStyle(fontSize: 16)))
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: widget.listData.length,
              itemBuilder: (context, index) {
                final data = widget.listData[index];
                List<dynamic> hobi = data['hobi'] ?? [];

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
                            Text("Data Ke-${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  widget.listData.removeAt(index);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Data berhasil dihapus!')),
                                );
                              },
                            ),
                          ],
                        ),
                        const Divider(),
                        _buildItemRow("NIM", data['nim'] ?? "-"),
                        _buildItemRow("Nama", data['name'] ?? "-"),
                        _buildItemRow("Jenis Kelamin", data['jk'] ?? "-"),
                        _buildItemRow("Agama/Status", data['status'] ?? "-"),
                        _buildItemRow("Hobi", hobi.isEmpty ? "-" : hobi.join(", ")),
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
