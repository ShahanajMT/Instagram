import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/Models/resources/firestore_models.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/util/colors.dart';
import 'package:instagram_flutter/util/imagePicker.dart';
import 'package:instagram_flutter/util/snakBar.dart';
import 'package:provider/provider.dart';

import '../../../Models/user_models.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _captionControllers = TextEditingController();
  bool _isLoading = false;

  //
  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        _captionControllers.text,
        _file!,
        uid,
        profImage,
        username,
      );

      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Posted!', context);
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  //Selecting Images
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a Photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);

                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose a Photo from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);

                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _captionControllers.dispose();
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: IconButton(
              onPressed: () => _selectImage(context),
              icon: const Icon(Icons.upload_file_outlined),
            ),
          )
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: mobileBackgroundColor,
                leading: IconButton(
                  onPressed: () => clearImage(),
                  icon: const Icon(Icons.arrow_back),
                ),
                title: const Text('New Post'),
                centerTitle: false,
                actions: [
                  TextButton(
                    onPressed: () => postImage(
                      user.uid,
                      user.username,
                      user.photoUrl,
                    ),
                    child: const Text(
                      'Share',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
                child: Column(
                  children: [
                    _isLoading
                        ? const LinearProgressIndicator()
                        : const Padding(
                            padding: EdgeInsets.only(top: 0),
                          ),
                          const Divider(),
                    Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 75,
                          child: Image(
                            image: MemoryImage(_file!),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextField(
                            controller: _captionControllers,
                            decoration: const InputDecoration(
                              hintText: 'write a caption....',
                              border: InputBorder.none,
                            ),
                            //maxLines: 8,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
