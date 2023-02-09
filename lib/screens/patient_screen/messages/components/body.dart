import 'package:safe_rh/constants.dart';
import 'package:safe_rh/models/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:safe_rh/screens/patient_screen/messages/components/message.dart';

import 'chat_input_fields.dart';

class Body extends StatelessWidget {
  const Body();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: ListView.builder(
            itemCount: demeChatMessages.length,
            itemBuilder: (context, index) => Message(message: demeChatMessages[index]),
          ),
        )),
        ChatInputField()
      ],
    );
  }
}
