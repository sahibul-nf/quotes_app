import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_app/models/quotable_model.dart';
import 'package:quotes_app/repositories/quotes_repository.dart';

final searchQuotesProvider = StateNotifierProvider.autoDispose<
    SearchQuotesController, AsyncValue<List<Quotable>?>>((ref) {
  final repo = ref.watch(quotesRepositoryProvider);

  return SearchQuotesController(quotesRepository: repo);
});

class SearchQuotesController
    extends StateNotifier<AsyncValue<List<Quotable>?>> {
  SearchQuotesController({required this.quotesRepository})
      : super(const AsyncValue.data(null));

  final QuotesRepository quotesRepository;

  Future<void> searchQuotes(String query) async {
    // set state to loading
    state = const AsyncValue.loading();

    try {
      // get quotes from repository
      final result = await quotesRepository.searchQuotes(query);

      // set state to loaded with data
      state = AsyncValue.data(result);
    } catch (err, stack) {
      // set state to error
      state = AsyncValue.error(err, stack);
    }
  }
}
