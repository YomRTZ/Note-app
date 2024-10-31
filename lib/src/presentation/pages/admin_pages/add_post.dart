import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ecommerc/src/data/model/post.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/local/local_bloc.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/local/local_event.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/post/post_bloc.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/post/post_event.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/post/post_state.dart';
import 'package:flutter_ecommerc/src/presentation/pages/view_post.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final tagsController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    tagsController.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<PostBloc, PostState>(listener: (context, state) {
      if (state is AddPostStateSuccess) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ViewPost()),
            (route) => false);
      }
      if (state is PostStateErrorState) {
        showLoginErrorDialog(context);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).title),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 50),
                width: screenWidth * 0.9,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                          labelText: "title",
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      controller: bodyController,
                      decoration: InputDecoration(
                          labelText: "description",
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: tagsController,
                      decoration: InputDecoration(
                          labelText: "tags",
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: (){
                         
                          Post post = Post(
                              title: titleController.text,
                              body: bodyController.text,
                              tags: tagsController.text
                                  .split(',')
                                  .map((tag) => tag.trim())
                                  .toList(),
                              views: 0,
                              userId:1);
                          BlocProvider.of<PostBloc>(context)
                              .add(AddPostEvent(post: post));
                        },
                        child: Text("Submit")),
                         ElevatedButton(
              onPressed: () {
                // Dispatching the LocaleChanged event to change to Spanish
                context.read<LocalBloc>().add(LocalChanged(locale: Locale('am', '')));
              },
              child: Text('Change to amharic'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Dispatching the LocaleChanged event to change to English
                context.read<LocalBloc>().add(LocalChanged(locale: Locale('en', '')));
              },
              child: Text('Change to English'),
            ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  void showLoginErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Center(
            child: Text(
              ("Login Error"),
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 230, 8, 8)),
            ),
          ),
          content: const Text(
              "Sorry,your Phone Number or Password is incorrect. please check and try again"),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                // side: const BorderSide(color: TColors.borderPrimary),
              ),
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}
