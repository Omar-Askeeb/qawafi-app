import 'package:flutter/material.dart';
import 'package:qawafi_app/features/poet/data/models/poet.dart';
import 'package:qawafi_app/features/poet/presentation/pages/poet_profile_page.dart';

class PoetGrid extends StatelessWidget {
  final List<PoetModel> poets;
  final ScrollController? scrollController;

  PoetGrid({
    super.key,
    required this.poets,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return poets.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "لا يوجد شعراء",
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          )
        : GridView.builder(
            controller: scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // crossAxisSpacing: 10,
              childAspectRatio: 0.95, // Adjust ratio as needed
            ),
            itemCount: poets.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    // onTap: () => context
                    // .read<PoetBloc>()
                    // .add(PoetGoToDetails(poetId: poets[index].poetId)),
                    onTap: () => Navigator.push(
                        context, PoetProfilePage.route(poets[index].poetId)),
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: Image.network(
                          poets[index].imageSrc,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 45,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        poets[index].fullName,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
  }
}
