import 'package:flutter/material.dart';
import 'package:mqfm_apps/controller/audio/audio_controller.dart';
import 'package:mqfm_apps/model/audio/audio_model.dart';
import 'package:mqfm_apps/utils/helpers/log_helper.dart';

class SearchLogic extends ChangeNotifier {
  final AudioController _audioController = AudioController();

  List<Audio> searchResults = [];
  bool isSearching = false;
  bool isLoading = false;
  String? errorMessage;

  void onSearchChanged(String query) {
    if (query.isEmpty) {
      isSearching = false;
      searchResults = [];
      errorMessage = null;
      notifyListeners();
      return;
    }

    isSearching = true;
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    _performSearch(query);
  }

  Future<void> _performSearch(String query) async {
    try {
      LogHelper.info("SearchLogic", "Searching for: $query");
      final response = await _audioController.searchAudios(query);
      searchResults = response.data ?? [];
      isLoading = false;
      LogHelper.success("SearchLogic", "Found ${searchResults.length} results");
      notifyListeners();
    } catch (e, stackTrace) {
      isLoading = false;
      searchResults = [];
      errorMessage = e.toString();
      LogHelper.error("SearchLogic", "Search failed", stackTrace);
      notifyListeners();
    }
  }
}
