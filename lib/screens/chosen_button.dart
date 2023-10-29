import 'package:club_app/screens/search_screen.dart';
import 'package:club_app/screens/select_school.dart';
import 'package:flutter/material.dart';

class ChosenButton extends StatefulWidget {
  const ChosenButton({super.key});

  @override
  State<ChosenButton> createState() => _ChosenButtonState();
}

class _ChosenButtonState extends State<ChosenButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        //     gradient: LinearGradient(colors: [
        //   Color.fromARGB(255, 213, 215, 151),
        //   Color.fromARGB(255, 186, 186, 101),
        //   Color.fromARGB(255, 158, 138, 65)
        // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Search()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * .75, 70)),
                  child: Text(
                    "STUDENT",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * .095,
                        color: Theme.of(context).colorScheme.inverseSurface),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.width * .06,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectSchool()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * .75, 70)),
                  child: Text(
                    "EDUCATOR",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * .095,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
