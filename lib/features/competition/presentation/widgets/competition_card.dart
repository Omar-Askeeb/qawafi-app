import 'package:flutter/material.dart';
import '../../domain/entities/competition_entity.dart';
import '../utils/competition_styles.dart';

class CompetitionCard extends StatelessWidget {
  final Competition competition;
  final VoidCallback onTap;

  const CompetitionCard({
    super.key,
    required this.competition,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFEAC578), // اللون الذهبي من الصورة
            width: 0.20, // سُمك الحدود
          ),
          image: DecorationImage(
            image: NetworkImage(
                competition.imageSrc.replaceFirst(':5000', ':5099')),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.darken,
            ),
          ),
        ),
        height: 250,
        child: Stack(
          children: [
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.people, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${competition.totalNumberOfContestant}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: competition.isRunning
                      ? const Color.fromARGB(
                          114, 46, 125, 50) // أو Colors.black38 للشفافية أكثر
                      : Colors.grey.shade800.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(
                      20), // ⬅️ حددت 20 لجعل الحواف دائرية جدًا
                ),
                child: Text(
                  competition.isRunning ? 'مستمر' : 'منتهية',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              right: 12,
              left: 12,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // ← النص الآن إلى اليسار
                children: [
                  Text(
                    competition.competitionName,
                    style: CompetitionStyles.titleStyle,
                    textAlign: TextAlign.left, // ← محاذاة النص إلى اليسار
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${competition.contestantContentResult.length} شاعر',
                    style: CompetitionStyles.subtitleStyle,
                    textAlign: TextAlign.left, // ← محاذاة النص إلى اليسار
                  ),
                ],
              ),
            ),
              Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 140, // ارتفاع التدرج (يمكن تعديله)
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8), // أدنى: أوضح
                      Colors.black.withOpacity(0.10), // أعلى: أخف
                      Colors.transparent, // يختفي تمامًا في الأعلى
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              right: 12,
              left: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .start, // ← النص الآن يظهر على اليمين (بسبب RTL)
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Color(0xFFEAC578),
                    size: 14,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'تاريخ انتهاء المسابقة: ${competition.endDate.day} ${_getMonthName(competition.endDate.month)} ${competition.endDate.year}',
                    style: CompetitionStyles.countdownStyle,
                  ),
                ],
              ),
            ),
          
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر'
    ];
    return months[month - 1];
  }
}
