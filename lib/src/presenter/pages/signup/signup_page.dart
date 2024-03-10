import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido a Wizard Guide!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Para poder acceder, necesitamos que completes el siguiente formulario.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 24),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Email'),
                hintText: 'example@example.com',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Teléfono'),
                hintText: '0000-0000',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextField(
              onTap: () => showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              ),
              canRequestFocus: false,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: const Text('Edad'),
                suffixIcon: IconButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                  },
                  icon: const Icon(
                    Icons.calendar_month_rounded,
                  ),
                ),
              ),
              readOnly: true,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              value: ['One', 'Two', 'Three', 'Four'].first,
              onChanged: (String? value) {},
              items:
                  ['One', 'Two', 'Three', 'Four'].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                label: const Text('Contraseña'),
                hintText: '********',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility_off),
                ),
              ),
              obscureText: true,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Confirmar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
