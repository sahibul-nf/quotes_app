import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/quote_model.dart';
import '../repositories/favorite_repository.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteController, AsyncValue<List<Quote>?>>((ref) {
  final repo = ref.watch(favoriteRepositoryProvider);

  const userId = '8e19a942-adc3-4cbd-ae0d-ce4251e0d3e4';

  return FavoriteController(repo)..getFavoriteQuotes(userId);
});

class FavoriteController extends StateNotifier<AsyncValue<List<Quote>?>> {
  FavoriteController(this.favoriteRepository)
      : super(const AsyncValue.data(null));

  final FavoriteRepository favoriteRepository;

  bool isFavorite(Quote quote) {
    return state.value?.any((element) => element.id == quote.id) ?? false;
  }

  Future<void> getFavoriteQuotes(String userId) async {
    state = const AsyncValue.loading();

    final result = await favoriteRepository.getFavoriteQuotes(userId);

    state = AsyncValue.data(result);
  }

  Future<void> addFavoriteQuote(Quote quote) async {
    state = const AsyncValue.loading();

    await favoriteRepository.addFavoriteQuote(quote);

    state = const AsyncValue.data(null);
  }

  Future<void> deleteFavoriteQuote(Quote quote) async {
    state = const AsyncValue.loading();

    await favoriteRepository.deleteFavoriteQuote(quote);

    state = const AsyncValue.data(null);
  }
}
