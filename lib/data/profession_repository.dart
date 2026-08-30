import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/profession_model.dart';

/// خطوة واحدة من خطوات "توليد" المهام، تُستخدم لعرض تقدّم العملية للمستخدم.
/// ملاحظة: هذا منطق محلي قائم على قواعد بيانات (rule/dataset-based)،
/// وليس استدعاءً لنموذج ذكاء اصطناعي حي عبر الشبكة. يمكن لاحقاً استبدال
/// [ProfessionRepository.generateTasksStepByStep] باستدعاء API خارجي
/// (مثل نموذج لغوي) إن أردت توليداً ديناميكياً حقيقياً.
class GenerationStep {
  final String label;
  final List<TaskSuggestion>? resultBatch; // غير فارغة فقط في الخطوة الأخيرة

  GenerationStep(this.label, {this.resultBatch});
}

class ProfessionRepository {
  static const String _assetPath = 'assets/data/employee_professions.json';

  List<Profession>? _cache;

  /// تحميل كل المهن من ملف JSON المرفق بالتطبيق (مرة واحدة فقط، ثم تُخزَّن مؤقتاً)
  Future<List<Profession>> loadProfessions() async {
    if (_cache != null) return _cache!;

    final raw = await rootBundle.loadString(_assetPath);
    final Map<String, dynamic> decoded = json.decode(raw);
    final List<dynamic> list = decoded['professions'] ?? [];

    _cache = list.map((p) => Profession.fromJson(p)).toList();
    return _cache!;
  }

  Future<Profession?> getById(String id) async {
    final all = await loadProfessions();
    try {
      return all.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  /// يولّد وصف المهام المناسبة للمهنة المختارة على شكل خطوات متتابعة
  /// (تحليل -> مطابقة -> توليد)، مفيد لعرض تأثير حركي/تدريجي في الواجهة.
  Stream<GenerationStep> generateTasksStepByStep(String professionId) async* {
    final profession = await getById(professionId);
    if (profession == null) {
      yield GenerationStep('تعذر إيجاد بيانات لهذه المهنة');
      return;
    }

    yield GenerationStep('جارٍ تحليل نمط عمل "${profession.nameAr}"...');
    await Future.delayed(const Duration(milliseconds: 500));

    yield GenerationStep('جارٍ مطابقة مهام العمل المناسبة للتخصص...');
    await Future.delayed(const Duration(milliseconds: 500));

    yield GenerationStep('جارٍ تجهيز قائمة المهام المقترحة...');
    await Future.delayed(const Duration(milliseconds: 400));

    yield GenerationStep(
      'تم التوليد بنجاح (${profession.suggestedTasks.length} مهمة مقترحة)',
      resultBatch: profession.suggestedTasks,
    );
  }
}