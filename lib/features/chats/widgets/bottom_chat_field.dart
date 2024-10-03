import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/common/enums/message_enums.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:whatsapp/core/common/providers/message_reply_provider.dart';
import 'package:whatsapp/core/common/widgets/custom_width.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/core/utils/pick_image_video.dart';
import 'package:whatsapp/features/chats/controller/chat_controller.dart';
import 'package:whatsapp/features/chats/widgets/message_reply_preview.dart';

class BottomChatField extends ConsumerStatefulWidget {
  const BottomChatField({
    super.key,
    required this.receiverUserId,
  });
  final String receiverUserId;

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  final TextEditingController _msgController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isShowingSendButton = false;
  bool isShowingEmogiContainer = false;

  void sendTextMessage() {
    if (isShowingSendButton) {
      ref.read(chatControllerProvider).sendTextMessage(
            context: context,
            msgText: _msgController.text.trim(),
            receiverUserId: widget.receiverUserId,
          );
      setState(() {
        _msgController.text = "";
      });
    }
  }

  void sendFile(File file, MessageEnum messageEnum) {
    ref.read(chatControllerProvider).sendFileMessage(
          context: context,
          file: file,
          receiverUserId: widget.receiverUserId,
          messageEnum: messageEnum,
        );
  }

  void selectVideoFile() async {
    File? video = await pickVideoFromGallery(context);

    if (video != null) {
      sendFile(
        video,
        MessageEnum.video,
      );
    }
  }

  void selectImageFile() async {
    File? image = await pickImageFromGallery(context);

    if (image != null) {
      sendFile(
        image,
        MessageEnum.image,
      );
    }
  }

  hideEmogiContainer() {
    setState(() {
      isShowingEmogiContainer = false;
    });
  }

  showEmogiContainer() {
    setState(() {
      isShowingEmogiContainer = true;
    });
  }

  showKeyboard() => focusNode.requestFocus();
  hideKeyboard() => focusNode.unfocus();

  void toggleEmogiKeyboard() {
    if (isShowingEmogiContainer) {
      showKeyboard();
      hideEmogiContainer();
    } else {
      hideKeyboard();
      showEmogiContainer();
    }
  }

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageReply = ref.watch(messageReplyProvider);
    final isShowingMessageReply = messageReply != null;
    return Column(
      children: [
        isShowingMessageReply ? const MessageReplyPreview() : const SizedBox(),
        Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  onTap: () =>
                      isShowingEmogiContainer ? hideEmogiContainer() : () {},
                  focusNode: focusNode,
                  controller: _msgController,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    prefixIcon: GestureDetector(
                      onTap: toggleEmogiKeyboard,
                      child: const Icon(
                        Icons.emoji_emotions_outlined,
                      ),
                    ),
                    suffixIcon: Container(
                      padding: const EdgeInsets.only(right: 8.0),
                      width: 65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: selectImageFile,
                            child: const Icon(
                              Icons.camera_alt,
                            ),
                          ),
                          const HorizontalSpacer(
                            width: 8.0,
                          ),
                          GestureDetector(
                            onTap: selectVideoFile,
                            child: const Icon(
                              Icons.attach_file,
                            ),
                          ),
                        ],
                      ),
                    ),
                    filled: true,
                    fillColor: AppColor.searchBarColor,
                    border: _inputBorder(),
                    focusedBorder: _inputBorder(),
                  ),
                  onChanged: (val) {
                    if (val.isEmpty) {
                      setState(() {
                        isShowingSendButton = false;
                      });
                    } else {
                      setState(() {
                        isShowingSendButton = true;
                      });
                    }
                  },
                ),
              ),
              const HorizontalSpacer(
                width: 8.0,
              ),
              GestureDetector(
                onTap: sendTextMessage,
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColor.tabColor,
                  child: Icon(
                    !isShowingSendButton ? Icons.mic : Icons.send,
                    size: 22,
                    color: AppColor.textColor,
                  ),
                ),
              )
            ],
          ),
        ),
        isShowingEmogiContainer
            ? SizedBox(
                height: 350,
                child: EmojiPicker(
                  onBackspacePressed: () {
                    if (_msgController.text.isNotEmpty) {
                      _msgController.text = _msgController.text
                          .substring(0, _msgController.text.length - 2);
                    }
                  },
                  onEmojiSelected: (category, emoji) {
                    setState(() {
                      _msgController.text = _msgController.text + emoji.emoji;
                      if (!isShowingSendButton) {
                        isShowingSendButton = true;
                      }
                    });
                  },
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: const BorderSide(color: AppColor.searchBarColor),
    );
  }
}
