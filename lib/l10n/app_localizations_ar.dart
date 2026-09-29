// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get home => 'الرئيسية';

  @override
  String get payments => 'المدفوعات';

  @override
  String get thisMonth => 'هذا الشهر';

  @override
  String get total => 'الإجمالي';

  @override
  String get paymentsCount => 'المدفوعات';

  @override
  String get recent => 'الأحدث';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get statusApproved => 'مقبولة';

  @override
  String get statusRejected => 'مرفوضة';

  @override
  String get noRecentPayments =>
      'لا توجد مدفوعات بعد. ستظهر هنا الطلبات التي تقبلها أو ترفضها.';

  @override
  String get paymentDetails => 'تفاصيل الدفعة';

  @override
  String get paymentNotAvailable =>
      'هذه الدفعة غير متاحة. ربما لا تزال بانتظار قرارك.';

  @override
  String paymentTileSemantics(String name, String amount, String status) {
    return '$name، $amount، $status';
  }

  @override
  String get approvePayment => 'هل تريد الموافقة على هذه الدفعة؟';

  @override
  String get recipient => 'المستفيد';

  @override
  String get amount => 'المبلغ';

  @override
  String get reference => 'المرجع';

  @override
  String get reviewBeforeApproval => 'راجع المستفيد والمبلغ قبل الموافقة.';

  @override
  String get authenticateToReveal =>
      'تحقق من هويتك لإظهار المستفيد والمبلغ بالكامل.';

  @override
  String get approvalFailed =>
      'تعذر إكمال هذه الخطوة. حاول مجددًا أو ارفض الطلب.';

  @override
  String get approve => 'موافقة';

  @override
  String get reject => 'رفض';

  @override
  String get revealDetails => 'تحقق لإظهار التفاصيل';

  @override
  String get newPaymentRequest => 'طلب دفعة جديد · اسحب للتحريك';

  @override
  String get requestFailed => 'تعذر إنشاء الطلب. حاول مجددًا.';

  @override
  String get date => 'التاريخ';

  @override
  String get note => 'ملاحظة';

  @override
  String get noNote => 'لا توجد ملاحظة';
}
