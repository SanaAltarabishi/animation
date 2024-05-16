import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomTextField(),
    );
  }
}
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  // late Color _containerColor;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    //  _containerColor = Color(0xff77C1C1);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
      //    _containerColor = _isFocused ? Colors.white : Color(0xff77C1C1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 77, 86, 86),
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_focusNode);
          },
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 300,
            ),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                  color: _isFocused ? Colors.white : const Color(0xff77C1C1)),
              borderRadius: BorderRadius.circular(19),
              color: _isFocused ? Colors.white : const Color(0xff77C1C1),
            ),
            padding: const EdgeInsets.only(left: 5, top: 2),
            child: TextFormField(
              // showCursor: ,
              cursorColor: const Color(0xff77C1C1),
              focusNode: _focusNode,
              decoration: InputDecoration(
                suffixIcon: _isFocused
                    ? const Icon(
                        Icons.search,
                        color: Color(0xff77C1C1),
                        size: 30,
                      )
                    : SizedBox(
                        width: 20,
                        height: 10,
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xff1B2F6C),
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xff1B2F6C),
                              ),
                            ),
                          ],
                        ),
                      ),
                hintText: _isFocused ? "SEARCH" : "All Projects",
                hintStyle: TextStyle(
                    color: _isFocused ? const Color(0xff77C1C1) : Colors.white,
                    fontSize: 25),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
