import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  static final apiKey = dotenv.env['API_KEY'] ?? "";
  final TextEditingController _userInput = TextEditingController();
  final List<Message> _messages = [];
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  Future<void> sendMessage() async {
    final String message = _userInput.text;
    _userInput.clear();
    setState(() {
      //add user message to the chat
      _messages
          .add(Message(isUser: true, message: message, date: DateTime.now()));
    });

    // Send the user input to the bot and wait for the response
    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    setState(() {
      //add bot response to the chat
      _messages.add(Message(
          isUser: false, message: response.text ?? "", date: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            color: const Color.fromARGB(255, 9, 239, 105),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_circle_outline_rounded),
              color: const Color.fromARGB(255, 9, 239, 105),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.send,
              ),
              color: const Color.fromARGB(255, 9, 239, 105),
            )
          ],
          title: const Center(
            child: Text(
              'MyGPT',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 10, 70, 18),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.green, Colors.purple])),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        return Messages(
                            isUser: message.isUser,
                            message: message.message,
                            date: DateFormat('HH:mm').format(message.date));
                      },
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.green, Colors.purple])),
                  // color: const Color.fromARGB(255, 2, 33, 28),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _userInput,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.purple),
                                borderRadius: BorderRadius.circular(50)),
                            label: const Text(
                              'Type your message here',
                              style: TextStyle(
                                  color: Color.fromARGB(253, 255, 255, 255)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: IconButton(
                          icon: const Icon(Icons.send),
                          padding: const EdgeInsets.all(15),
                          iconSize: 30,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            foregroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            shape:
                                const MaterialStatePropertyAll(CircleBorder()),
                          ),
                          onPressed: () {
                            sendMessage();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  const Messages(
      {super.key,
      required this.isUser,
      required this.message,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isUser ? 100 : 10,
        right: isUser ? 10 : 100,
      ),
      decoration: BoxDecoration(
        color: isUser
            ? const Color.fromARGB(255, 9, 48, 79)
            : Colors.grey.shade300,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          bottomLeft: isUser ? const Radius.circular(10) : Radius.zero,
          topRight: const Radius.circular(10),
          bottomRight: isUser ? Radius.zero : const Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
          // Text(
          //   message,
          //   style: TextStyle(color: isUser ? Colors.white : Colors.black),
          // ),
        ],
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;

  final DateTime date;

  Message({
    required this.isUser,
    required this.message,
    required this.date,
  });
}
