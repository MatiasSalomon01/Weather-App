class Condition {
  final String text;
  final String icon;
  final int code;

  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  static Condition empty() {
    return Condition(text: "", icon: "", code: 0);
  }

  factory Condition.fromJson(Map<String, dynamic> map) {
    return Condition(
      text: map['text'],
      icon: map['icon'],
      code: map['code'],
    );
  }
}
