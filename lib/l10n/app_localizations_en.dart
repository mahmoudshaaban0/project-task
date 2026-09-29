// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get payments => 'Payments';

  @override
  String get thisMonth => 'This month';

  @override
  String get total => 'Total';

  @override
  String get paymentsCount => 'Payments';

  @override
  String get recent => 'Recent';

  @override
  String get seeAll => 'See all';

  @override
  String get statusApproved => 'Approved';

  @override
  String get statusRejected => 'Rejected';

  @override
  String get noRecentPayments =>
      'No payments yet. Requests you approve or reject will appear here.';

  @override
  String get paymentDetails => 'Payment details';

  @override
  String get paymentNotAvailable =>
      'This payment isn\'t available. It may still be waiting for your decision.';

  @override
  String paymentTileSemantics(String name, String amount, String status) {
    return '$name, $amount, $status';
  }

  @override
  String get approvePayment => 'Approve this payment?';

  @override
  String get recipient => 'Recipient';

  @override
  String get amount => 'Amount';

  @override
  String get reference => 'Reference';

  @override
  String get reviewBeforeApproval =>
      'Review the recipient and amount before approving.';

  @override
  String get authenticateToReveal =>
      'Authenticate to reveal the recipient and full amount.';

  @override
  String get approvalFailed =>
      'Unable to complete this step. Please try again or reject the request.';

  @override
  String get approve => 'Approve';

  @override
  String get reject => 'Reject';

  @override
  String get revealDetails => 'Authenticate to reveal';

  @override
  String get newPaymentRequest => 'New payment request · drag to move';

  @override
  String get requestFailed => 'Could not create a request. Please try again.';

  @override
  String get date => 'Date';

  @override
  String get note => 'Note';

  @override
  String get noNote => 'No note provided';
}
