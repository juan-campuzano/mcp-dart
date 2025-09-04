import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hooks Example',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HooksExampleScreen(),
    );
  }
}

class HooksExampleScreen extends HookWidget {
  const HooksExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // useState hook - Maneja estado local reactivo
    final counter = useState(0);
    final name = useState('');

    // useTextEditingController hook - Maneja controladores de texto
    final textController = useTextEditingController();

    // useAnimationController hook - Maneja animaciones
    final animationController = useAnimationController(
      duration: const Duration(seconds: 2),
    );

    // useEffect hook - Equivalente a initState, dispose, etc.
    useEffect(() {
      // Se ejecuta cuando el widget se monta
      print('Widget montado');

      // Iniciar animación
      animationController.repeat(reverse: true);

      // Función de limpieza (equivalente a dispose)
      return () {
        print('Widget desmontado');
      };
    }, []); // Lista vacía significa que solo se ejecuta una vez

    // useMemoized hook - Memoriza valores calculados
    final expensiveCalculation = useMemoized(() {
      return counter.value * counter.value * 1000;
    }, [counter.value]);

    // useCallback hook - Memoriza funciones
    final incrementCounter = useCallback(() {
      counter.value++;
    }, []);

    final decrementCounter = useCallback(() {
      if (counter.value > 0) {
        counter.value--;
      }
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Hooks Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ejemplo de useState
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'useState Hook',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Contador: ${counter.value}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: decrementCounter,
                          child: const Icon(Icons.remove),
                        ),
                        ElevatedButton(
                          onPressed: incrementCounter,
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Ejemplo de useMemoized
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'useMemoized Hook',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Cálculo costoso: $expensiveCalculation',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Text(
                      '(contador² × 1000)',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Ejemplo de useTextEditingController
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'useTextEditingController Hook',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: textController,
                      onChanged: (value) => name.value = value,
                      decoration: const InputDecoration(
                        labelText: 'Escribe tu nombre',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      name.value.isEmpty
                          ? 'Hola! Escribe tu nombre arriba'
                          : 'Hola, ${name.value}! 👋',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Ejemplo de useAnimationController
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'useAnimationController Hook',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: AnimatedBuilder(
                        animation: animationController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 0.5 + (animationController.value * 0.5),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.8),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.4),
                                    blurRadius: 20,
                                    spreadRadius:
                                        animationController.value * 10,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Botón para navegar a una segunda pantalla
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondScreen()),
                );
              },
              child: const Text('Ver más ejemplos'),
            ),
          ],
        ),
      ),
    );
  }
}

// Segunda pantalla con más ejemplos de hooks
class SecondScreen extends HookWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // usePageController hook
    final pageController = usePageController();
    final currentPage = useState(0);

    // useScrollController hook
    final scrollController = useScrollController();

    // useFuture hook - Para operaciones asíncronas
    final futureData = useFuture(_loadData());

    // useStream hook - Para streams
    final streamData = useStream(_getTimeStream());

    useEffect(() {
      void listener() {
        final page = pageController.page?.round() ?? 0;
        currentPage.value = page;
      }

      pageController.addListener(listener);
      return () => pageController.removeListener(listener);
    }, [pageController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Más Hooks Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Indicador de página
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage.value == index
                        ? Colors.blue
                        : Colors.grey.withOpacity(0.5),
                  ),
                );
              }),
            ),
          ),

          // PageView con ejemplos
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                // Página 1: useFuture
                _buildFuturePage(futureData),

                // Página 2: useStream
                _buildStreamPage(streamData),

                // Página 3: useScrollController
                _buildScrollPage(scrollController),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFuturePage(AsyncSnapshot<String> futureData) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'useFuture Hook',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Maneja operaciones asíncronas de forma reactiva:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              if (futureData.connectionState == ConnectionState.waiting)
                const Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 8),
                      Text('Cargando datos...'),
                    ],
                  ),
                )
              else if (futureData.hasError)
                Text(
                  'Error: ${futureData.error}',
                  style: const TextStyle(color: Colors.red),
                )
              else
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    futureData.data ?? 'Sin datos',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStreamPage(AsyncSnapshot<DateTime> streamData) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'useStream Hook',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Escucha streams de datos en tiempo real:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 48,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        streamData.hasData
                            ? _formatTime(streamData.data!)
                            : 'Conectando...',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Tiempo en vivo',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScrollPage(ScrollController scrollController) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'useScrollController Hook',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text('${index + 1}'),
                      ),
                      title: Text('Elemento ${index + 1}'),
                      subtitle: Text('Descripción del elemento ${index + 1}'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Simula una operación asíncrona
  Future<String> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Datos cargados exitosamente desde el servidor! 🎉';
  }

  // Crea un stream de tiempo
  Stream<DateTime> _getTimeStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}:'
        '${time.second.toString().padLeft(2, '0')}';
  }
}
