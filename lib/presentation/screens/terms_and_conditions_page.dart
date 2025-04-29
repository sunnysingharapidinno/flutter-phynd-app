import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/data/models/response/terms_and_conditions_model.dart';
import 'package:phynd_app/data/services/terms_and_conditions_service.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';
import 'package:phynd_app/presentation/widgets/common/loading_indicator.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  final TermsAndConditionsService _service = TermsAndConditionsServiceImpl();
  TermsAndConditions? _termsAndConditions;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchTermsAndConditions();
  }

  Future<void> _fetchTermsAndConditions() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final result = await _service.getTermsAndConditions(contentType: "TC");

      setState(() {
        _termsAndConditions = result;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching terms and conditions: $e');
      setState(() {
        _error =
            'Unable to load terms and conditions.\nPlease check your internet connection and try again.';
        _isLoading = false;
      });
    }
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).extension<AppTheme>()!.get('error'),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchTermsAndConditions,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).extension<AppTheme>()!.get('primary'),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, String content, String contentType) {
    final textColor = Theme.of(context).extension<AppTheme>()!.get('text');

    if (contentType.toUpperCase() == 'TC') {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Html(
          data: content,
          style: {
            "body": Style(
              margin: Margins.zero,
              padding: HtmlPaddings.zero,
              fontSize: FontSize(16),
              lineHeight: LineHeight.number(1.6),
              color: textColor,
            ),
            "p": Style(
              margin: Margins.only(bottom: 16),
              fontSize: FontSize(16),
              lineHeight: LineHeight.number(1.6),
              color: textColor,
            ),
            "li": Style(
              margin: Margins.only(bottom: 8),
              fontSize: FontSize(16),
              lineHeight: LineHeight.number(1.6),
              color: textColor,
            ),
          },
        ),
      );
    }

    return Text(
      content,
      style: TextStyle(
        color: textColor,
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String content,
    String contentType,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).extension<AppTheme>()!.get('text'),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
          ],
          _buildContent(context, content, contentType),
        ],
      ),
    );
  }

  Widget _buildContentView() {
    if (_isLoading) {
      return const Center(child: LoadingIndicator());
    }

    if (_error != null) {
      return _buildErrorView(_error!);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color:
                      Theme.of(context).extension<AppTheme>()!.get('border') ??
                          Colors.grey.shade200,
                  width: 1,
                ),
              ),
            ),
            child: Text(
              'Last updated: ${_termsAndConditions!.lastUpdated}',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Theme.of(context).extension<AppTheme>()!.get('text'),
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildContent(
            context,
            _termsAndConditions!.content,
            'TC',
          ),
          if (_termsAndConditions!.sections.isNotEmpty) ...[
            const SizedBox(height: 24),
            ..._termsAndConditions!.sections.map((section) => _buildSection(
                  context,
                  section.title,
                  section.content,
                  section.contentType,
                )),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Terms & Conditions',
      child: _buildContentView(),
    );
  }
}
