import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:red_egresados/domain/use_cases/controllers/auth_controller.dart';
import 'package:red_egresados/ui/pages/content/location/location_screen.dart';
import 'package:red_egresados/ui/pages/content/public_offers/public_offers_screen.dart';
import 'package:red_egresados/ui/pages/content/states/states_screen.dart';
import 'package:red_egresados/ui/pages/content/users_offers/users_offers_screen.dart';
import 'package:red_egresados/ui/widgets/appbar.dart';
import 'package:get/get.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ContentPage> {
  int _selectedIndex = 0;
  Widget _content = const StatesScreen();
  final AuthController authController = Get.find<AuthController>();

  // NavBar action
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 1:
          _content = const UsersOffersScreen();
          break;
        case 2:
          _content = const PublicOffersScreen();
          break;
        case 3:
          _content = const LocationScreen();
          break;
        case 4:
          break;
        default:
          _content = const StatesScreen();
      }
    });
  }

  // Creamos un Scaffold que se utiliza para todas las páginas de contenido
  // Sólo definimos una AppBar, y un andamio.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        picUrl: 'https://uifaces.co/our-content/donated/Zh_4oc5l.jpg',
        tile: const Text("Arte en las calles"),
        context: context,
        onSignOff: () {
          authController.authenticated = false;
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _content,
          ),
        ),
      ),
      // Content screen navbar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline_rounded),
            label: 'Estados',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            label: 'Social',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.art_track_outlined),
            label: 'WebArte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place_outlined),
            label: 'Ubicación',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Mensajes',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
