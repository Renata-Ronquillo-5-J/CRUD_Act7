import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class EditName extends StatefulWidget {
  const EditName({super.key});

  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  // Creamos un TextEditingController para cada campo
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController paymentMethodController = TextEditingController();

  // Variables para almacenar el UID del documento a editar
  String? _uid;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtener los argumentos solo una vez cuando las dependencias cambian
    // Esto es más seguro que en el build, que puede ser llamado múltiples veces
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    // Inicializar los controladores con los datos existentes
    _uid = arguments['uid']; // Guardamos el UID
    idController.text = arguments['id'] ?? '';
    nameController.text = arguments['name'] ?? '';
    ageController.text = (arguments['age'] ?? 0).toString(); // Convertir int a String para TextField
    phoneController.text = arguments['phone'] ?? '';
    emailController.text = arguments['email'] ?? '';
    addressController.text = arguments['address'] ?? '';
    paymentMethodController.text = arguments['paymentMethod'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Persona"), // Título más general
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView( // Añadimos SingleChildScrollView para evitar overflow
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el ID',
                labelText: 'ID',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el nombre',
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: ageController,
              decoration: const InputDecoration(
                hintText: 'Ingrese edad',
                labelText: 'Edad',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                hintText: 'Ingrese número de teléfono',
                labelText: 'Teléfono',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el correo electrónico',
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                hintText: 'Ingrese su domicilio',
                labelText: 'Domicilio',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 10),

            TextField(
              controller: paymentMethodController,
              decoration: const InputDecoration(
                hintText: 'Ingrese forma de pago',
                labelText: 'Forma de Pago',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                // Asegurarse de que _uid no sea nulo antes de usarlo
                if (_uid != null) {
                  // Convertir la edad a int, manejando posibles errores
                  int age = int.tryParse(ageController.text) ?? 0;

                  await updatepeople(
                    _uid!, // Usamos _uid! para afirmar que no es nulo
                    idController.text,
                    nameController.text,
                    age,
                    phoneController.text,
                    emailController.text,
                    addressController.text,
                    paymentMethodController.text,
                  ).then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  // Opcional: mostrar un mensaje de error si el UID es nulo
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Error: No se pudo obtener el UID del documento.")),
                  );
                }
              },
              child: const Text("Actualizar"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Es importante liberar los controladores
    idController.dispose();
    nameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    paymentMethodController.dispose();
    super.dispose();
  }
}