import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

import '../models/quote_model.dart';

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  return FavoriteRepository();
});

class FavoriteRepository {
  final supabase = sp.Supabase.instance.client;

  Future<List<Quote>> getFavoriteQuotes(String userId) async {
    try {
      final response = await supabase
          .from('favorites')
          .select('*, quotes!inner(*)')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      debugPrint('Favorite quotes: $response');

      List<Quote> quotes = [];

      for (var quote in response) {
        quotes.add(Quote.fromJson(quote['quotes']));
      }

      return quotes;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> addFavoriteQuote(Quote quote) async {
    final data = {'user_id': quote.userId, 'quote_id': quote.id};

    try {
      await supabase.from('favorites').insert(data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> deleteFavoriteQuote(Quote quote) async {
    final data = {'user_id': quote.userId, 'quote_id': quote.id};

    try {
      await supabase.from('favorites').delete().match(data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  // delete all favorite quotes
  Future<void> deleteAllFavoriteQuotes(String userId) async {
    try {
      await supabase.from('favorites').delete().match({'user_id': userId});
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
