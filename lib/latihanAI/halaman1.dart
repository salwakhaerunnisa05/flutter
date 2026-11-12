import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const YaposKasirApp());
}

class YaposKasirApp extends StatelessWidget {
  const YaposKasirApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rumah Makan Bahagia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF4F6FA),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF355070), // Dusk Blue
          elevation: 0,
          foregroundColor: Colors.white,
        ),
      ),
      home: const CatalogPage(),
    );
  }
}

// Format Angka Rupiah
final simpleCurrencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);

// ==========================================
// DATA PRODUK (HANYA GUNAKAN MAP / DICTIONARY)
// ==========================================
final List<Map<String, dynamic>> sampleProducts = [
  {
    'id': '1',
    'name': 'Es Teh Manis',
    'originalPrice': 12000.0,
    'promoPrice': 10000.0,
    'code': 'ET001',
    'stock': 20,
    'category': 'Minuman',
    'imageUrl': 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=300',
    'isPromo': true,
  },
  {
    'id': '2',
    'name': 'Green Tea',
    'originalPrice': 17000.0,
    'promoPrice': 15000.0,
    'code': 'GT001',
    'stock': 12,
    'category': 'Minuman',
    'imageUrl': 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=300',
    'isPromo': true,
  },
  {
    'id': '3',
    'name': 'Roti Toast Kaya Sosis Spesial',
    'originalPrice': 25000.0,
    'promoPrice': 20000.0,
    'code': 'RT001',
    'stock': 24,
    'category': 'Makanan',
    'imageUrl': 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=300',
    'isPromo': true,
  },
  {
    'id': '4',
    'name': 'Nasi Rendang Daging',
    'originalPrice': 20000.0,
    'promoPrice': 17000.0,
    'code': 'NR001',
    'stock': 15,
    'category': 'Makanan',
    'imageUrl': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=300',
    'isPromo': true,
  },
  {
    'id': '5',
    'name': 'Nasi Ikan Tongkol',
    'originalPrice': 25000.0,
    'promoPrice': 22000.0,
    'code': 'NI001',
    'stock': 14,
    'category': 'Makanan',
    'imageUrl': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=300',
    'isPromo': true,
  },
  {
    'id': '6',
    'name': 'Nasi Lodeh Kikil',
    'originalPrice': 25000.0,
    'promoPrice': 22000.0,
    'code': 'NL001',
    'stock': 20,
    'category': 'Makanan',
    'imageUrl': 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=300',
    'isPromo': true,
  },
  {
    'id': '7',
    'name': 'Ayam Kampung Opor',
    'originalPrice': 55000.0,
    'promoPrice': 35000.0,
    'code': 'AK001',
    'stock': 50,
    'category': 'Makanan',
    'imageUrl': 'https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?w=300',
    'isPromo': true,
  },
  {
    'id': '8',
    'name': 'Thai Tea khas Thailand',
    'originalPrice': 20000.0,
    'promoPrice': 0.0,
    'code': 'TT001',
    'stock': 20,
    'category': 'Minuman',
    'imageUrl': 'https://images.unsplash.com/photo-1558857563-b371033873b8?w=300',
    'isPromo': false,
  },
  {
    'id': '9',
    'name': 'Hot Chocolate (Hot Cocoa)',
    'originalPrice': 21000.0,
    'promoPrice': 0.0,
    'code': 'HT001',
    'stock': 78,
    'category': 'Minuman',
    'imageUrl': 'https://images.unsplash.com/photo-1542990253-0d0f5be5f0ed?w=300',
    'isPromo': false,
  },
];

// ==========================================
// TAHAP 1: HALAMAN DAFTAR ITEM (KATALOG)
// ==========================================

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String selectedCategory = 'Semua';
  bool isGridView = true;
  String searchQuery = '';
  
  // Keranjang hanya menyimpan Map sederhana: {'product': Map, 'quantity': int}
  final List<Map<String, dynamic>> cartItems = [];
  
  bool isOnline = true;
  int orderNumber = 121;

  // Filter produk berdasarkan kategori dan pencarian
  List<Map<String, dynamic>> get filteredProducts {
    return sampleProducts.where((product) {
      bool matchesCategory = true;
      if (selectedCategory == 'Promo Hari Ini') {
        matchesCategory = product['isPromo'] == true;
      } else if (selectedCategory != 'Semua') {
        matchesCategory = product['category'] == selectedCategory;
      }

      bool matchesSearch = product['name'].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          product['code'].toString().toLowerCase().contains(searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  // Tambah item ke keranjang
  void addToCart(Map<String, dynamic> product) {
    setState(() {
      final index = cartItems.indexWhere((item) => item['product']['id'] == product['id']);
      if (index >= 0) {
        if (cartItems[index]['quantity'] < product['stock']) {
          cartItems[index]['quantity']++;
        }
      } else {
        cartItems.add({'product': product, 'quantity': 1});
      }
    });
  }

  // Kosongkan keranjang
  void clearCart() {
    setState(() {
      cartItems.clear();
    });
  }

  // Hitung total jumlah barang
  int get totalItemCount {
    int total = 0;
    for (var item in cartItems) {
      total += (item['quantity'] as int);
    }
    return total;
  }

  // Hitung total harga
  double get totalAmount {
    double total = 0;
    for (var item in cartItems) {
      var prod = item['product'];
      double price = prod['isPromo'] ? prod['promoPrice'] : prod['originalPrice'];
      total += price * item['quantity'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rumah Makan Bahagia',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: const [
                Text('Willy ', style: TextStyle(fontSize: 12, color: Colors.white70)),
                Icon(Icons.keyboard_arrow_down, size: 14, color: Colors.white70),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          // 1. Status Bar Kasir (Online/Offline & Search/Toggle Layout)
          Container(
            color: const Color(0xFF355070), // Dusk Blue
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            child: Row(
              children: [
                Icon(
                  isOnline ? Icons.wifi : Icons.wifi_off,
                  color: isOnline ? Colors.greenAccent : Colors.redAccent,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  isOnline ? 'Online ' : 'Offline ',
                  style: TextStyle(
                    color: isOnline ? Colors.greenAccent : Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'No Pesanan : $orderNumber',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                const Spacer(),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  icon: const Icon(Icons.search, color: Colors.white, size: 20),
                  onPressed: () => _showSearchDialog(context),
                ),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  icon: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 20),
                  onPressed: () {},
                ),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  icon: Icon(
                    isGridView ? Icons.grid_view : Icons.view_list,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      isGridView = !isGridView;
                    });
                  },
                ),
              ],
            ),
          ),

          // 2. Bar Filter Kategori
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildCategoryChip('Semua'),
                _buildCategoryChip('Promo Hari Ini', isPercent: true),
                _buildCategoryChip('Makanan'),
                _buildCategoryChip('Minuman'),
              ],
            ),
          ),

          // Judul Sub-Kategori
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Row(
              children: [
                if (selectedCategory == 'Promo Hari Ini')
                  const Icon(Icons.percent, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  selectedCategory,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            ),
          ),

          // 3. Daftar Produk (Grid Card 3 Kolom atau List Tile)
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(child: Text('Tidak ada item ditemukan'))
                : isGridView
                    ? GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.68,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          final cartItem = cartItems.firstWhere(
                            (item) => item['product']['id'] == product['id'],
                            orElse: () => {'product': product, 'quantity': 0},
                          );
                          return _buildGridCard(product, cartItem['quantity']);
                        },
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          final cartItem = cartItems.firstWhere(
                            (item) => item['product']['id'] == product['id'],
                            orElse: () => {'product': product, 'quantity': 0},
                          );
                          return _buildListTile(product, cartItem['quantity']);
                        },
                      ),
          ),

          // 4. Baris Menu Bawah
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: const [
                    Icon(Icons.person_outline, size: 18, color: Colors.black87),
                    SizedBox(width: 4),
                    Text('Pilih Pelanggan', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  ],
                ),
                Container(height: 16, width: 1, color: Colors.grey.shade300),
                Row(
                  children: const [
                    Icon(Icons.history, size: 18, color: Colors.black87),
                    SizedBox(width: 4),
                    Text('Riwayat Pesanan', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),

          // 5. Floating Cart Bar (Selalu Tampil)
          _buildFloatingCartBar(),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String title, {bool isPercent = false}) {
    final isSelected = selectedCategory == title;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        showCheckmark: false,
        avatar: isPercent ? Icon(Icons.percent, size: 14, color: isSelected ? Colors.white : Colors.black87) : null,
        label: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
        selected: isSelected,
        selectedColor: const Color(0xFFEAAC8B), // Light Bronze
        backgroundColor: Colors.white,
        onSelected: (bool selected) {
          setState(() {
            selectedCategory = title;
          });
        },
      ),
    );
  }

  Widget _buildGridCard(Map<String, dynamic> product, int qtyInCart) {
    return GestureDetector(
      onTap: () => addToCart(product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4, offset: const Offset(0, 2)),
          ],
          border: qtyInCart > 0 ? Border.all(color: const Color(0xFF6D597A), width: 2) : null, // Dusty Lavender
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    product['imageUrl'],
                    height: 95,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAAC8B).withOpacity(0.9), // Light Bronze Badge
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.inventory_2_outlined, color: Colors.white, size: 10),
                        const SizedBox(width: 3),
                        Text(
                          '${product['stock']}',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                if (qtyInCart > 0)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: const Color(0xFF6D597A), // Dusty Lavender Badge
                      child: Text(
                        '$qtyInCart',
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, height: 1.1),
                  ),
                  const SizedBox(height: 6),
                  if (product['isPromo']) ...[
                    Text(
                      simpleCurrencyFormatter.format(product['originalPrice']),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      simpleCurrencyFormatter.format(product['promoPrice']),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF00A651),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ] else ...[
                    Text(
                      simpleCurrencyFormatter.format(product['originalPrice']),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  const SizedBox(height: 2),
                  Text(
                    product['code'],
                    style: const TextStyle(fontSize: 9, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(Map<String, dynamic> product, int qtyInCart) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: qtyInCart > 0 ? const BorderSide(color: Color(0xFF6D597A), width: 1.5) : BorderSide.none,
      ),
      child: ListTile(
        onTap: () => addToCart(product),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            product['imageUrl'],
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(product['name'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (product['isPromo']) ...[
                  Text(
                    simpleCurrencyFormatter.format(product['originalPrice']),
                    style: const TextStyle(fontSize: 11, color: Colors.grey, decoration: TextDecoration.lineThrough),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    simpleCurrencyFormatter.format(product['promoPrice']),
                    style: const TextStyle(fontSize: 12, color: Color(0xFF00A651), fontWeight: FontWeight.bold),
                  ),
                ] else ...[
                  Text(
                    simpleCurrencyFormatter.format(product['originalPrice']),
                    style: const TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                ],
              ],
            ),
            Text(product['code'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Stok ${product['stock']}', style: const TextStyle(fontSize: 11, color: Colors.black87)),
            if (qtyInCart > 0) ...[
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 12,
                backgroundColor: const Color(0xFF6D597A), // Dusty Lavender
                child: Text('$qtyInCart', style: const TextStyle(color: Colors.white, fontSize: 11)),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingCartBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: clearCart,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xFFB56576), // Rosewood
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.delete_outline, color: Colors.white, size: 20),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (cartItems.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPaymentPage(
                          cartItems: cartItems,
                          orderNumber: orderNumber,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Keranjang masih kosong, pilih item terlebih dahulu!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6DFEB),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '$totalItemCount Item',
                        style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Total',
                        style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Text(
                        simpleCurrencyFormatter.format(totalAmount),
                        style: const TextStyle(fontSize: 17, color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cari Produk'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Nama atau kode produk...'),
          onChanged: (val) {
            setState(() {
              searchQuery = val;
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }
}

// ==========================================
// TAHAP 2: HALAMAN DETAIL ITEM & PEMBAYARAN
// ==========================================

class CheckoutPaymentPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final int orderNumber;

  const CheckoutPaymentPage({
    Key? key,
    required this.cartItems,
    required this.orderNumber,
  }) : super(key: key);

  @override
  State<CheckoutPaymentPage> createState() => _CheckoutPaymentPageState();
}

class _CheckoutPaymentPageState extends State<CheckoutPaymentPage> {
  String selectedPaymentMethod = 'Tunai'; // 'Tunai', 'QRIS', 'Debit'
  final TextEditingController cashPaidController = TextEditingController();
  double cashPaidAmount = 0;

  @override
  void initState() {
    super.initState();
    // Default cash = Uang Pas
    cashPaidAmount = totalAmount;
    cashPaidController.text = simpleCurrencyFormatter.format(totalAmount);
  }

  @override
  void dispose() {
    cashPaidController.dispose();
    super.dispose();
  }

  double get totalAmount {
    double total = 0;
    for (var item in widget.cartItems) {
      var prod = item['product'];
      double price = prod['isPromo'] ? prod['promoPrice'] : prod['originalPrice'];
      total += price * item['quantity'];
    }
    return total;
  }

  int get totalItemCount {
    int total = 0;
    for (var item in widget.cartItems) {
      total += (item['quantity'] as int);
    }
    return total;
  }

  double get changeAmount {
    return cashPaidAmount - totalAmount;
  }

  void updateQuantity(int index, int delta) {
    setState(() {
      final currentQty = widget.cartItems[index]['quantity'] as int;
      final stock = widget.cartItems[index]['product']['stock'] as int;
      final newQty = currentQty + delta;

      if (newQty <= 0) {
        widget.cartItems.removeAt(index);
        if (widget.cartItems.isEmpty) {
          Navigator.pop(context); // Kembali ke katalog jika keranjang kosong
        }
      } else if (newQty <= stock) {
        widget.cartItems[index]['quantity'] = newQty;
      }

      // Update nominal tunai default jika pakai uang pas
      cashPaidAmount = totalAmount;
      cashPaidController.text = simpleCurrencyFormatter.format(totalAmount);
    });
  }

  void selectQuickCash(double amount) {
    setState(() {
      cashPaidAmount = amount;
      cashPaidController.text = simpleCurrencyFormatter.format(amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pesanan #${widget.orderNumber}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF355070), // Dusk Blue
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Rincian Item Keranjang
                  const Text(
                    'Detail Pesanan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.cartItems.length,
                        separatorBuilder: (context, i) => const Divider(),
                        itemBuilder: (context, index) {
                          final item = widget.cartItems[index];
                          final prod = item['product'];
                          final qty = item['quantity'] as int;
                          final price = prod['isPromo'] ? prod['promoPrice'] : prod['originalPrice'];

                          return Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  prod['imageUrl'],
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      prod['name'],
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Rp ${simpleCurrencyFormatter.format(price)}',
                                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              // Kontrol Kuantitas (- / +)
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline, color: Color(0xFFE56B6F), size: 22), // Light Coral
                                    onPressed: () => updateQuantity(index, -1),
                                  ),
                                  Text(
                                    '$qty',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline, color: Color(0xFF355070), size: 22), // Dusk Blue
                                    onPressed: () => updateQuantity(index, 1),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 2. Metode Pembayaran
                  const Text(
                    'Metode Pembayaran',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildPaymentMethodTile('Tunai', Icons.payments_outlined)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildPaymentMethodTile('QRIS', Icons.qr_code_2)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildPaymentMethodTile('Debit', Icons.credit_card)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 3. Form Input Tunai (Hanya Tampil Jika Tunai)
                  if (selectedPaymentMethod == 'Tunai') ...[
                    const Text(
                      'Nominal Pembayaran (Tunai)',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: cashPaidController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Jumlah Uang Tunai (Rp)',
                                prefixText: 'Rp ',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (val) {
                                final cleaned = val.replaceAll(RegExp(r'[^\d]'), '');
                                setState(() {
                                  cashPaidAmount = double.tryParse(cleaned) ?? 0;
                                });
                              },
                            ),
                            const SizedBox(height: 12),
                            const Text('Pilihan Uang Pas / Pecahan Cepat:', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                ActionChip(
                                  label: const Text('Uang Pas'),
                                  backgroundColor: const Color(0xFFD6DFEB),
                                  onPressed: () => selectQuickCash(totalAmount),
                                ),
                                ActionChip(
                                  label: const Text('20.000'),
                                  onPressed: () => selectQuickCash(20000),
                                ),
                                ActionChip(
                                  label: const Text('50.000'),
                                  onPressed: () => selectQuickCash(50000),
                                ),
                                ActionChip(
                                  label: const Text('100.000'),
                                  onPressed: () => selectQuickCash(100000),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // 4. Summary & Cash Out Bar (Bottom)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2)),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Tagihan', style: TextStyle(fontSize: 14, color: Colors.grey)),
                      Text(
                        'Rp ${simpleCurrencyFormatter.format(totalAmount)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ],
                  ),
                  if (selectedPaymentMethod == 'Tunai') ...[
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          changeAmount >= 0 ? 'Kembalian' : 'Kurang Bayar',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: changeAmount >= 0 ? const Color(0xFF00A651) : Colors.red,
                          ),
                        ),
                        Text(
                          'Rp ${simpleCurrencyFormatter.format(changeAmount.abs())}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: changeAmount >= 0 ? const Color(0xFF00A651) : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (selectedPaymentMethod == 'Tunai' && changeAmount < 0)
                            ? Colors.grey
                            : const Color(0xFF6D597A), // Dusty Lavender
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      onPressed: (selectedPaymentMethod == 'Tunai' && changeAmount < 0)
                          ? null
                          : () {
                              // Berpindah ke Halaman 3 (Struk Pembayaran) dengan membawa data transaksi
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReceiptPage(
                                    cartItems: List.from(widget.cartItems),
                                    orderNumber: widget.orderNumber,
                                    paymentMethod: selectedPaymentMethod,
                                    paidAmount: selectedPaymentMethod == 'Tunai' ? cashPaidAmount : totalAmount,
                                    totalAmount: totalAmount,
                                  ),
                                ),
                              );
                            },
                      child: const Text(
                        'BAYAR SEKARANG',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodTile(String method, IconData icon) {
    final isSelected = selectedPaymentMethod == method;
    return InkWell(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method;
        });
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF355070) : Colors.white, // Dusk Blue
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFF355070) : Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.black87),
            const SizedBox(height: 4),
            Text(
              method,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// TAHAP 3: HALAMAN STRUK PEMBAYARAN (RECEIPT)
// ==========================================

class ReceiptPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final int orderNumber;
  final String paymentMethod;
  final double paidAmount;
  final double totalAmount;

  const ReceiptPage({
    Key? key,
    required this.cartItems,
    required this.orderNumber,
    required this.paymentMethod,
    required this.paidAmount,
    required this.totalAmount,
  }) : super(key: key);

  double get changeAmount => paidAmount - totalAmount;

  @override
  Widget build(BuildContext context) {
    final String transactionDate = DateFormat('dd MMM yyyy, HH:mm').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF355070), // Dusk Blue
      appBar: AppBar(
        title: const Text('Struk Pembayaran', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Header Struk (Nama Toko & Icon Berhasil)
                      const Icon(Icons.check_circle, color: Color(0xFF00A651), size: 56),
                      const SizedBox(height: 8),
                      const Text(
                        'Pembayaran Berhasil!',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF00A651)),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Rumah Makan Bahagia',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Jl. Raya Kasir No. 123, Jakarta',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      const Divider(thickness: 1),

                      // Meta Transaksi
                      _buildReceiptMeta('No. Pesanan', '#$orderNumber'),
                      _buildReceiptMeta('Tanggal', transactionDate),
                      _buildReceiptMeta('Kasir', 'Willy'),
                      _buildReceiptMeta('Metode Bayar', paymentMethod),
                      const Divider(thickness: 1),
                      const SizedBox(height: 8),

                      // Daftar Item
                      ...cartItems.map((item) {
                        final prod = item['product'];
                        final qty = item['quantity'] as int;
                        final price = prod['isPromo'] ? prod['promoPrice'] : prod['originalPrice'];
                        final itemTotal = price * qty;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  '${prod['name']} x$qty',
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Rp ${simpleCurrencyFormatter.format(itemTotal)}',
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),

                      const SizedBox(height: 12),
                      const Divider(thickness: 1),

                      // Rincian Total & Kembalian
                      _buildReceiptTotalRow('Total Tagihan', totalAmount, isBold: true),
                      _buildReceiptTotalRow('Bayar ($paymentMethod)', paidAmount),
                      if (paymentMethod == 'Tunai')
                        _buildReceiptTotalRow('Kembalian', changeAmount, isHighlight: true),

                      const SizedBox(height: 20),
                      const Text(
                        '--- Terima Kasih Atas Kunjungan Anda ---',
                        style: TextStyle(fontSize: 11, color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Tombol Aksi Bawah
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: Color(0xFF355070)), // Dusk Blue
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Mencetak struk ke printer Bluetooth...')),
                        );
                      },
                      icon: const Icon(Icons.print, color: Color(0xFF355070)),
                      label: const Text('Cetak', style: TextStyle(color: Color(0xFF355070))),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: const Color(0xFF6D597A), // Dusty Lavender
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        // Reset dan kembali ke Halaman Katalog Utama (Halaman 1) untuk transaksi baru
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const CatalogPage()),
                          (route) => false,
                        );
                      },
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      label: const Text('Pesanan Baru', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptMeta(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildReceiptTotalRow(String label, double amount, {bool isBold = false, bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isBold ? 14 : 13,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isHighlight ? const Color(0xFF00A651) : Colors.black87,
            ),
          ),
          Text(
            'Rp ${simpleCurrencyFormatter.format(amount)}',
            style: TextStyle(
              fontSize: isBold ? 15 : 13,
              fontWeight: isBold || isHighlight ? FontWeight.bold : FontWeight.w600,
              color: isHighlight ? const Color(0xFF00A651) : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}