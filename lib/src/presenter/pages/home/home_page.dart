import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizard_guide/src/core/constants/icon_routes.dart';
import 'package:wizard_guide/src/presenter/pages/login/login.dart';
import 'package:wizard_guide/src/presenter/pages/profile/profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _DrawerWidget(),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text('Wizard Guide'),
      ),
      body: PageView(
        children: [
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.green,
          ),
        ],
      ),
      bottomNavigationBar: const _BottomBarWidget(),
    );
  }
}

class _BottomBarWidget extends StatelessWidget {
  const _BottomBarWidget();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Pendientes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rule_rounded),
          label: 'En progreso',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist_rtl_rounded),
          label: 'Terminadas',
        ),
      ],
      currentIndex: 0,
      selectedItemColor: Colors.amber[800],
      onTap: (value) {},
    );
  }
}

class _DrawerWidget extends StatelessWidget {
  const _DrawerWidget();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                      // gradient: LinearGradient(
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      //   colors: [
                      //     Color(0xFF1A3E6D),
                      //     // Colors.white
                      //     Color(0xffF2F3FB),
                      //     // Color(0xffF17A24),
                      //   ],
                      // ),
                      ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(IconRoutes.manPNG),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'example@example.com',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              '0000-0000',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Perfil'),
                  onTap: () => Get.to(
                    () => const ProfilePage(),
                    binding: ProfileBinding(),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app_rounded),
                  title: const Text('Cerrar sesión'),
                  onTap: () => Get.offAll(
                    () => const LoginPage(),
                    binding: LoginBinding(),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Text(
              'version App',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
