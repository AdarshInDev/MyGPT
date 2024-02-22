import 'package:chatgpt/ChatPage/chat_page.dart';
import 'package:chatgpt/globals/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.greenBgColor,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            SvgPicture.asset(
              'asset/images/ChatGPT.svg',
              width: 210,
              height: 210,
              color: Colors.white,
            ),
            const SizedBox(
              height: 15,
            ),
            Text('Welcome to MyGPT',
                style: TextStyle(
                    fontSize: 30,
                    color: Appcolor.wordBgColor,
                    fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
                child: Text(
                  'Write your prompt and get your queries removed this is chatgpt in your help Write your prompt and get your queries removed this is chatgpt',
                  style: TextStyle(
                    fontSize: 22,
                    color: Appcolor.wordBgColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 52,
              width: 350,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(
                    Colors.transparent,
                  ),
                  elevation: MaterialStateProperty.all(
                    0,
                  ),
                  shape: const MaterialStatePropertyAll(
                    RoundedRectangleBorder(),
                  ),
                  side: MaterialStatePropertyAll(
                    BorderSide(
                      color: Appcolor.wordBgColor,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatPage(),
                    ),
                  );
                },
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(95, 10, 0, 10),
                      child: Text(
                        'Try MyGPT',
                        style: TextStyle(
                            fontSize: 24,
                            color: Color.fromARGB(255, 230, 117, 181)),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Color.fromARGB(255, 230, 117, 181),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
