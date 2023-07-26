import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/util/colors.dart';
import 'package:instagram_flutter/widgets/postCard.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: SvgPicture.asset(
            "assets/images/ic_instagram.svg",
            // ignore: deprecated_member_use
            color: primaryColor,
            height: 40,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.message_rounded),
            ),
          ],
        ),
        body: StreamBuilder(
          //! Displaying post from Db
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return PostCard(
                  snap: snapshot.data!.docs[index].data(), 
                );
              },
            );
          },
        ),
      ),
    );
  }
}

//  class PostCard extends StatelessWidget {
  
//   const PostCard({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           //! Stories Section
//           SizedBox(
//             height: 100,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: 30,
//               itemBuilder: (BuildContext context, int index) {
//                 return const Padding(
//                   padding: EdgeInsets.all(8),
//                   child: CircleAvatar(
//                     radius: 37,
//                     backgroundColor: Colors.white,
//                     child: CircleAvatar(
//                       radius: 35,
//                       backgroundImage: NetworkImage(
//                         'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           //!Post Section
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: 10,
//             itemBuilder: (BuildContext context, int index) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 3),
//                 child: SizedBox(
//                   //color: Colors.white,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // poat Header (User profile image and name)
//                       SizedBox(
//                         height: 56,
//                         //color: Colors.yellow,
//                         child: Row(
//                           children: [
//                             const CircleAvatar(
//                               radius: 20,
//                               backgroundColor: Colors.green,
//                             ),
//                             const SizedBox(
//                               width: 8,
//                             ),
//                             const Text(
//                               'Username',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             const Spacer(),
//                             IconButton(
//                               onPressed: () {
//                                 showModalBottomSheet<void>(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return Container(
//                                       decoration: const BoxDecoration(
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(20),
//                                           topRight: Radius.circular(20),
//                                         ),
//                                       ),
//                                       height: 300,
//                                       child: const Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           Text("___"),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                               icon: const Icon(Icons.more_vert),
//                             ),
//                           ],
//                         ),
//                       ),
//                       //! Post Image
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.35,
//                         width: double.infinity,
//                         child: Container(
//                           decoration: const BoxDecoration(
//                             image: DecorationImage(
//                               image: NetworkImage(
//                                   'https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg'),
//                                   fit: BoxFit.cover
//                             ),
//                           ),
//                         ),
//                       ),
//                       //! Post Actions (like, comment, share)
//                       SizedBox(
//                         //color: Colors.cyan,
//                         child: Row(
//                           //mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             IconButton(
//                               onPressed: () {},
//                               icon: const Icon(
//                                 Icons.favorite,
//                                 color: Colors.red,
//                               ),
//                             ),

//                             IconButton(
//                               onPressed: () {},
//                               icon: const Icon(Icons.comment),
//                             ),

//                             IconButton(
//                               onPressed: () {},
//                               icon: const Icon(Icons.send),
//                             ),

//                             //Spacer(),
//                             Expanded(
//                               child: Align(
//                                 alignment: Alignment.bottomRight,
//                                 child: IconButton(
//                                   onPressed: () {},
//                                   icon: const Icon(Icons.bookmark_outline),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       //! Post Likes
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 6),
//                         child: Column(
//                           //mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             DefaultTextStyle(
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .titleSmall!
//                                   .copyWith(fontWeight: FontWeight.w800),
//                               child: Text(
//                                 '1,265 likes',
//                                 style: Theme.of(context).textTheme.bodyMedium,
//                               ),
//                             ),
//                             Container(
//                               width: double.infinity,
//                               padding: const EdgeInsets.only(top: 8),
//                               child: RichText(
//                                 text: const TextSpan(
//                                   style: TextStyle(color: primaryColor),
//                                   children: [
//                                     TextSpan(
//                                         text: 'username',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)),
//                                     TextSpan(
//                                       text:
//                                           '  Hey this is some descrription to be replaced',
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             InkWell(
//                               onTap: () {},
//                               child: Container(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 8),
//                                 child: const Text(
//                                   'View all 201 comments',
//                                   style: TextStyle(
//                                       fontSize: 17, color: secondaryColor),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(vertical: 6),
//                               child: const Text(
//                                 '23/06/2023',
//                                 style: TextStyle(
//                                     fontSize: 15, color: secondaryColor),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
