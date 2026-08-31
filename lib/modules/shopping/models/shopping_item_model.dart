class ShoppingItemModel {
  final String id;
  final String name;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final String? categoryId;
  final String? merchant;
  final DateTime? purchaseDate;

  const ShoppingItemModel({
    required this.id,
    required this.name,
    this.quantity = 1,
    required this.unitPrice,
    required this.totalPrice,
    this.categoryId,
    this.merchant,
    this.purchaseDate,
  });

  ShoppingItemModel copyWith({
    String? id,
    String? name,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    String? categoryId,
    String? merchant,
    DateTime? purchaseDate,
  }) {
    return ShoppingItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      categoryId: categoryId ?? this.categoryId,
      merchant: merchant ?? this.merchant,
      purchaseDate: purchaseDate ?? this.purchaseDate,
    );
  }
}
