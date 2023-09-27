import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:quotes_app/models/quotable_model.dart';
import 'package:quotes_app/models/quote_model.dart';
import 'package:quotes_app/utils/api_path.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

final quotesRepositoryProvider =
    Provider<QuotesRepository>((ref) => QuotesRepository());

class QuotesRepository {
  final supabase = sp.Supabase.instance.client;

  Future<List<Quotable>> getRandomQuotes() async {
    final response = await http.get(
      Uri.parse('$baseUrl$quotesPath$randomPath?limit=20'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load quotes');
    }

    final data = jsonDecode(response.body);

    final quotes = (data as List).map((e) => Quotable.fromJson(e)).toList();
    return quotes;
  }

  Future<List<Quotable>> searchQuotes(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl$searchPath$quotesPath?query=$query'),
    );

    if (response.statusCode != 200) {
      throw "Something went wrong";
    }

    final json = jsonDecode(response.body);
    final data = json['results'] as List;

    final quotes = data.map((e) => Quotable.fromJson(e)).toList();
    return quotes;
  }

  // Create a quote
  Future<void> createQuote(Quote quote) async {
    final data = quote.toJson();

    try {
      await supabase.from('quotes').insert(data);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Get quotes by me
  Future<List<Quote>> getQuotesByMe(String userId) async {
    try {
      final response =
          await supabase.from('quotes').select().eq('user_id', userId);

      debugPrint('Quotes by me: $response');

      List<Quote> quotes = [];

      for (var quote in response) {
        quotes.add(Quote.fromJson(quote));
      }

      return quotes;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // delete a quote
  Future<void> deleteQuote(Quote quote) async {
    try {
      await supabase.from('quotes').delete().eq('id', quote.id);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
