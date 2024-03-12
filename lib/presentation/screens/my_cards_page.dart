import 'package:animal_collectables/models/collectable_card_model.dart';
import 'package:animal_collectables/presentation/atomic/molecules/package.dart';
import 'package:animal_collectables/presentation/providers/auth_provider.dart';
import 'package:animal_collectables/presentation/theme/decoration.dart';
import 'package:animal_collectables/presentation/theme/fonts.dart';
import 'package:animal_collectables/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../organisms/package.dart';

class MyCardsPage extends StatefulWidget {
  const MyCardsPage({super.key});

  @override
  State<MyCardsPage> createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: scaffoldDecoration,
      child: Scaffold(
        appBar: const AppBarMolecule(),
        body: FutureBuilder<List<CollectableCardFirebaseModel>>(
            future: getUserCards(context.read<AuthModel>().getUser()!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  return _body(snapshot.data!);
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

  Widget _body(List<CollectableCardFirebaseModel> cards) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Expanded(
          child: InfiniteDragableSlider(
            cards: cards,
          ),
        ),
        const SizedBox(height: 72),
        SizedBox(
          height: 140,
          child: AllEditionsListView(cards: cards),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
