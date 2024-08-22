import 'package:flutter/material.dart';
import 'package:msibbigio/services/favorite_services.dart';
import '../models/character.dart';

class FavoriteProvider with ChangeNotifier {
  final FavoriteService favoriteService;

  FavoriteProvider({required this.favoriteService});

  List<Character> _favorites = [];
  bool _isLoading = false;
  String? _error;

  List<Character> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchFavorites() async {
    _isLoading = true;
    notifyListeners();

    try {
      _favorites = await favoriteService.getFavorites();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addFavorite(Character character) async {
    try {
      await favoriteService.addFavorite(character);
      _favorites.add(character);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> removeFavorite(int id) async {
    try {
      await favoriteService.removeFavorite(id);
      _favorites.removeWhere((character) => character.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
