import 'package:flutter/material.dart';
import 'package:mobile_education/constants/color.dart';
import 'package:mobile_education/models/course.dart';
import 'package:mobile_education/screens/details_screen.dart';

class CourseContainer extends StatelessWidget {
  const CourseContainer({super.key, required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(
          title: course.name,
        )));
        
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                course.thumbnail,
                height: 60,
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course.name),
                Text(
                  'Author ${course.author}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 5,),
                LinearProgressIndicator(
                  value: course.completedPercentage,
                  backgroundColor: Colors.black12,
                  color: kPrimaryColor,
                )
              ],)
            ),
          ],
        ),
      ),
    );
  }
}