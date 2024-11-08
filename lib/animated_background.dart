import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class BackgroundAnimation extends StatefulWidget {
  const BackgroundAnimation({super.key});

  @override
  State<BackgroundAnimation> createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimation>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double progress =
        _pageController.hasClients ? (_pageController.page ?? 0) : 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            spawnMaxRadius: 40,
            spawnMinRadius: 15,
            particleCount: 75,
            spawnMinSpeed: 5,
            spawnMaxSpeed: 25,
            spawnOpacity: 0.8,
            baseColor: Colors.blueGrey,
            image: Image(
              image: AssetImage(
                'assets/star.png',
              ),
            ),
          ),
        ),
        vsync: this,
        child:
            FormContainer(pageController: _pageController, progress: progress),
      ),
    );
  }
}

class FormContainer extends StatelessWidget {
  const FormContainer({
    super.key,
    required PageController pageController,
    required this.progress,
  }) : _pageController = pageController;

  final PageController _pageController;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.3),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        height: 400,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                const SizedBox(height: 16),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    children: const [
                      LandingContent(),
                      SignUpForm(),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              height: 56,
              bottom: 40 + progress * 50,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  if (_pageController.page == 0) {
                    _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.ease,
                    );
                  }
                },
                child: ButtonWidget(progress: progress),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//buttons:
class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0.4, 0.8],
          colors: [
            Colors.green,
            Color.fromARGB(255, 32, 62, 33),
          ],
        ),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 92 + progress * 32,
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  FadeTransition(
                    opacity: AlwaysStoppedAnimation(1 - progress),
                    child: const Text("Get Started"),
                  ),
                  FadeTransition(
                    opacity: AlwaysStoppedAnimation(progress),
                    child: const Text(
                      "Create account",
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 24,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create an account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 32, 62, 33),
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 16),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Email address",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 109, 109, 109),
                      ),
                      suffixIcon: Icon(
                        Icons.mail,
                        color: Color.fromARGB(255, 109, 109, 109),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 109, 109, 109),
                      ),
                      suffixIcon: Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 109, 109, 109),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 16),
            const SizedBox(height: 200),
            const Center(
              child: Text(
                "Already have an account? Sign in.",
                style: TextStyle(fontSize: 16, color: Colors.blueGrey),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LandingContent extends StatelessWidget {
  const LandingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Find local \ncommunity events",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 32, 62, 33),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Get involved with what's happening near you.",
            style: TextStyle(
              fontSize: 24,
              color: Color.fromARGB(255, 109, 109, 109),
            ),
          ),
        ],
      ),
    );
  }
}
