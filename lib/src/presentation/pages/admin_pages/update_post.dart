import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerc/src/data/model/post.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/post/post_bloc.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/post/post_event.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/post/post_state.dart';
import 'package:flutter_ecommerc/src/presentation/pages/view_post.dart';

class UpdatePost extends StatefulWidget {
  final Post post;

  const UpdatePost({super.key, required this.post});

  @override
  State<UpdatePost> createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController tagsController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.post.title);
    descriptionController = TextEditingController(text: widget.post.body);
    tagsController = TextEditingController(text: widget.post.tags.join(', '));
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Post"),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is DeletePostStateSuccess) {
           Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewPost()));
          } else if (state is DeletePostStateErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ));
          }
          if (state is UpdatePostStateSuccess) {
            Navigator.pop(context);
          } else if (state is UpdatePostStateErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          if (state is UpdatePostStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(top: 50),
                width: screenWidth * 0.9,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Title",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: "Description",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: tagsController,
                      decoration: const InputDecoration(
                        labelText: "Tags",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: widget.post.id != null
                          ? () {
                              Post post = Post(
                                id: widget.post.id!,
                                title: titleController.text,
                                body: descriptionController.text,
                                tags: tagsController.text.split(', '),
                                views: 0,
                                userId: 1
                              );

                              BlocProvider.of<PostBloc>(context)
                                  .add(UpdatePostEvent(post.id!, post));
                            }
                          : null,
                      child: const Text("Update"),
                    ),
                    ElevatedButton(
                    
                      onPressed: widget.post.id != null
                          ? () {
                              BlocProvider.of<PostBloc>(context)
                                  .add(DeletePostEvent(widget.post.id!));
                            }
                          : null,
                      child: const Text("delete"),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
