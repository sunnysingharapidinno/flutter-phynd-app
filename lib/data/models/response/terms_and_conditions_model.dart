import 'package:html_unescape/html_unescape.dart';

class TermsAndConditionsSection {
  final String title;
  final String content;
  final String contentType;

  TermsAndConditionsSection({
    required this.title,
    required this.content,
    required this.contentType,
  });

  factory TermsAndConditionsSection.fromJson(Map<String, dynamic> json) {
    final unescape = HtmlUnescape();
    return TermsAndConditionsSection(
      title: json['title'] as String? ?? '',
      content: unescape.convert(json['content'] as String? ?? ''),
      contentType: json['content_type'] as String? ?? 'TC',
    );
  }
}

class TermsAndConditions {
  final List<TermsAndConditionsSection> sections;
  final String lastUpdated;
  final String content;

  TermsAndConditions({
    required this.sections,
    required this.lastUpdated,
    required this.content,
  });

  factory TermsAndConditions.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['data'] as List? ?? [];
    final unescape = HtmlUnescape();
    return TermsAndConditions(
      sections: data
          .map((section) => TermsAndConditionsSection.fromJson(section))
          .toList(),
      lastUpdated: json['updated_at'] as String? ?? DateTime.now().toString(),
      content: unescape.convert(json['content'] as String? ?? ''),
    );
  }
}
