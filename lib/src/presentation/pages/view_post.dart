import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/post/post_bloc.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/post/post_event.dart';
import 'package:flutter_ecommerc/src/presentation/bloc/post/post_state.dart';
import 'package:flutter_ecommerc/src/presentation/pages/admin_pages/add_post.dart';
import 'package:flutter_ecommerc/src/presentation/pages/admin_pages/update_post.dart';
import 'package:flutter_ecommerc/src/presentation/pages/map.dart';

class ViewPost extends StatefulWidget {
  const ViewPost({super.key});

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostBloc>(context).add(GetPostEvent());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Posts"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddPost()));
              },
              child: const Text("Add")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Map(),
                  ),
                );
              },
              child: const Text("map"))
        ],
      ),
      //  mapController.move(mapController.center, mapController.zoom - 1);
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostStateLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostStateSuccess) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final post = state.data[index];
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdatePost(
                                post: post,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: screenWidth * 0.9,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.black),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  post.body,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 5),
                                // Text(
                                //   post.tags[index],
                                //   style: const TextStyle(
                                //       fontSize: 15,
                                //       fontWeight: FontWeight.bold),
                                //   textAlign: TextAlign.center,
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Row(
                                      children: [
                                        Icon(Icons.thumb_up_alt),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("0"),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Icon(Icons.thumb_down_alt),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('0'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("0"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(Icons.remove_red_eye),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is PostStateErrorState) {
            return Center(
              child: Text("Error: ${state.error}"),
            );
          }
          return Center(child: Text("No posts available."));
        },
      ),
    );
  }
}
