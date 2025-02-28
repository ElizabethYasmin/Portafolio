import 'package:flutter/material.dart';
import 'package:portafolio_yasmin/utils/user_input.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserInput(
              label: 'Tu Nombre',
              hint: 'Ingrese nombre',
              maxLines: 1,
            ),
            const UserInput(
              label: 'Telefono',
              hint: 'Ingrese telefono',
              maxLines: 1,
            ),
            const UserInput(
              label: 'Correo',
              hint: 'Ingrese correo',
              maxLines: 1,
            ),
            const UserInput(
              label: 'Tema',
              hint: 'Ingrese tema',
              maxLines: 1,
            ),
            const UserInput(
              label: 'Mensaje',
              hint: 'Ingrese',
              maxLines: 3,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Enviar',
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
