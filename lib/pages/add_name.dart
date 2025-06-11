import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';
class AddName extends StatefulWidget {
  const AddName({super.key});

  @override
  State<AddName> createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  // Creamos un TextEditingController para cada campo
  TextEditingController idController = TextEditingController(text: "");
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController ageController = TextEditingController(text: "");
  TextEditingController phoneController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController addressController = TextEditingController(text: "");
  TextEditingController paymentMethodController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Persona"), // Título más general
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView( // Añadimos SingleChildScrollView para evitar overflow en pantallas pequeñas
        padding: const EdgeInsets.all(16.0), // Agregamos un poco de padding
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el ID',
                labelText: 'ID', // Añadimos labelText para mejor UX
                border: OutlineInputBorder(), // Borde para mejor visualización
              ),
              keyboardType: TextInputType.text, // Tipo de teclado adecuado
            ),
            const SizedBox(height: 10), // Espacio entre campos

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
              keyboardType: TextInputType.number, // Teclado numérico para la edad
            ),
            const SizedBox(height: 10),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                hintText: 'Ingrese número de teléfono',
                labelText: 'Teléfono',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone, // Teclado de teléfono
            ),
            const SizedBox(height: 10),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el correo electrónico',
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress, // Teclado de correo electrónico
            ),
            const SizedBox(height: 10),

            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                hintText: 'Ingrese su domicilio',
                labelText: 'Domicilio',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.streetAddress, // Teclado de dirección
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
            const SizedBox(height: 20), // Espacio antes del botón

            ElevatedButton(
              onPressed: () async {
                // Convertir la edad a int, manejando posibles errores
                int age = int.tryParse(ageController.text) ?? 0; // Si no es un número válido, se establece en 0

                await addpeople(
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
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Es importante liberar los controladores cuando el widget se destruye
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