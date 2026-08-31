import '../../../core/constants/app_constants.dart';
import '../../receipt_scanner/models/receipt_model.dart';
import '../../shopping/models/shopping_item_model.dart';

class ExpenseModel {
  final String id;
  final String title;
  final String merchant;
  final double amount;
  final String categoryId;
  final String jarId;
  final DateTime dateTime;
  final PaymentMethod paymentMethod;
  final String? note;
  final ReceiptModel? receipt;
  final List<ShoppingItemModel> items;

  const ExpenseModel({
    required this.id,
    required this.title,
    required this.merchant,
    required this.amount,
    required this.categoryId,
    required this.jarId,
    required this.dateTime,
    this.paymentMethod = PaymentMethod.creditCard,
    this.note,
    this.receipt,
    this.items = const [],
  });

  bool get hasReceipt => receipt != null;

  ExpenseModel copyWith({
    String? id,
    String? title,
    String? merchant,
    double? amount,
    String? categoryId,
    String? jarId,
    DateTime? dateTime,
    PaymentMethod? paymentMethod,
    String? note,
    ReceiptModel? receipt,
    List<ShoppingItemModel>? items,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      merchant: merchant ?? this.merchant,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      jarId: jarId ?? this.jarId,
      dateTime: dateTime ?? this.dateTime,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      note: note ?? this.note,
      receipt: receipt ?? this.receipt,
      items: items ?? this.items,
    );
  }
}
