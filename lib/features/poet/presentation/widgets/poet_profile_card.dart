import 'package:flutter/material.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';

class PoetProfileCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final int followers;
  final int registrations;
  final VoidCallback onFollow;
  final VoidCallback onUnFollow;
  final bool canFollow;
  final bool isUser;

  PoetProfileCard(
      {required this.imagePath,
      required this.name,
      required this.followers,
      required this.registrations,
      required this.onFollow,
      required this.onUnFollow,
      required this.canFollow,
      required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        // color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: AppPallete.transparentColor,
            // backgroundImage: AssetImage(imagePath),
            child: SizedBox(
              height: 120,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(120),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                _buildInfoBox('متابع', followers),
              ],
            ),
          ),
          if (isUser) ...{
            ElevatedButton(
              onPressed: canFollow ? onFollow : onUnFollow,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPallete.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  // side: const BorderSide(color: AppPallete.whiteColor),
                ),
              ),
              child: Text(
                canFollow ? 'متابعة' : 'إلغاء',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          },
        ],
      ),
    );
  }

  Widget _buildInfoBox(String label, int count) {
    return Row(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
