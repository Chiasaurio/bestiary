import 'package:animal_collectables/models/collectable_card_model.dart';
import 'package:animal_collectables/presentation/atomic/molecules/package.dart';
import 'package:animal_collectables/presentation/providers/auth_provider.dart';
import 'package:animal_collectables/presentation/theme/fonts.dart';
import 'package:animal_collectables/presentation/theme/layouts/main_layout.dart';
import 'package:animal_collectables/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../atomic/atoms/package.dart';

class MyStatsPage extends StatelessWidget {
  const MyStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        appBar: const AppBarMolecule(
          text: 'My stats',
        ),
        body: FutureBuilder<List<CollectableCardFirebaseModel>>(
            future: getUserCards(context.read<AuthModel>().getUser()!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final card = snapshot.data![index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${index + 1}.',
                            style: h2Font,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 150,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                card.imageUrl!,
                                fit: BoxFit.contain,
                                alignment: Alignment.topCenter,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return ShimmerAtom();
                                },
                              ),
                            ),
                          ),
                          _statsOfCard(card.scientificName),
                        ],
                      );
                    },
                  );
                }
                return Center(
                  child: Text(
                    "You don't have any cards yet",
                    style: pFont.copyWith(fontSize: 20),
                  ),
                );
              }
              return const SizedBox();
            }),
      ),
    );
  }

  Widget _statsOfCard(String scientificName) {
    return FutureBuilder<int>(
        future: getStatsOfCard(scientificName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            return Expanded(
              child: Column(
                children: [Text('Persons with this card: ${snapshot.data!}')],
              ),
            );
          }
          return const SizedBox();
        });
  }
}
