import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../analysis/models/insight_model.dart';
import '../../budget/models/spending_jar_model.dart';
import '../../expense/models/category_model.dart';
import '../../expense/models/expense_model.dart';
import '../../receipt_scanner/models/receipt_model.dart';
import '../../shopping/models/shopping_item_model.dart';

class AppStateManager extends ChangeNotifier {
  static final AppStateManager instance = AppStateManager._internal();
  AppStateManager._internal() {
    _initSampleData();
  }

  int _selectedTab = 0;
  int get selectedTab => _selectedTab;
  void setTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  double _monthlyBudget = AppConstants.defaultMonthlyBudget;
  double get monthlyBudget => _monthlyBudget;
  void setMonthlyBudget(double amount) {
    _monthlyBudget = amount;
    notifyListeners();
  }

  List<SpendingJarModel> _jars = [];
  List<SpendingJarModel> get jars => List.unmodifiable(_jars);

  List<ExpenseModel> _expenses = [];
  List<ExpenseModel> get expenses => List.unmodifiable(_expenses);

  List<InsightModel> _insights = [];
  List<InsightModel> get insights => List.unmodifiable(_insights);

  final List<CategoryModel> _categories = CategoryModel.defaultCategories;
  List<CategoryModel> get categories => List.unmodifiable(_categories);

  void _initSampleData() {
    _jars = SpendingJarModel.sampleJars;
    _insights = InsightModel.sampleInsights;

    final now = DateTime.now();
    final sampleReceipts = ReceiptModel.sampleReceipts;

    _expenses = [
      ExpenseModel(
        id: 'exp_1',
        title: 'WinMart Landmark 81',
        merchant: 'WinMart',
        amount: 350000.0,
        categoryId: 'groceries',
        jarId: 'jar_food',
        dateTime: now.subtract(const Duration(hours: 2)),
        paymentMethod: PaymentMethod.creditCard,
        receipt: sampleReceipts[0],
        items: sampleReceipts[0].items,
        note: 'Mua đồ ăn tuần & dầu gội',
      ),
      ExpenseModel(
        id: 'exp_2',
        title: 'Highlands Coffee Vincom',
        merchant: 'Highlands Coffee',
        amount: 65000.0,
        categoryId: 'food',
        jarId: 'jar_food',
        dateTime: now.subtract(const Duration(days: 1, hours: 2)),
        paymentMethod: PaymentMethod.eWallet,
        receipt: sampleReceipts[1],
        items: sampleReceipts[1].items,
        note: 'Cà phê sáng cùng bạn',
      ),
      ExpenseModel(
        id: 'exp_3',
        title: 'UNIQLO Saigon Centre',
        merchant: 'UNIQLO',
        amount: 850000.0,
        categoryId: 'shopping',
        jarId: 'jar_shopping',
        dateTime: now.subtract(const Duration(days: 2, hours: 5)),
        paymentMethod: PaymentMethod.creditCard,
        receipt: sampleReceipts[2],
        items: sampleReceipts[2].items,
        note: 'Áo thun AIRism & Quần thể thao',
      ),
      ExpenseModel(
        id: 'exp_4',
        title: 'Shopee - Tai nghe Bluetooth',
        merchant: 'Shopee',
        amount: 400000.0,
        categoryId: 'shopping',
        jarId: 'jar_shopping',
        dateTime: now.subtract(const Duration(days: 3)),
        paymentMethod: PaymentMethod.eWallet,
        note: 'Đơn hàng sale 25/8',
      ),
      ExpenseModel(
        id: 'exp_5',
        title: 'GrabCar đi làm',
        merchant: 'Grab',
        amount: 120000.0,
        categoryId: 'transport',
        jarId: 'jar_transport',
        dateTime: now.subtract(const Duration(days: 3, hours: 8)),
        paymentMethod: PaymentMethod.eWallet,
        note: 'Trời mưa lớn',
      ),
      ExpenseModel(
        id: 'exp_6',
        title: 'Hoá đơn tiền điện EVN',
        merchant: 'EVN TP.HCM',
        amount: 650000.0,
        categoryId: 'bills',
        jarId: 'jar_food',
        dateTime: now.subtract(const Duration(days: 4)),
        paymentMethod: PaymentMethod.bankTransfer,
        note: 'Kỳ tháng 8/2026',
      ),
      ExpenseModel(
        id: 'exp_7',
        title: 'Xem phim CGV & Bắp nước',
        merchant: 'CGV Cinemas',
        amount: 260000.0,
        categoryId: 'entertainment',
        jarId: 'jar_entertainment',
        dateTime: now.subtract(const Duration(days: 5)),
        paymentMethod: PaymentMethod.creditCard,
        note: 'Phim cuối tuần',
      ),
      ExpenseModel(
        id: 'exp_8',
        title: 'Guardian Mỹ phẩm & Vitamin',
        merchant: 'Guardian',
        amount: 250000.0,
        categoryId: 'health',
        jarId: 'jar_personal',
        dateTime: now.subtract(const Duration(days: 6)),
        paymentMethod: PaymentMethod.creditCard,
        note: 'Sữa rửa mặt & Bổ sung C',
      ),
      ExpenseModel(
        id: 'exp_9',
        title: 'GrabBike đi cà phê',
        merchant: 'Grab',
        amount: 42000.0,
        categoryId: 'transport',
        jarId: 'jar_transport',
        dateTime: now.subtract(const Duration(days: 7)),
        paymentMethod: PaymentMethod.eWallet,
      ),
    ];

    _recalculateJars();
  }

  void _recalculateJars() {
    for (int i = 0; i < _jars.length; i++) {
      final jarId = _jars[i].id;
      final totalForJar = _expenses
          .where((e) => e.jarId == jarId)
          .fold(0.0, (sum, item) => sum + item.amount);
      _jars[i] = _jars[i].copyWith(spent: totalForJar);
    }
  }

  double get totalSpentThisMonth {
    final now = DateTime.now();
    return _expenses
        .where((e) => e.dateTime.month == now.month && e.dateTime.year == now.year)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalSpentToday {
    final now = DateTime.now();
    return _expenses
        .where((e) =>
            e.dateTime.day == now.day &&
            e.dateTime.month == now.month &&
            e.dateTime.year == now.year)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalBudget {
    return _jars.fold(0.0, (sum, jar) => sum + jar.budget);
  }

  double get remainingBudget => (totalBudget - totalSpentThisMonth).clamp(0.0, double.infinity);

  List<ExpenseModel> get recentExpenses {
    final list = List<ExpenseModel>.from(_expenses);
    list.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return list;
  }

  void addExpense(ExpenseModel expense) {
    _expenses.insert(0, expense);
    _recalculateJars();
    _checkBudgetAlerts(expense.jarId);
    notifyListeners();
  }

  void updateExpense(ExpenseModel expense) {
    final idx = _expenses.indexWhere((e) => e.id == expense.id);
    if (idx != -1) {
      _expenses[idx] = expense;
      _recalculateJars();
      notifyListeners();
    }
  }

  void deleteExpense(String id) {
    _expenses.removeWhere((e) => e.id == id);
    _recalculateJars();
    notifyListeners();
  }

  void addJar(SpendingJarModel jar) {
    _jars.add(jar);
    _recalculateJars();
    notifyListeners();
  }

  void updateJar(SpendingJarModel jar) {
    final idx = _jars.indexWhere((j) => j.id == jar.id);
    if (idx != -1) {
      _jars[idx] = jar;
      notifyListeners();
    }
  }

  void deleteJar(String jarId) {
    _jars.removeWhere((j) => j.id == jarId);
    notifyListeners();
  }

  SpendingJarModel? getJarById(String id) {
    try {
      return _jars.firstWhere((j) => j.id == id);
    } catch (_) {
      return null;
    }
  }

  CategoryModel getCategoryById(String id) {
    return CategoryModel.getById(id);
  }

  ExpenseModel processReceiptScan(
    ReceiptModel receipt, {
    required String categoryId,
    required String jarId,
    PaymentMethod paymentMethod = PaymentMethod.creditCard,
    String? note,
  }) {
    final expense = ExpenseModel(
      id: 'exp_${DateTime.now().millisecondsSinceEpoch}',
      title: receipt.merchantName,
      merchant: receipt.merchantName,
      amount: receipt.totalAmount,
      categoryId: categoryId,
      jarId: jarId,
      dateTime: receipt.dateTime,
      paymentMethod: paymentMethod,
      note: note ?? 'Quét hoá đơn OCR tự động',
      receipt: receipt,
      items: receipt.items,
    );

    addExpense(expense);
    return expense;
  }

  void _checkBudgetAlerts(String jarId) {
    final jar = getJarById(jarId);
    if (jar != null && jar.budget > 0) {
      final ratio = jar.spent / jar.budget;
      if (ratio >= 0.8 && ratio < 1.0) {
        _insights.insert(
          0,
          InsightModel(
            id: 'ins_alert_${DateTime.now().millisecondsSinceEpoch}',
            title: 'Hũ ${jar.name} đã dùng ${(ratio * 100).toInt()}%',
            description: 'Hãy cân đối chi tiêu để không vượt ngân sách tháng này.',
            type: InsightType.alert,
            icon: Icons.warning_amber_rounded,
            createdAt: DateTime.now(),
          ),
        );
      }
    }
  }

  Map<String, double> get categoryBreakdown {
    final map = <String, double>{};
    for (final exp in _expenses) {
      map[exp.categoryId] = (map[exp.categoryId] ?? 0.0) + exp.amount;
    }
    return map;
  }

  List<MapEntry<String, double>> get topMerchants {
    final map = <String, double>{};
    for (final exp in _expenses) {
      map[exp.merchant] = (map[exp.merchant] ?? 0.0) + exp.amount;
    }
    final entries = map.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries;
  }

  List<ShoppingItemModel> get allPurchasedItems {
    final items = <ShoppingItemModel>[];
    for (final exp in _expenses) {
      if (exp.items.isNotEmpty) {
        items.addAll(exp.items);
      }
    }
    return items;
  }
}
