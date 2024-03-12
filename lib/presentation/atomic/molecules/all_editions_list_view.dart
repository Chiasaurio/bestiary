part of 'package.dart';

class AllEditionsListView extends StatelessWidget {
  const AllEditionsListView({
    required this.cards,
    super.key,
  });

  final List<CollectableCardFirebaseModel> cards;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'ALL YOUR CARDS',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: cards.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final card = cards[index];
              return Padding(
                padding: EdgeInsets.only(right: 12),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    card.imageUrl!,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return ShimmerAtom();
                    },
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
