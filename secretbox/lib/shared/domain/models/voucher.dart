class Voucher {
  final String username;
  final String code;
  final int prizeId;

  Voucher({
    required this.username,
    required this.code,
    required this.prizeId,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      username: json['username'],
      code: json['code'],
      prizeId: json['prize_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'code': code,
      'prize_id': prizeId,
    };
  }
}