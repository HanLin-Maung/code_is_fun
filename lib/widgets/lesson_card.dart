import 'package:flutter/material.dart';
import 'package:mobile_education/constants/icons.dart';
import 'package:mobile_education/models/lesson.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        lesson.isPlaying
            ? Image.asset(
                icLearning,
                height: 45,
              )
            : Image.asset(
                icPlayNext,
                height: 45,
              ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lesson.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                lesson.duration,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        lesson.isCompleted
            ? Image.asset(
                icDone,
                height: 30,
              )
            : Image.asset(
                icLock,
                height: 30,
              ),
      ],
    );
  }
}