import 'package:flutter/material.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/features/chats/widgets/contact_list.dart';
import 'package:whatsapp/features/chats/widgets/chat_list.dart';

import '../widgets/web_chat_appbar.dart';
import '../widgets/web_profile_bar.dart';
import '../widgets/web_search_bar.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: size * 0.25,
            child: const Column(
              children: [
                WebProfileBar(),
                WebSearchBar(),
                Expanded(child: ContactsList()),
              ],
            ),
          ),
          Container(
            width: size * 0.75,
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(),
              ),
              image: DecorationImage(
                image: AssetImage(
                  "assets/background.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const ChatAppBar(),
                const SizedBox(height: 21),
                const Expanded(
                    child: ChatList(
                  receiverUserId: "",
                )),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(),
                    ),
                    color: AppColor.chatBarMessage,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.attach_file,
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 15,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              // fillColor: searchBarColor,
                              hintText: 'Type a message',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(left: 20),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.mic,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// OutlineInputBorder _border({Color color = AppColor.tabColor}) {
//   return OutlineInputBorder(
//     borderRadius: BorderRadius.circular(12),
//     borderSide: BorderSide(
//       color: color,
//     ),
//   );
// }
