import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  Widget category({
    required IconData icon,
    required String title,
  }) {
    return Container(
      width: 95,
      margin: const EdgeInsets.only(right: 16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              width: 55,
              height: 55,

              decoration: BoxDecoration(
                color: const Color(0xffEAF3FF),
                borderRadius: BorderRadius.circular(18),
              ),

              child: Icon(
                icon,
                size: 30,
                color: const Color(0xff2F80ED),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        const Text(
          "Category",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: Row(
            children: [

              category(
                icon: Icons.medical_services,
                title: "Umum",
              ),

              category(
                icon: Icons.favorite,
                title: "Jantung",
              ),

              category(
                icon: Icons.child_care,
                title: "Anak",
              ),

              category(
                icon: Icons.medical_information,
                title: "Gigi",
              ),

              category(
                icon: Icons.remove_red_eye,
                title: "Mata",
              ),

              category(
                icon: Icons.spa,
                title: "Kulit",
              ),

            ],
          ),
        ),

      ],
    );
  }
}