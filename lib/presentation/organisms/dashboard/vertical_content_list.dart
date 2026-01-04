import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mqfm_apps/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/controller/audio/audio_controller.dart';
import 'package:mqfm_apps/model/audio/audio_model.dart';

class VerticalContentList extends StatefulWidget {
  final int selectedCategoryId;

  const VerticalContentList({super.key, required this.selectedCategoryId});

  @override
  State<VerticalContentList> createState() => _VerticalContentListState();
}

class _VerticalContentListState extends State<VerticalContentList> {
  final AudioController _audioController = AudioController();
  List<Audio> _allAudios = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAudios();
  }

  @override
  void didUpdateWidget(VerticalContentList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCategoryId != widget.selectedCategoryId) {
      _fetchAudios();
    }
  }

  Future<void> _fetchAudios() async {
    setState(() => _isLoading = true);
    try {
      final response = await _audioController.getAudiosByCategory(
        widget.selectedCategoryId,
      );
      if (mounted) {
        if (response.status == 200 && response.data != null) {
          setState(() {
            _allAudios = response.data!;
            _isLoading = false;
          });
        } else {
          setState(() {
            _allAudios = [];
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    List<Audio> categoryFiltered = _allAudios;

    if (categoryFiltered.isEmpty) return const SizedBox();

    List<Audio> displayList = List.from(categoryFiltered);
    final now = DateTime.now();
    int seed = (now.year * 10000) + (now.month * 100) + now.day;
    final random = Random(seed);
    displayList.shuffle(random);

    int takeCount = displayList.length < 3 ? displayList.length : 3;
    List<Audio> finalShowList = displayList.take(takeCount).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Di Pilih Oleh Pengguna",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        ListView.separated(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: finalShowList.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final audio = finalShowList[index];
            return Row(
              children: [
                Container(
                  width: 60.r,
                  height: 60.r,
                  decoration: BoxDecoration(
                    color: AppColors.placeholder,
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: (audio.thumbnail.isNotEmpty)
                          ? NetworkImage(audio.thumbnail) as ImageProvider
                          : const AssetImage('assets/images/img_card.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        audio.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        audio.description,
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert, color: Colors.white, size: 24.sp),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
