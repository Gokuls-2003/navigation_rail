import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    Container(
      color: Colors.yellow.shade100,
      alignment: Alignment.center,
      child: Text(
        "Home",
        style: TextStyle(fontSize: 40),
      ),
    ),
    Container(
      color: Colors.pink.shade100,
      alignment: Alignment.center,
      child: Text(
        "profile",
        style: TextStyle(fontSize: 40),
      ),
    ),
    Container(
      color: Colors.purple.shade100,
      alignment: Alignment.center,
      child: Text(
        "Feed",
        style: TextStyle(fontSize: 40),
      ),
    ),
    Container(
      color: Colors.blue.shade100,
      alignment: Alignment.center,
      child: Text(
        "fav",
        style: TextStyle(fontSize: 40),
      ),
    ),
    Container(
      color: Colors.red.shade100,
      alignment: Alignment.center,
      child: Text(
        "setting",
        style: TextStyle(fontSize: 40),
      ),
    )
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Responsive site"),
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.indigoAccent,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.feed), label: "Feed"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "profile"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "setting"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "fav"),
                ])
          : null,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: const [
                // NavigationRailDestination(
                //     icon: Icon(Icons.person), label: Text('person')),
                NavigationRailDestination(
                    icon: Icon(Icons.home), label: Text('Home')),
                NavigationRailDestination(
                    icon: Icon(Icons.feed), label: Text('Feed')),
                NavigationRailDestination(
                    icon: Icon(Icons.favorite), label: Text('Favorites')),
                NavigationRailDestination(
                    icon: Icon(Icons.settings), label: Text('Settings')),
              ],
              selectedIndex: _selectedIndex,
              labelType: NavigationRailLabelType.all,
              selectedLabelTextStyle: const TextStyle(color: Colors.teal),
              unselectedLabelTextStyle: const TextStyle(),
              leading: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person),
                  )
                ],
              ),
            ),
          Expanded(child: _screens[_selectedIndex])
        ],
      ),
    );
  }
}
