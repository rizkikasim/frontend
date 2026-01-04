import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/controller/audio/audio_controller.dart';
import 'package:mqfm_apps/model/audio/audio_model.dart';

class MenuGrid extends StatefulWidget {
  final int selectedCategoryId;

  const MenuGrid({super.key, required this.selectedCategoryId});

  @override
  State<MenuGrid> createState() => _MenuGridState();
}

class _MenuGridState extends State<MenuGrid> {
  final AudioController _audioController = AudioController();
  List<Audio> _allAudios = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAudios();
  }

  Future<void> _fetchAudios() async {
    try {
      final response = await _audioController.getAllAudios();
      if (mounted) {
        if (response.status == 200 && response.data != null) {
          setState(() {
            _allAudios = response.data!;
            _isLoading = false;
          });
        } else {
          setState(() => _isLoading = false);
        }
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const SizedBox();

    List<Audio> filteredList = (widget.selectedCategoryId == 0)
        ? _allAudios
        : _allAudios
              .where((e) => e.categoryId == widget.selectedCategoryId)
              .toList();

    int displayCount = filteredList.length > 8 ? 8 : filteredList.length;

    if (filteredList.isEmpty) return const SizedBox();

    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: displayCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 2.8,
      ),
      itemBuilder: (context, index) {
        final audio = filteredList[index];
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Row(
            children: [
              Container(
                width: 45.w,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.placeholder,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.r),
                    bottomLeft: Radius.circular(4.r),
                  ),
                  image: DecorationImage(
                    image: (audio.thumbnail.isNotEmpty)
                        ? NetworkImage(audio.thumbnail) as ImageProvider
                        : const AssetImage('assets/images/img_card.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Text(
                    audio.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
