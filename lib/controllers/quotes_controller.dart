import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_app/models/quotable_model.dart';
import 'package:quotes_app/repositories/quotes_repository.dart';

final getQuotesProvider = FutureProvider<List<Quotable>>((ref) async {
  final repo = ref.watch(quotesRepositoryProvider);
  final controller = QuotesController(repo);

  return await controller.getQuotes();
});

class QuotesController {
  final QuotesRepository quotesRepository;

  QuotesController(this.quotesRepository);

  Future<List<Quotable>> getQuotes() async {
    final result = await quotesRepository.getQuotes();

    return result;
  }
}
