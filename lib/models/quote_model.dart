import 'dart:ui';

class Quote {
  final String? id;
  final String userId;
  final String content;
  final String author;
  final String? profession;
  final String? avatar;
  final int backgroundColor;
  final int textColor;
  final double? fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final String fontFamily;

  Quote({
    this.id,
    required this.userId,
    required this.content,
    required this.author,
    this.profession,
    this.avatar,
    required this.backgroundColor,
    required this.textColor,
    required this.fontWeight,
    required this.textAlign,
    required this.fontFamily,
    this.fontSize,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final userId = json['user_id'];
    final content = json['content'];
    final author = json['author'];
    final profession = json['profession'];
    final backgroundColor = json['background_color'];
    final textColor = json['text_color'];
    int fontSize = json['font_size'];
    int fontWeightIndex = json['font_weight'];
    int textAlignIndex = json['text_align'];
    final fontFamily = json['font_family'];

    return Quote(
      id: id,
      userId: userId,
      content: content,
      author: author,
      profession: profession,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontWeight: FontWeight.values[fontWeightIndex],
      fontSize: fontSize.toDouble(),
      textAlign: TextAlign.values[textAlignIndex],
      fontFamily: fontFamily,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'content': content,
      'author': author,
      'profession': profession,
      'background_color': backgroundColor,
      'text_color': textColor,
      'font_size': fontSize?.toInt() ?? 28,
      'font_weight': fontWeight.index,
      'text_align': textAlign.index,
      'font_family': fontFamily,
    };
  }
}
