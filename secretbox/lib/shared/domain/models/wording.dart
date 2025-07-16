import 'package:secretbox/shared/theme/app_strings.dart';

// ignore: constant_identifier_names
enum WordingType {
  TEXT_WELCOME,
  TEXT_SPINNING,
  TEXT_CHOOSE_PRIZE,
  TEXT_WINNING,
}

class Wording {
  final String welcomeText;
  final String spinningText;
  final String choosePrizeText;
  final String winningText;

  String winningFullText(String prize, String username) => winningText
      .replaceAll(AppStrings.prizeIdentifier, prize)
      .replaceAll(AppStrings.usernameIdentifier, username);

  Wording({
    required this.welcomeText,
    required this.spinningText,
    required this.choosePrizeText,
    required this.winningText,
  });

  factory Wording.fromJson(Map<String, dynamic> json) {
    return Wording(
      welcomeText: json['welcome_text'],
      spinningText: json['spinning_text'],
      choosePrizeText: json['choose_prize_text'],
      winningText: json['winning_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'welcome_text': welcomeText,
      'spinning_text': spinningText,
      'choose_prize_text': choosePrizeText,
      'winning_text': winningText,
    };
  }
}
