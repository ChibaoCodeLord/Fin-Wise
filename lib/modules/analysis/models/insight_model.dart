import 'package:hugeicons/hugeicons.dart';

enum InsightType { alert, tip, positive }

class InsightModel {
  final String id;
  final String title;
  final String description;
  final InsightType type;
  final dynamic icon;
  final DateTime createdAt;

  const InsightModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.icon,
    required this.createdAt,
  });

  static List<InsightModel> get sampleInsights => [
        InsightModel(
          id: 'ins_1',
          title: 'Chi tiêu Ăn uống tăng 21%',
          description: 'So với cùng kỳ tháng trước, bạn đã chi nhiều hơn cho các bữa ăn ngoài và cà phê.',
          type: InsightType.alert,
          icon: HugeIcons.strokeRoundedAnalyticsUp,
          createdAt: DateTime.now(),
        ),
        InsightModel(
          id: 'ins_2',
          title: 'Hũ Mua sắm sắp chạm 85%',
          description: 'Hũ Mua sắm chỉ còn 250.000đ trong khi còn 12 ngày nữa mới hết chu kỳ tháng.',
          type: InsightType.alert,
          icon: HugeIcons.strokeRoundedAlertCircle,
          createdAt: DateTime.now().subtract(const Duration(hours: 4)),
        ),
        InsightModel(
          id: 'ins_3',
          title: 'Tiết kiệm tốt ở Hũ Đi lại',
          description: 'Bạn mới sử dụng 52% ngân sách đi lại, giữ vững phong độ này nhé!',
          type: InsightType.positive,
          icon: HugeIcons.strokeRoundedPiggyBank,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];
}
