import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Halaman1Items extends StatefulWidget {
  final List<Map<String, dynamic>> daftarProduk;
  final Map<int, int> keranjang;
  final Function(int id, int delta) onUbahJumlah;
  final VoidCallback onLanjutPembayaran;

  const Halaman1Items({
    super.key,
    required this.daftarProduk,
    required this.keranjang,
    required this.onUbahJumlah,
    required this.onLanjutPembayaran,
  });

  @override
  State<Halaman1Items> createState() => _Halaman1ItemsState();
}

class _Halaman1ItemsState extends State<Halaman1Items> {
  String kategoriAktif = 'all';
  String kataKunciCari = '';

  String formatRupiah(num number) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(number);
  }

  num get totalBayar {
    num subtotal = 0;
    widget.keranjang.forEach((id, qty) {
      final item = widget.daftarProduk.firstWhere((p) => p['id'] == id);
      subtotal += item['price'] * qty;
    });
    return subtotal + (subtotal * 0.10);
  }

  int get totalItem {
    int total = 0;
    widget.keranjang.forEach((_, qty) => total += qty);
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final listFilter = widget.daftarProduk.where((p) {
      final cocokKategori =
          kategoriAktif == 'all' || p['category'] == kategoriAktif;
      final cocokCari = p['name']
          .toString()
          .toLowerCase()
          .contains(kataKunciCari.toLowerCase());
      return cocokKategori && cocokCari;
    }).toList();

    return Column(
      children: [
        // Search Bar
        Container(
          color: const Color.fromRGBO(247, 177, 176, 1.0),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: TextField(
            onChanged: (val) => setState(() => kataKunciCari = val),
            decoration: InputDecoration(
              hintText: 'Cari menu makanan & minuman...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // Filter Chips Kategori
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              _buildCategoryChip('Semua', 'all'),
              _buildCategoryChip('Makanan', 'makanan'),
              _buildCategoryChip('Minuman', 'minuman'),
              _buildCategoryChip('Cemilan', 'snack'),
            ],
          ),
        ),

        // Header Count
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('PILIH MENU',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.grey)),
              Text('${listFilter.length} Menu Tersedia',
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),

        // Grid Menu
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: listFilter.length,
            itemBuilder: (context, index) {
              final prod = listFilter[index];
              final int qty = widget.keranjang[prod['id']] ?? 0;

              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(247, 177, 176, 1.0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(prod['icon'] as IconData,
                                    size: 48, color: const Color.fromRGBO(247, 177, 176, 1.0)),
                              ),
                              if (qty > 0)
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: const Color.fromRGBO(247, 177, 176, 1.0),
                                    child: Text('$qty',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(prod['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                      Text(formatRupiah(prod['price']),
                          style: TextStyle(
                              color: const Color.fromRGBO(247, 177, 176, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                      const SizedBox(height: 8),

                      // Counter Qty
                      qty == 0
                          ? SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () =>
                                    widget.onUbahJumlah(prod['id'], 1),
                                icon: const Icon(Icons.add, size: 14),
                                label: const Text('Tambah',
                                    style: TextStyle(fontSize: 12)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(247, 177, 176, 1.0),
                                  foregroundColor: const Color.fromRGBO(247, 177, 176, 1.0),
                                  elevation: 0,
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    visualDensity: VisualDensity.compact,
                                    icon: const Icon(Icons.remove, size: 16),
                                    onPressed: () =>
                                        widget.onUbahJumlah(prod['id'], -1),
                                  ),
                                  Text('$qty',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                    visualDensity: VisualDensity.compact,
                                    icon: const Icon(Icons.add, size: 16),
                                    onPressed: () =>
                                        widget.onUbahJumlah(prod['id'], 1),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Bottom Bar Cart Summary
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Keranjang',
                      style: TextStyle(fontSize: 11, color: Colors.grey)),
                  Text(formatRupiah(totalBayar),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              ElevatedButton(
                onPressed: widget.onLanjutPembayaran,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(247, 177, 176, 1.0),
                    foregroundColor: Colors.white),
                child: Row(
                  children: [
                    const Text('Lanjut Pembayaran'),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.white,
                      child: Text('$totalItem',
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(247, 177, 176, 1.0))),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCategoryChip(String title, String catKey) {
    final isSelected = kategoriAktif == catKey;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        selected: isSelected,
        label: Text(title),
        selectedColor: const Color.fromRGBO(247, 177, 176, 1.0),
        labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87, fontSize: 12),
        onSelected: (_) => setState(() => kategoriAktif = catKey),
      ),
    );
  }
}