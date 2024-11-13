import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мій інтерективний лічильник',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(), // Головна сторінка додатку
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState(); // стан віджета
}

class MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // змінна тексту
  final TextEditingController _controller = TextEditingController(); 

  void _incrementCounter(String input) {
    setState(() {
      input = input.trim(); // Видаляю пробіли
      if (input == 'Vitalii') {
        _counter = 0;
      } else {
        final int? value = int.tryParse(input); // Перевірка на число
        if (value != null) {
          _counter += value;
        }
      }
      _controller.clear(); // Чистка поля
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Інтерактивне поле вводу'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // тіло проги по центру вирівнюємо
          children: <Widget>[ // далі дочірні віджети
            Text(
              'Лічильник: $_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(16), // Відступи навколо поля вводу
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration( // зчитуємо текст
                  labelText: 'Введіть число або "Vitalii"',
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            ElevatedButton( // обробка тексту
              onPressed: () {
                _incrementCounter(_controller.text);
              },
              child: const Text('Оновити'),
            ),
          ],
        ),
      ),
    );
  }
}
