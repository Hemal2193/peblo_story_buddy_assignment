import 'package:flutter/material.dart';
import 'package:peblo_assignment/utils/app_colors.dart';

class StoryCard extends StatelessWidget {
  final String story;

  const StoryCard({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          story,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
