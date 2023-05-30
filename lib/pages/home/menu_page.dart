import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/pages/home/homePage.dart';
import 'package:todo/pages/home/profile_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegationModele(),
      child: const Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navegation(),
      ),
    );
  }
}

class _Navegation extends StatelessWidget {
  const _Navegation();

  @override
  Widget build(BuildContext context) {
    final navegationModele = Provider.of<_NavegationModele>(context);
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12), bottom:Radius.circular(12) ),
         child: BottomNavigationBar( 
          backgroundColor: Colors.blue,
          type: BottomNavigationBarType.fixed,
          fixedColor: const Color.fromRGBO(255, 255, 255, 1),
          unselectedLabelStyle:
              const TextStyle(color: Color.fromRGBO(4, 35, 26, 1), fontSize: 14),
          unselectedItemColor: Colors.black,
          currentIndex: navegationModele.pageActual,
          onTap: (i) => navegationModele.pageActual = i,
          items: const [
            BottomNavigationBarItem(
              backgroundColor:  Colors.blue,
              icon: Icon(
                Icons.home,
                size: 32,
              ),
              label: 'Tareas',
            ),
            BottomNavigationBarItem(
              backgroundColor:  Colors.blue,
              icon: Icon(
                Icons.person,
                size: 32,
              ),
              label: 'Perfil',
            ),
           
          ],
        ),
      ),
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages();

  @override
  Widget build(BuildContext context) {
    final navegationModele = Provider.of<_NavegationModele>(context);
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: navegationModele.pageController,
      children:  [
       HomePage(),
       ProfilePage(),
      ],
    );
  }
}

class _NavegationModele with ChangeNotifier {
  int _pageActual = 0;
  final PageController _pageController = PageController();
  int get pageActual => _pageActual;
  set pageActual(int valor) {
     _pageController.animateToPage(
      valor,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
    _pageActual = valor;
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
