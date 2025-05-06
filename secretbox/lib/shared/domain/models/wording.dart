import 'package:secretbox/shared/theme/app_strings.dart';

class Wording {
  final String welcomeText;
  final String spinningText;
  final String choosePrizeText;
  final String winningText;

  String winningFullText(String prize) =>
      winningText.replaceAll(AppStrings.prizeIdentifier, prize);

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