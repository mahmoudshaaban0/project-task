enum PaymentStatus { pending, approved, rejected }

class PaymentResponseModel {
  const PaymentResponseModel({
    required this.id,
    required this.recipientName,
    required this.amountInFils,
    required this.currency,
    required this.status,
    required this.requestedAt,
    required this.decidedAt,
    required this.reference,
    this.note,
  }) : assert(amountInFils >= 0, 'The amount cannot be negative.'),
       assert(currency != '', 'The currency cannot be empty.'),
       assert(
         status == PaymentStatus.pending
             ? decidedAt == null
             : decidedAt != null,
         'Pending payments cannot have a decision date, and decided payments '
         'must have one.',
       );

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    final decidedAt = json['decidedAt'];
    return PaymentResponseModel(
      id: json['id'] as String,
      recipientName: json['recipientName'] as String,
      amountInFils: json['amountInFils'] as int,
      currency: json['currency'] as String,
      status: PaymentStatus.values.byName(json['status'] as String),
      requestedAt: DateTime.parse(json['requestedAt'] as String),
      decidedAt: decidedAt == null ? null : DateTime.parse(decidedAt as String),
      reference: json['reference'] as String,
      note: json['note'] as String?,
    );
  }

  final String id;
  final String recipientName;
  final int amountInFils;
  final String currency;
  final PaymentStatus status;
  final DateTime requestedAt;
  final DateTime? decidedAt;
  final String reference;
  final String? note;

  bool get isApproved => status == PaymentStatus.approved;

  bool get isAlreadyApprovedOrRejected => status != PaymentStatus.pending;
}
