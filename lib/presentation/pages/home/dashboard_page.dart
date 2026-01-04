import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/presentation/logic/home/dashboard_logic.dart';
import 'package:mqfm_apps/presentation/molecules/dashboard/quote_card.dart';
import 'package:mqfm_apps/presentation/organisms/dashboard/dashboard_header.dart';
import 'package:mqfm_apps/presentation/organisms/dashboard/horizontal_content_list.dart';
import 'package:mqfm_apps/presentation/organisms/dashboard/menu_grid.dart';
import 'package:mqfm_apps/presentation/organisms/dashboard/vertical_content_list.dart';
import 'package:mqfm_apps/presentation/organisms/navigation/bottom_bar.dart';
import 'package:mqfm_apps/presentation/organisms/profile/sidebar_profile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardLogic logic = DashboardLogic();

  @override
  void dispose() {
    logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const SidebarProfile(),
      body: ListenableBuilder(
        listenable: logic,
        builder: (context, child) {
          return Column(
            children: [
              DashboardHeader(
                categories: logic.categories.map((e) => e.name).toList(),
                selectedIndex: logic.selectedIndex,
                onCategorySelected: logic.selectCategory,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        if (logic.isLoading)
                          const Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: LinearProgressIndicator(color: Colors.green),
                          ),

                        MenuGrid(selectedCategoryId: logic.currentCategoryId),

                        SizedBox(height: 24.h),
                        const QuoteCard(),
                        SizedBox(height: 24.h),

                        HorizontalContentList(
                          selectedCategoryId: logic.currentCategoryId,
                        ),

                        SizedBox(height: 24.h),

                        VerticalContentList(
                          selectedCategoryId: logic.currentCategoryId,
                        ),

                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
