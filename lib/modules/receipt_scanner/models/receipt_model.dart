import '../../shopping/models/shopping_item_model.dart';

class ReceiptModel {
  final String id;
  final String merchantName;
  final String? address;
  final DateTime dateTime;
  final double totalAmount;
  final double subtotal;
  final double tax;
  final double discount;
  final String paymentMethod;
  final List<ShoppingItemModel> items;
  final String? imageUrl;
  final String suggestedCategoryId;
  final String? suggestedJarId;

  const ReceiptModel({
    required this.id,
    required this.merchantName,
    this.address,
    required this.dateTime,
    required this.totalAmount,
    required this.subtotal,
    this.tax = 0.0,
    this.discount = 0.0,
    this.paymentMethod = 'Thẻ Visa / Chuyển khoản',
    required this.items,
    this.imageUrl,
    this.suggestedCategoryId = 'groceries',
    this.suggestedJarId,
  });

  static List<ReceiptModel> get sampleReceipts => [
        ReceiptModel(
          id: 'rc_winmart_01',
          merchantName: 'WinMart Landmark 81',
          address: '720A Điện Biên Phủ, P.22, Q.Bình Thạnh, TP.HCM',
          dateTime: DateTime.now().subtract(const Duration(hours: 3)),
          subtotal: 360000.0,
          tax: 28800.0,
          discount: 38800.0,
          totalAmount: 350000.0,
          suggestedCategoryId: 'groceries',
          suggestedJarId: 'jar_food',
          items: [
            ShoppingItemModel(
              id: 'it_1',
              name: 'Sữa tươi thanh trùng Vinamilk 1L',
              quantity: 2,
              unitPrice: 38000.0,
              totalPrice: 76000.0,
              categoryId: 'groceries',
              merchant: 'WinMart Landmark 81',
              purchaseDate: DateTime.now().subtract(const Duration(hours: 3)),
            ),
            ShoppingItemModel(
              id: 'it_2',
              name: 'Bánh mì ngũ cốc nguyên cám',
              quantity: 1,
              unitPrice: 34000.0,
              totalPrice: 34000.0,
              categoryId: 'groceries',
              merchant: 'WinMart Landmark 81',
              purchaseDate: DateTime.now().subtract(const Duration(hours: 3)),
            ),
            ShoppingItemModel(
              id: 'it_3',
              name: 'Thịt ba chỉ heo sạch MEATDeli 400g',
              quantity: 1,
              unitPrice: 125000.0,
              totalPrice: 125000.0,
              categoryId: 'groceries',
              merchant: 'WinMart Landmark 81',
              purchaseDate: DateTime.now().subtract(const Duration(hours: 3)),
            ),
            ShoppingItemModel(
              id: 'it_4',
              name: 'Dầu gội Head & Shoulders Bạc hà 650g',
              quantity: 1,
              unitPrice: 125000.0,
              totalPrice: 125000.0,
              categoryId: 'health',
              merchant: 'WinMart Landmark 81',
              purchaseDate: DateTime.now().subtract(const Duration(hours: 3)),
            ),
          ],
        ),
        ReceiptModel(
          id: 'rc_highlands_02',
          merchantName: 'Highlands Coffee Vincom',
          address: 'Vincom Đồng Khởi, Q.1, TP.HCM',
          dateTime: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
          subtotal: 65000.0,
          tax: 0.0,
          discount: 0.0,
          totalAmount: 65000.0,
          suggestedCategoryId: 'food',
          suggestedJarId: 'jar_food',
          items: [
            ShoppingItemModel(
              id: 'it_5',
              name: 'Phin Sữa Đá Cỡ Lớn',
              quantity: 1,
              unitPrice: 45000.0,
              totalPrice: 45000.0,
              categoryId: 'food',
              merchant: 'Highlands Coffee Vincom',
              purchaseDate: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
            ),
            ShoppingItemModel(
              id: 'it_6',
              name: 'Bánh Mì Que Gà Phô Mai',
              quantity: 1,
              unitPrice: 20000.0,
              totalPrice: 20000.0,
              categoryId: 'food',
              merchant: 'Highlands Coffee Vincom',
              purchaseDate: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
            ),
          ],
        ),
        ReceiptModel(
          id: 'rc_uniqlo_03',
          merchantName: 'UNIQLO Saigon Centre',
          address: '65 Lê Lợi, P. Bến Nghé, Quận 1, TP.HCM',
          dateTime: DateTime.now().subtract(const Duration(days: 2, hours: 5)),
          subtotal: 899000.0,
          tax: 71920.0,
          discount: 120920.0,
          totalAmount: 850000.0,
          suggestedCategoryId: 'shopping',
          suggestedJarId: 'jar_shopping',
          items: [
            ShoppingItemModel(
              id: 'it_7',
              name: 'Áo thun cổ tròn AIRism Cotton',
              quantity: 2,
              unitPrice: 299000.0,
              totalPrice: 598000.0,
              categoryId: 'shopping',
              merchant: 'UNIQLO Saigon Centre',
              purchaseDate: DateTime.now().subtract(const Duration(days: 2, hours: 5)),
            ),
            ShoppingItemModel(
              id: 'it_8',
              name: 'Quần đùi thể thao Ultra Stretch',
              quantity: 1,
              unitPrice: 301000.0,
              totalPrice: 301000.0,
              categoryId: 'shopping',
              merchant: 'UNIQLO Saigon Centre',
              purchaseDate: DateTime.now().subtract(const Duration(days: 2, hours: 5)),
            ),
          ],
        ),
      ];
}
