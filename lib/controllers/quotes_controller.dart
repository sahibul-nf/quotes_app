import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_app/models/quotable_model.dart';
import 'package:quotes_app/repositories/quotes_repository.dart';

final quotesProvider = FutureProvider<List<Quotable>>((ref) async {
  final result = await ref.read(quotesRepositoryProvider).getQuotes();

  return result;
});
