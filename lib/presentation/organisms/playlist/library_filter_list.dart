import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mqfm_apps/presentation/atoms/playlist/filter_chip.dart';

class LibraryFilterList extends StatelessWidget {
  const LibraryFilterList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const FilterChipAtom(label: 'Playlists'),
          SizedBox(width: 8.w),
          const FilterChipAtom(label: 'Kajian'),
          SizedBox(width: 8.w),
          const FilterChipAtom(label: 'Ustadz'),
        ],
      ),
    );
  }
}
