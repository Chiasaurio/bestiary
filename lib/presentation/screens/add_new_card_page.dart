import 'dart:io';

import 'package:animal_collectables/presentation/atomic/molecules/package.dart';
import 'package:animal_collectables/presentation/providers/auth_provider.dart';
import 'package:animal_collectables/presentation/screens/succes_new_card_page.dart';
import 'package:animal_collectables/presentation/theme/colors.dart';
import 'package:animal_collectables/presentation/theme/decoration.dart';
import 'package:animal_collectables/services/firestore_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../services/register_new_animal.dart';
import '../../models/collectable_card_model.dart';
import '../atomic/atoms/package.dart';
import '../theme/fonts.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({
    super.key,
  });

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  XFile? _camera;
  CollectableCardModel? model;
  CollectableCardFirebaseModel? repeatedCard;
  bool isRepeated = false;
  final ValueNotifier<bool> _isAddingNewImage = ValueNotifier<bool>(false);

  void _takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? camera = await picker.pickImage(source: ImageSource.camera);
    if (camera != null) {
      setState(() {
        _camera = camera;
      });
    }
  }

  void _uploadPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? camera = await picker.pickImage(source: ImageSource.gallery);
    if (camera != null) {
      setState(() {
        _camera = camera;
      });
    }
  }

  Future<Uint8List> getImageBytes(String imagePath) async {
    ByteData data = await rootBundle.load(imagePath);
    return data.buffer.asUint8List();
  }

  Future<CollectableCardModel?> test() async {
    Uint8List image = await _camera!.readAsBytes();
    final response = await RegisterNewAnimal.getGeminiObject(image);

    //TO DO: verificar si existe la carta;
    repeatedCard = await getExistingCard(
        response.scientificName, context.read<AuthModel>().getUser()!.uid);

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: scaffoldDecoration,
      child: Scaffold(
        // backgroundColor: Colors.grey[300],
        appBar: const AppBarMolecule(),
        body: Center(
          child: _camera == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _iconTakePhoto(),
                    _iconUploadFromGallery(),
                  ],
                )
              : ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    const SizedBox(height: 15),
                    if (_camera != null) _geminiInfo(),
                  ],
                ),
        ),
      ),
    );
  }

  _showRepeatedBody(CollectableCardModel newCard) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "¿This card it's already on your posession, do you want to discard the old one and add the new one?",
            style: pFont,
          ),
          const Text(
            'Antigua',
            style: h2Font,
          ),
          CollectableCardMolecule(
            gemini: repeatedCard!,
            imageFromNetwork: repeatedCard!.imageUrl!,
          ),
          ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('No changes made.'),
                  duration: Duration(seconds: 1),
                ));
                Navigator.of(context).pop();
              },
              child: const Text('Keep')),
          const Text(
            'Nueva',
            style: h2Font,
          ),
          _showNormalBody(newCard)
        ],
      ),
    );
  }

  _showNormalBody(CollectableCardModel newCard) {
    return FutureBuilder<Uint8List>(
        future: _camera!.readAsBytes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                CollectableCardMolecule(
                  gemini: newCard,
                  imageFromBytes: snapshot.data!,
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        _isAddingNewImage.value = true;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Creating your card...'),
                        ));
                        //TO DO: GUARDAR CARTA DOCUMENT IN FIRESTORE
                        final newCard = await addNewCard(model!,
                                context.read<AuthModel>().getUser()!.uid)
                            .then((value) {
                          return value;
                        });
                        //TO DO: UPLOAD IMAGE TO STORAGE
                        if (newCard != null) {
                          if (mounted) {
                            final uid =
                                context.read<AuthModel>().getUser()!.uid;
                            final file = File(_camera!.path);
                            final storageRef = FirebaseStorage.instance.ref();
                            var imageRef = storageRef
                                .child('images/$uid/${_camera!.name}');
                            var uploadTask = imageRef.putFile(file);
                            // Listen for state changes, errors, and completion of the upload.
                            uploadTask.snapshotEvents
                                .listen((TaskSnapshot taskSnapshot) async {
                              switch (taskSnapshot.state) {
                                case TaskState.running:
                                //   final progress = 100.0 *
                                //       (taskSnapshot.bytesTransferred /
                                //           taskSnapshot.totalBytes);
                                //   print("Upload is $progress% complete.");
                                //   break;
                                case TaskState.paused:
                                  //   print("Upload is paused.");
                                  break;
                                case TaskState.canceled:
                                  //   print("Upload was canceled");
                                  break;
                                case TaskState.error:
                                  showError('Error uploading your image');
                                  // Handle unsuccessful uploads
                                  break;
                                case TaskState.success:
                                  //UPDATE CARTA IMAGE URL
                                  final downloadUrl =
                                      await imageRef.getDownloadURL();
                                  await newCard
                                      .update({"image_url": downloadUrl});
                                  //Delete if are repeated cards
                                  if (repeatedCard != null) {
                                    // Create a reference from an HTTPS URL
                                    // Note that in the URL, characters are URL escaped!
                                    final httpsReference = FirebaseStorage
                                        .instance
                                        .refFromURL(repeatedCard!.imageUrl!);
                                    await deleteCard(repeatedCard!.id!);
                                    await httpsReference.delete();
                                    //TO DO: delete also image
                                  }

                                  final newCardObject = await newCard.get();
                                  if (mounted) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      backgroundColor: kGreenColor,
                                      content: Text(
                                          'You have a new photo in your collection.!'),
                                      duration: Duration(seconds: 1),
                                    ));
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SuccessNewCard(
                                              card: CollectableCardFirebaseModel
                                                  .fromJson(
                                                      newCardObject.data()!,
                                                      newCardObject.id))),
                                    );
                                  }
                                  break;
                              }
                            });
                          }
                        }
                      } on FirebaseException catch (e) {
                        print(e);
                      } catch (e) {
                        _isAddingNewImage.value = false;
                        if (mounted) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                'There was an error submiting your card, please save your image and contact support for help.'),
                            duration: Duration(seconds: 1),
                          ));
                        }
                      }
                    },
                    child: _addNewOne()),
              ],
            );
          }
          if (snapshot.hasError) {
            return const Text('Error loading the image');
          }
          return AspectRatio(
            aspectRatio: 3 / 4,
            child: ShimmerAtom(),
          );
        });
  }

  Widget _addNewOne() {
    return ValueListenableBuilder<bool>(
      valueListenable: _isAddingNewImage,
      builder: (context, value, child) {
        if (_isAddingNewImage.value) {
          return SizedBox();
        }
        return const Text('Add new one');
      },
    );
  }

  showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red[200],
      content: Text(error),
      duration: const Duration(seconds: 1),
    ));
  }

  FutureBuilder<CollectableCardModel?> _geminiInfo() {
    return FutureBuilder<CollectableCardModel?>(
      future: test(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Column(
            children: [
              Text(
                '${snapshot.error}',
                textAlign: TextAlign.center,
                style: pFont.copyWith(fontSize: 25),
              ),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _camera = null;
                    });
                  },
                  child: const Text('Try again'))
            ],
          );
        }
        model = snapshot.data!;
        return Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 15, vertical: 15),
          child: Column(
            children: [
              if (repeatedCard != null) _showRepeatedBody(snapshot.data!),
              if (repeatedCard == null) _showNormalBody(snapshot.data!),
            ],
          ),
        );
      },
    );
  }

  _iconTakePhoto() {
    return InkWell(
      onTap: _takePhoto,
      child: Container(
        width: double.infinity,
        height: 180,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: const Column(
          children: [
            Icon(
              Icons.photo_camera_outlined,
              size: 100,
            ),
            Text(
              'Take picture',
              style: h2Font,
            )
          ],
        ),
      ),
    );
  }

  _iconUploadFromGallery() {
    return InkWell(
      onTap: _uploadPhoto,
      child: Container(
        width: double.infinity,
        height: 180,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: const Column(
          children: [
            Icon(
              Icons.photo,
              size: 100,
            ),
            Text(
              'Upload from gallery',
              style: h2Font,
            )
          ],
        ),
      ),
    );
  }
}
