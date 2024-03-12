import 'package:animal_collectables/models/collectable_card_model.dart';
import 'package:animal_collectables/presentation/atomic/molecules/package.dart';
import 'package:animal_collectables/presentation/screens/my_cards_page.dart';
import 'package:animal_collectables/presentation/theme/decoration.dart';
import 'package:animal_collectables/presentation/theme/fonts.dart';
import 'package:flutter/material.dart';

class SuccessNewCard extends StatelessWidget {
  const SuccessNewCard({super.key, required this.card});
  final CollectableCardFirebaseModel card;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: scaffoldDecoration,
      child: Scaffold(
        appBar: const AppBarMolecule(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text(
                  'Congratulations, you now have a new unique card in your collection',
                  textAlign: TextAlign.center,
                  style: h2Font,
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyCardsPage()),
                        );
                      },
                      child: const Text('Go to my collection')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
