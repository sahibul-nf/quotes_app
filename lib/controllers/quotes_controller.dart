import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_app/models/quotable_model.dart';
import 'package:quotes_app/repositories/quotes_repository.dart';

import '../models/quote_model.dart';

final getQuotesProvider = FutureProvider<List<Quotable>>((ref) async {
  final repo = ref.watch(quotesRepositoryProvider);
  final controller = QuotesController(repo);

  return await controller.getRandomQuotes();
});

final quotesProvider =
    StateNotifierProvider<QuotesController, AsyncValue<List<Quote>?>>((ref) {
  final repo = ref.watch(quotesRepositoryProvider);

  String userId = '8e19a942-adc3-4cbd-ae0d-ce4251e0d3e4';

  return QuotesController(repo)..getQuotesByMe(userId);
});

class QuotesController extends StateNotifier<AsyncValue<List<Quote>?>> {
  QuotesController(this.quotesRepository) : super(const AsyncValue.data(null));

  final QuotesRepository quotesRepository;

  Future<List<Quotable>> getRandomQuotes() async {
    final result = await quotesRepository.getRandomQuotes();

    return result;
  }

  Future<void> createQuote(Quote quote) async {
    await quotesRepository.createQuote(quote);
  }

  Future<void> getQuotesByMe(String userId) async {
    state = const AsyncValue.loading();

    final result = await quotesRepository.getQuotesByMe(userId);

    state = AsyncValue.data(result);
  }
}
