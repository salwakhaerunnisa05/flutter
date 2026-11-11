import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Halaman3Struk extends StatelessWidget {
  final List<Map<String, dynamic>> daftarProduk;
  final Map<String, dynamic> dataStruk;
  final VoidCallback onTransaksiBaru;

  const Halaman3Struk({
    super.key,
    required this.daftarProduk,
    required this.dataStruk,
    required this.onTransaksiBaru,
  });

  String formatRupiah(num number) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(number);
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, int> itemsStruk = dataStruk['items'] ?? {};

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Color.fromRGBO(89, 101, 111, 1.0),
            child: Icon(Icons.check, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          const Text('Pembayaran Berhasil!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Text('Transaksi telah tercatat ke dalam sistem',
              style: TextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 16),

          // Struk Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            elevation: 0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Column(
                      children: [
                        Text('POSKASIR RESTO',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                        Text('Jl. Education No. 10, Jakarta',
                            style:
                                TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                  ),
                  const Divider(height: 24),
                  _buildRowInfo('No. Struk', dataStruk['idStruk'] ?? '-'),
                  _buildRowInfo('Tanggal', dataStruk['waktu'] ?? '-'),
                  _buildRowInfo('Kasir', 'Kelompok 1 (Siswa)'),
                  _buildRowInfo('Metode Bayar', dataStruk['metode'] ?? '-'),
                  const Divider(height: 24),
                  const Text('DETAIL PEMBELIAN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.grey)),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: itemsStruk.length,
                    itemBuilder: (context, index) {
                      final id = itemsStruk.keys.elementAt(index);
                      final qty = itemsStruk[id]!;
                      final item =
                          daftarProduk.firstWhere((p) => p['id'] == id);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                                Text('$qty x ${formatRupiah(item['price'])}',
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.grey)),
                              ],
                            ),
                            Text(formatRupiah(item['price'] * qty),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                      );
                    },
                  ),
                  const Divider(height: 24),
                  _buildRowInfo(
                      'Subtotal', formatRupiah(dataStruk['subtotal'] ?? 0)),
                  _buildRowInfo(
                      'Pajak (PPN 10%)', formatRupiah(dataStruk['pajak'] ?? 0)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Akhir',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                      Text(formatRupiah(dataStruk['total'] ?? 0),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color.fromRGBO(89, 101, 111, 1.0))),
                    ],
                  ),
                  _buildRowInfo(
                      'Bayar', formatRupiah(dataStruk['bayar'] ?? 0)),
                  _buildRowInfo(
                      'Kembali', formatRupiah(dataStruk['kembali'] ?? 0)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mencetak struk...')),
              );
            },
            icon: const Icon(Icons.print),
            label: const Text('Cetak Struk'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(89, 101, 111, 1.0),
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(44),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: onTransaksiBaru,
            icon: const Icon(Icons.refresh),
            label: const Text('Transaksi Baru'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(89, 101, 111, 1.0),
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(44),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowInfo(String title, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 11, color: Colors.grey)),
          Text(val,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87)),
        ],
      ),
    );
  }
}