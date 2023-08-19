import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Movie Card'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const Image(
                            image: AssetImage('assets/MarioBros_backdrop.jpg'),
                            colorBlendMode: BlendMode.srcATop,
                          ),
                        ),
                      ),
                      Positioned(
                        child: SafeArea(
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                            onPressed: (){

                            },
                          ),
                        ),
                      ),
                      Positioned(
                        width: MediaQuery.of(context).size.width,
                        bottom: 0,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                                        width: 3.0,
                                      )
                                  ),
                                  child: const Image(
                                    image: AssetImage('assets/MarioBros_poster.jpg'),
                                    width: 150,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Card(
                                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.75),
                                    child: ListTile(
                                      title: const Text('The Super Mario Bros. Movie'),
                                      subtitle: const Text('2023-04-05'),
                                      textColor: Theme.of(context).colorScheme.onBackground,
                                    ),
                                  ),
                                  Card(
                                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.75),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircularPercentIndicator(
                                            radius: 30.0,
                                            lineWidth: 5.0,
                                            percent: 0.78,
                                            center: Text("78%",
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.onBackground,
                                              ),
                                            ),
                                            progressColor: Colors.green,
                                          ),
                                        ),
                                        Center(
                                          child: SizedBox(
                                            width: 150,
                                            child: Text("Animation, Family, Adventure, Fantasy, Comedy",
                                              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                                              //overflow: TextOverflow,
                                            ),
                                          ),
                                        )
                                      ],
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
                ),

                ListTile(
                  title: const Text("Overview",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text("While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi."),
                  textColor: Theme.of(context).colorScheme.background,
                ),
                ListTile(
                  title: Text("Cast",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 1; i < 6; i++)
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                                image: AssetImage('assets/cast/$i.jpg'),
                                width: 150,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                          ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 130,),
              ],
            ),
          ),
        floatingActionButton: const CustomNavigationBar(),
    );
  }
}

class CustomNavigationBar extends StatefulWidget {

  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> with TickerProviderStateMixin{

  var liked = false;
  var saved = false;
  var likes = 0;
  late final AnimationController _likeController;
  late final AnimationController _saveController;

  @override
  void initState(){
    _likeController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _saveController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
  }

  @override void dispose() {
    super.dispose();
    _likeController.dispose();
    _saveController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.2,
          MediaQuery.of(context).size.width * 0.05,
          MediaQuery.of(context).size.width * 0.2,
          MediaQuery.of(context).size.width * 0.05,
      ),
      height: MediaQuery.of(context).size.width * 0.155,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(50)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){
              if(liked){
                _likeController.reverse();
              }else{
                _likeController.forward();
                setState(() {
                  likes++;
                });
              }
              liked = !liked;
            },
            child: Row(
              children: [
                Lottie.network('https://lottie.host/12599446-5481-47c0-b6ac-4b1324b94883/mlyi9sj4LQ.json',
                  height: MediaQuery.of(context).size.width * 0.155,
                  controller: _likeController,
                ),
                Text(likes.toString(),
                style: const TextStyle(
                  color: Colors.grey
                ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              if(saved){
                _saveController.reverse();
              }else{
                _saveController.forward();
              }
              saved = !saved;
            },
            child: Lottie.network("https://lottie.host/b9265d13-57f6-457a-a1cb-1c4c0c1cd7c8/HI5AdRNvbl.json",
              height: MediaQuery.of(context).size.width * 0.155,
              controller: _saveController,
            ),
          ),
        ],
      ),
    );
  }

}