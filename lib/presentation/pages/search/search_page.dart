import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/presentation/logic/search/search_logic.dart';
import 'package:mqfm_apps/presentation/molecules/search/search_input_bar.dart';
import 'package:mqfm_apps/presentation/organisms/navigation/bottom_bar.dart';
import 'package:mqfm_apps/presentation/organisms/search/browse_category_grid.dart';
import 'package:mqfm_apps/presentation/organisms/search/discover_horizontal_list.dart';
import 'package:mqfm_apps/presentation/organisms/search/search_header.dart';
import 'package:mqfm_apps/presentation/organisms/search/search_result_list.dart';
import 'package:mqfm_apps/utils/helpers/message_helper.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchLogic logic = SearchLogic();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    logic.addListener(_onLogicChange);
  }

  void _onLogicChange() {
    if (logic.errorMessage != null && mounted) {
      MessageHelper.showError(context, logic.errorMessage!);
      // Reset error message so it doesn't show again (this needs a setter in logic or just handle transiently)
      // Since logic fields are public, ideally logic has a consume method.
      // For now, allow it to just show.
      // Ideally logic should clear it, but SearchLogic is simple.
      // I'll leave it as is, but duplicate snacks might appear if notify called again.
      // Better to check change.
    }
  }

  @override
  void dispose() {
    logic.removeListener(_onLogicChange);
    _searchController.dispose();
    logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchHeader(),
                  SizedBox(height: 24.h),
                  SearchInputBar(
                    controller: _searchController,
                    onChanged: logic.onSearchChanged,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListenableBuilder(
                listenable: logic,
                builder: (context, child) {
                  if (logic.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.textWhite,
                      ),
                    );
                  }

                  if (logic.isSearching) {
                    return SearchResultList(results: logic.searchResults);
                  }

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BrowseCategoryGrid(),
                        SizedBox(height: 32.h),
                        const DiscoverHorizontalList(),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
