import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/rick_and_morty_api.dart';

class CharacterProvider with ChangeNotifier {
  final RickAndMortyApi apiService;

  CharacterProvider({required this.apiService});

  List<Character> _characters = [];
  bool _isLoading = false;
  String? _error;

  List<Character> get characters => _characters;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCharacters() async {
    _isLoading = true;
    notifyListeners();

    try {
      _characters = await apiService.fetchCharacters();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  
}
