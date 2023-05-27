import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_app/controllers/user_controller.dart';

import '../models/quote_model.dart';
import '../repositories/favorite_repository.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteController, AsyncValue<List<Quote>?>>((ref) {
  final repo = ref.watch(favoriteRepositoryProvider);
  final userController = ref.watch(userProvider.notifier);

  return FavoriteController(repo, userController)..getFavoriteQuotes();
});

class FavoriteController extends StateNotifier<AsyncValue<List<Quote>?>> {
  FavoriteController(this.favoriteRepository, this.userController)
      : super(const AsyncValue.data(null));

  final FavoriteRepository favoriteRepository;
  final UserController userController;

  bool isFavorite(Quote quote) {
    return state.value?.any((element) => element.id == quote.id) ?? false;
  }

  Future<void> getFavoriteQuotes() async {
    state = const AsyncValue.loading();

    final userId = userController.state!.id;

    final result = await favoriteRepository.getFavoriteQuotes(userId);

    if (mounted) {
      state = AsyncValue.data(result);
    }
  }

  Future<void> toggleFavorite(Quote quote, bool isFavorite) async {
    state = const AsyncValue.loading();

    if (isFavorite) {
      await favoriteRepository.deleteFavoriteQuote(quote);
    } else {
      await favoriteRepository.addFavoriteQuote(quote);
    }

    state = const AsyncValue.data(null);
  }

  // delete all favorite quotes
  Future<void> deleteAllFavoriteQuotes() async {
    state = const AsyncValue.loading();

    final userId = userController.state!.id;
    await favoriteRepository.deleteAllFavoriteQuotes(userId);

    state = const AsyncValue.data(null);
  }
}
