part of 'package.dart';

class CollectableCardMolecule extends StatefulWidget {
  final CollectableCardModel gemini;
  final Uint8List? imageFromBytes;
  final String? imageFromNetwork;
  const CollectableCardMolecule({
    super.key,
    required this.gemini,
    this.imageFromBytes,
    this.imageFromNetwork,
  }) : assert(imageFromBytes != null || imageFromNetwork != null);

  @override
  State<CollectableCardMolecule> createState() =>
      _CollectableCardMoleculeState();
}

class _CollectableCardMoleculeState extends State<CollectableCardMolecule> {
  late bool _showFrontSide;
  late bool _flipXAxis;
  late bool isFlipping;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
    _flipXAxis = true;
    isFlipping = false;
  }

  @override
  Widget build(BuildContext context) {
    return
        // Padding(
        // padding: const EdgeInsets.all(20.0),
        // child:
        _buildFlipAnimation();
    // );
  }

  void _switchCard() async {
    if (!isFlipping) {
      isFlipping = true;
      setState(() {
        _showFrontSide = !_showFrontSide;
      });
      await Future.delayed(const Duration(milliseconds: 1000), () {
        isFlipping = false;
      });
      if (!mounted) return;
      setState(() {});
    }
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 1000),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
        child: _showFrontSide ? _buildFront() : _buildRear(),
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;

        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget _buildFront() {
    return __buildLayout(
      key: const ValueKey(true),
    );
  }

  Widget _buildRear() {
    return __buildLayout(
      key: const ValueKey(false),
    );
  }

  Widget __buildLayout({
    required Key key,
    // required Widget child,
    // required String faceName,
    // required Color backgroundColor,
  }) {
    return Stack(
      key: key,
      children: [
        if (!_showFrontSide)
          ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: darkSlateGray,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _property(
                        'Scientific name',
                      ),
                      _valueOfProperty(
                        widget.gemini.scientificName,
                      ),
                      _property(
                        'Habitat',
                      ),
                      _valueOfProperty(
                        widget.gemini.habitat,
                      ),
                      _property(
                        'Weight',
                      ),
                      _valueOfProperty(
                        widget.gemini.weight.toString(),
                      ),
                      _property(
                        'Sex',
                      ),
                      _valueOfProperty(
                        widget.gemini.sex,
                      ),
                      _property(
                        'Curious information',
                      ),
                      _valueOfProperty(
                        widget.gemini.curiousInformation,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              )),
        if (_showFrontSide) _imageFromNetwork(),
        if (_showFrontSide)
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: darkSlateGray,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0)),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.gemini.scientificName,
                    style: h2Font.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  ClipRRect _imageFromNetwork() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        color: darkSlateGray,
        child: AspectRatio(
          aspectRatio: 3 / 4,
          child: widget.imageFromNetwork != null
              ? Image.network(
                  widget.imageFromNetwork!,
                  fit: BoxFit.fitWidth,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return ShimmerAtom();
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return const Center(
                        child: Text('This image type is not supported'));
                  },
                  // )
                )
              : Image.memory(
                  widget.imageFromBytes!,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return const Center(
                        child: Text('This image type is not supported'));
                  },
                  // )
                ),
        ),
      ),
    );
  }

  Widget _property(String text) {
    return Text(text,
        style: pFontGrey.copyWith(
          fontSize: 20,
        ));
  }

  Widget _valueOfProperty(String? text) {
    return Text(text ?? '???', style: pFontWhite.copyWith(fontSize: 20));
  }

  Widget _checkPictureAndLocation() {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll<Color>(rebeccaPurple.withOpacity(0.8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Check picture and location',
              style: pFontWhite.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20),
              // style: pFont,
            ),
            IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              color: orangePeel,
              iconSize: 30,
              icon: const Icon(
                Icons.place,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
