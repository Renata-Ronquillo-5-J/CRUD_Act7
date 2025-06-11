import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart'; // Asegúrate de que esta ruta sea correcta

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Opcional: una variable para forzar la recarga de datos si es necesario.
  // Pero setState() en el onPressed ya hace que FutureBuilder se reconstruya.
  // Future<List>? _peopleFuture;

  @override
  void initState() {
    super.initState();
    // _peopleFuture = getPeople(); // Puedes inicializarlo aquí si quieres
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clientes"), // Título más descriptivo
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: getpeople(), // Llama a la función para obtener todos los datos
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Asegúrate de que snapshot.data sea una lista de Maps
            final List<Map<String, dynamic>> peopleList =
                List<Map<String, dynamic>>.from(snapshot.data ?? []);

            if (peopleList.isEmpty) {
              return const Center(
                child: Text('No hay personas registradas. ¡Agrega una!'),
              );
            }

            return ListView.builder(
              itemCount: peopleList.length,
              itemBuilder: (context, index) {
                final person = peopleList[index]; // Obtenemos el mapa completo de la persona

                return Dismissible(
                  onDismissed: (direction) async {
                    await deletepeople(person['uid']);
                    // Después de eliminar, recargamos la lista para reflejar los cambios
                    setState(() {
                      // Puedes volver a llamar a getPeople() o simplemente forzar una reconstrucción
                      // _peopleFuture = getPeople();
                    });
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('"${person['name']}" eliminado correctamente')),
                    );
                  },
                  confirmDismiss: (direction) async {
                    bool? result = await showAdaptiveDialog<bool>( // Usar <bool> para tipado
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("¿Estás seguro de eliminar a ${person['name']}?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false); // No eliminar
                                },
                                child: const Text("Cancelar",
                                    style: TextStyle(color: Colors.red))),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true); // Sí, eliminar
                                },
                                child: const Text("Sí, estoy seguro"))
                          ],
                        );
                      },
                    );
                    return result ?? false; // Retorna true si se confirma, false en caso contrario
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight, // Icono a la derecha
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart, // Solo deslizar de derecha a izquierda
                  key: Key(person['uid']), // Asegúrate de que el key sea único
                  child: Card( // Usamos Card para mejorar la presentación de cada elemento
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 4.0, // Sombra para el Card
                    child: ListTile(
                      // Muestra el nombre principal y un subtítulo con otros datos
                      title: Text(
                        person['name'] ?? 'Nombre no disponible',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID: ${person['id'] ?? 'N/A'}'),
                          Text('Edad: ${person['age']?.toString() ?? 'N/A'}'),
                          Text('Teléfono: ${person['phone'] ?? 'N/A'}'),
                          Text('Correo: ${person['email'] ?? 'N/A'}'),
                          Text('Domicilio: ${person['address'] ?? 'N/A'}'),
                          Text('Forma de Pago: ${person['paymentMethod'] ?? 'N/A'}'),
                        ],
                      ),
                      onTap: () async {
                        // ¡IMPORTANTE! Pasa todos los campos a la pantalla de edición
                        await Navigator.pushNamed(
                          context,
                          '/edit',
                          arguments: person, // Pasa el mapa completo de la persona
                        );
                        // Después de volver de la edición, recargamos la lista
                        setState(() {
                          // _peopleFuture = getPeople();
                        });
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar datos: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          // Después de volver de la pantalla de agregar, recargamos la lista
          setState(() {
            // _peopleFuture = getPeople();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}