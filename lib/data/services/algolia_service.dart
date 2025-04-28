import 'package:algoliasearch/algoliasearch_lite.dart';
import 'package:phynd_app/config/env.dart';
import 'package:phynd_app/core/enums/algolia_index.dart';

class AlgoliaService {
  final SearchClient _client;

  AlgoliaService()
      : _client = SearchClient(
          appId: Env.algoliaAppId,
          apiKey: Env.algoliaApiKey,
        );

  // SEARCH
  Future<List<Map<String, dynamic>>> search({
    required AlgoliaIndex indexName,
    required String query,
  }) async {
    final queryHits = SearchForHits(
      indexName: indexName.value,
      query: query,
    );
    // Execute the search request.
    final result = await _client.searchIndex(request: queryHits);
    // Print the search hits.

    // final index = _client.index(indexName);
    // final result = await index.search(query).wait();
    return result.hits.map((hit) => hit).toList();
  }
}
