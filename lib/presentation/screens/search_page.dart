import 'package:flutter/material.dart';
import 'package:phynd_app/core/utils/app_theme.dart';
import 'package:phynd_app/presentation/layouts/base_layout.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Search',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search games, publishers, or players...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context)
                          .extension<AppTheme>()!
                          .get('primary'),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Search Results
            _buildSection(
              context,
              'Recent Searches',
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) => _buildSearchItem(
                  context,
                  'Search Result ${index + 1}',
                  'Description of search result ${index + 1}',
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Popular Searches
            _buildSection(
              context,
              'Popular Searches',
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  10,
                  (index) => Chip(
                    label: Text('Popular ${index + 1}'),
                    backgroundColor: Theme.of(context)
                        .extension<AppTheme>()!
                        .get('primary')
                        .withOpacity(0.1),
                    labelStyle: TextStyle(
                      color: Theme.of(context)
                          .extension<AppTheme>()!
                          .get('primary'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    Widget content,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).extension<AppTheme>()!.get('text'),
          ),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildSearchItem(
    BuildContext context,
    String title,
    String description,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).extension<AppTheme>()!.get('primary'),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).extension<AppTheme>()!.get('text'),
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            color: Theme.of(context).extension<AppTheme>()!.get('text'),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).extension<AppTheme>()!.get('primary'),
        ),
      ),
    );
  }
}
