import 'package:flutter/material.dart';

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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  const Image(
                    image: AssetImage('assets/MarioBros_backdrop.jpg'),
                    colorBlendMode: BlendMode.srcATop,
                  ),
                  SafeArea(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      onPressed: (){

                      },
                    ),
                  ),
                ],
              ),
              Row(
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
                  const Expanded(
                    child: Column(
                      children: [
                        Card(
                          child: ListTile(
                            title: Text('The Super Mario Bros. Movie'),
                            subtitle: Text('2023-04-05'),
                          ),
                        ),
                        Card(
                          
                        )
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
    );
  }
}