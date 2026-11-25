import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Halaman2DetailBayar extends StatefulWidget {
  final List<Map<String, dynamic>> daftarProduk;
  final Map<int, int> keranjang;
  final Function(int id, int delta) onUbahJumlah;
  final Function(Map<String, dynamic> snapshot) onSelesaiTransaksi;

  const Halaman2DetailBayar({
    super.key,
    required this.daftarProduk,
    required this.keranjang,
    required this.onUbahJumlah,
    required this.onSelesaiTransaksi,
  });

  @override
  State<Halaman2DetailBayar> createState() => _Halaman2DetailBayarState();
}

class _Halaman2DetailBayarState extends State<Halaman2DetailBayar> {
  String metodeBayar = 'cash';
  final TextEditingController cashController = TextEditingController();

  String formatRupiah(num number) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(number);
  }

  num get subtotal {
    num total = 0;
    widget.keranjang.forEach((id, qty) {
      final item = widget.daftarProduk.firstWhere((p) => p['id'] == id);
      total += item['price'] * qty;
    });
    return total;
  }

  num get pajak => subtotal * 0.10;
  num get totalBayar => subtotal + pajak;

  void prosesBayar() {
    num nominalCash = totalBayar;
    if (metodeBayar == 'cash') {
      nominalCash = num.tryParse(cashController.text) ?? 0;
      if (nominalCash < totalBayar) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Uang tunai kurang dari total pembayaran!'),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }
    }

    final DateFormat formatterTanggal = DateFormat('dd/MM/yyyy HH:mm');
    widget.onSelesaiTransaksi({
      'idStruk':
          '#TRX-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      'waktu': formatterTanggal.format(DateTime.now()),
      'metode': metodeBayar.toUpperCase(),
      'items': Map<int, int>.from(widget.keranjang),
      'subtotal': subtotal,
      'pajak': pajak,
      'total': totalBayar,
      'bayar': nominalCash,
      'kembali': nominalCash - totalBayar,
    });
  }

  @override
  Widget build(BuildContext context) {
    num nominalInput = num.tryParse(cashController.text) ?? 0;
    num kembalian = nominalInput - totalBayar;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section 1: Detail Multi-Items
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('DETAIL ITEMS (MULTI-ITEMS)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey)),
                      Text('${widget.keranjang.length} Jenis Items',
                          style: const TextStyle(fontSize: 11)),
                    ],
                  ),
                  const Divider(height: 20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.keranjang.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final id = widget.keranjang.keys.elementAt(index);
                      final qty = widget.keranjang[id]!;
                      final item =
                          widget.daftarProduk.firstWhere((p) => p['id'] == id);

                      return Row(
                        children: [
                          Icon(item['icon'] as IconData, color: const Color.fromRGBO(247, 177, 176, 1.0),),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                                Text('${formatRupiah(item['price'])} x $qty',
                                    style: const TextStyle(
                                        fontSize: 11, color: Colors.grey)),
                              ],
                            ),
                          ),
                          Text(formatRupiah(item['price'] * qty),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13)),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              InkWell(
                                onTap: () => widget.onUbahJumlah(id, -1),
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: const Icon(Icons.remove, size: 14),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Text('$qty',
                                    style: const TextStyle(fontSize: 12)),
                              ),
                              InkWell(
                                onTap: () => widget.onUbahJumlah(id, 1),
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(247, 177, 176, 1.0),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: const Icon(Icons.add,
                                      size: 14, color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Subtotal',
                          style: TextStyle(color: Colors.grey)),
                      Text(formatRupiah(subtotal)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Pajak (PPN 10%)',
                          style: TextStyle(color: Colors.grey)),
                      Text(formatRupiah(pajak)),
                    ],
                  ),
                  const Divider(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Bayar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(formatRupiah(totalBayar),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: const Color.fromRGBO(247, 177, 176, 1.0),)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Section 2: Metode Bayar (Cash & QRIS)
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('PILIH PEMBAYARAN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => metodeBayar = 'cash'),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: metodeBayar == 'cash'
                                  ? const Color.fromRGBO(247, 177, 176, 1.0)
                                  : Colors.grey.shade50,
                              border: Border.all(
                                color: metodeBayar == 'cash'
                                    ? const Color.fromRGBO(247, 177, 176, 1.0)
                                    : Colors.grey.shade300,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.money, color: const Color.fromRGBO(247, 177, 176, 1.0),),
                                SizedBox(width: 8),
                                Text('Tunai / Cash',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => metodeBayar = 'qris'),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: metodeBayar == 'qris'
                                  ? Colors.purple.shade50
                                  : Colors.grey.shade50,
                              border: Border.all(
                                color: metodeBayar == 'qris'
                                    ? Colors.purple
                                    : Colors.grey.shade300,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.qr_code_2, color: Colors.purple),
                                SizedBox(width: 8),
                                Text('QRIS Instant',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (metodeBayar == 'cash') ...[
                    TextField(
                      controller: cashController,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        labelText: 'Uang Tunai Diterima (Rp)',
                        prefixText: 'Rp ',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Uang Kembalian:'),
                        Text(
                          formatRupiah(kembalian < 0 ? 0 : kembalian),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: kembalian >= 0
                                ? const Color.fromRGBO(247, 177, 176, 1.0)
                                : Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    const Center(
                      child: Column(
                        children: [
                          Text('Scan QRIS untuk bayar:',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                          SizedBox(height: 8),
                          Icon(Icons.qr_code_scanner,
                              size: 140, color: Colors.black87),
                          Text('✓ QRIS Otomatis Terverifikasi',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: const Color.fromRGBO(247, 177, 176, 1.0),
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: prosesBayar,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(247, 177, 176, 1.0),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Selesaikan Pembayaran & Cetak Struk',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          )
        ],
      ),
    );
  }
}