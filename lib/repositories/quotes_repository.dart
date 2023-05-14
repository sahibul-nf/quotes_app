import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:quotes_app/models/quotable_model.dart';
import 'package:quotes_app/utils/api_path.dart';

final quotesRepositoryProvider =
    Provider<QuotesRepository>((ref) => QuotesRepository());

class QuotesRepository {
  
  Future<List<Quotable>> getQuotes() async {
    final response =
        await http.get(Uri.parse('$baseUrl$quotesPath$randomPath?limit=20'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final quotes = (data as List).map((e) => Quotable.fromJson(e)).toList();
      return quotes;
    } else {
      throw Exception('Failed to load quotes');
    }
  }
}
