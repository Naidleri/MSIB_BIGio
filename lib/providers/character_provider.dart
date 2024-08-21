import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/rick_and_morty_api.dart';

class CharacterProvider with ChangeNotifier {
  final RickAndMortyApi apiService;

  CharacterProvider({required this.apiService});

  List<Character> _characters = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  bool _hasMore = true;

  List<Character> get characters => _characters;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMore => _hasMore;
  String _searchQuery = '';

  Future<void> fetchCharacters({bool loadMore = false}) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    if (!loadMore) {
      _characters.clear();
      _currentPage = 1;
      _hasMore = true;
    }

    try {
      final newCharacters =
          await apiService.fetchCharacters(page: _currentPage);
      if (newCharacters.isEmpty) {
        _hasMore = false;
      } else {
        _characters.addAll(newCharacters);
        _currentPage++;
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchCharacters(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      fetchCharacters(); 
    } else {
      _characters = _characters.where((character) =>
        character.name.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    fetchCharacters(); 
  }
}
