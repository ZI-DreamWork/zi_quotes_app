import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zi_quotes_app/core/data/custome_data.dart';

import '../cubit/theme_color_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeColorCubit = context.read<ThemeColorCubit>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.black,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      drawer: Drawer(
        width: size.width / 2,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 120,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Colors'.toUpperCase(),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  CustomeData.colors.length,
                  (index) => _builtAppColor(
                      color: CustomeData.colors[index],
                      func: () {
                        themeColorCubit
                            .changeThemeColor(CustomeData.colors[index]);
                      }),
                ),
              ),
            )
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(40.0), // Add padding around the container
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: CustomeData.quotes.length, // Number of pages
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: const Offset(-2, -2),
                        // color: Colors.white.withOpacity(0.2),
                        color: Theme.of(context)
                            .colorScheme
                            .shadow
                            .withOpacity(0.2),
                      )
                    ],
                  ),
                  child: Center(
                      child: Text(
                    CustomeData.quotes[index],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.saira().copyWith(
                        fontSize: 25,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  )),
                );
              },
            ),
            Positioned(
              left: (size.width / 2) - (50 / 2) - 40,
              bottom: 0,
              child: _builtRandomButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builtAppColor({required Color color, required Function() func}) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 5),
        color: color.withOpacity(0.5),
        child: Row(children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(-2, -2),
                  // color: Colors.white.withOpacity(0.2),
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  GestureDetector _builtRandomButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _pageController.animateToPage(
              Random().nextInt(CustomeData.quotes.length),
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear);
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(2, 2),
              // color: Colors.white.withOpacity(0.1),
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            ),
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(-2, -2),
              // color: Colors.white.withOpacity(0.2),
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            )
          ],
        ),
        child: const Center(
            child: Icon(
          Icons.refresh,
          color: Colors.white,
        )),
      ),
    );
  }
}
