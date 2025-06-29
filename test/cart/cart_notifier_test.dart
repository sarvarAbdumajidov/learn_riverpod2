import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as p;
import 'package:learn_riverpod2/features/products/application/cart_provider.dart';
import 'package:learn_riverpod2/features/products/domain/cart_item_model.dart';
import 'package:learn_riverpod2/features/products/domain/product_model.dart';

void main() {
  late ProviderContainer container;

  setUpAll(() async {
    // 🔧 Test uchun Hive fayl papkasi
    final dir = Directory(p.join(Directory.current.path, '.dart_tool', 'test_hive'));
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    // 🧠 Hive test muhiti uchun init
    Hive.init(dir.path);

    // 🧩 Adapterlar
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(CartItemAdapter());

    // 📦 Box ochish
    final box = await Hive.openBox<CartItem>('cartBox');
    await box.clear();
  });

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() async {
    await Hive.box<CartItem>('cartBox').clear(); // test oralig‘ida tozalash
    container.dispose();
  });

  // 🧪 Sinov uchun dummy product
  final testProduct = Product(id: 'p1', name: 'Test Product', price: 10);

  test('addToCart adds product', () {
    final notifier = container.read(cartProvider.notifier);
    notifier.addToCart(testProduct);

    final cartItems = container.read(cartProvider);
    expect(cartItems.length, 1);
    expect(cartItems.first.product.id, 'p1');
    expect(cartItems.first.quantity, 1);
  });

  test('removeFromCart removes product', () {
    final notifier = container.read(cartProvider.notifier);
    notifier.addToCart(testProduct);
    notifier.removeFromCart(testProduct);

    final cartItems = container.read(cartProvider);
    expect(cartItems.isEmpty, true);
  });

  test('totalPrice computes correct sum', () {
    final notifier = container.read(cartProvider.notifier);
    notifier.addToCart(testProduct);
    notifier.addToCart(testProduct);

    final total = notifier.totalPirce;
    expect(total, 20.0);
  });
}
