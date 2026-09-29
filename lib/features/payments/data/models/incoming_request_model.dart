final class IncomingRequestModel {
  const IncomingRequestModel({
    required this.recipientName,
    required this.amountInFils,
    required this.currency,
    required this.note,
  });

  factory IncomingRequestModel.fromJson(Map<String, dynamic> json) {
    return IncomingRequestModel(
      recipientName: json['recipientName'] as String,
      amountInFils: json['amountInFils'] as int,
      currency: json['currency'] as String,
      note: json['note'] as String?,
    );
  }

  final String recipientName;
  final int amountInFils;
  final String currency;
  final String? note;
}
