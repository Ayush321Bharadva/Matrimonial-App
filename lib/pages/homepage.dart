import 'package:flutter/material.dart';
import 'package:myproject/drawer/header_drawer.dart';
import 'package:myproject/pages/about_us.dart';
import 'package:myproject/pages/add_user.dart';
import 'package:myproject/pages/dashboard.dart';
import 'package:myproject/pages/favourites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSectons.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;

    if (currentPage == DrawerSectons.dashboard) {
      container = const Dashboard();
    } else if (currentPage == DrawerSectons.adduser) {
      container = const AddUser();
    } else if (currentPage == DrawerSectons.favourites) {
      container = const FavouritesPage(allUsers: [],);
    } else if (currentPage == DrawerSectons.aboutUs) {
      container = const AboutUs();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Matrimony'),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderDrawer(),
              DrawerList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget DrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        //it will display the list of menu drawer
        children: [
          MenuItem(1, 'Dashboard', Icons.dashboard,
              currentPage == DrawerSectons.dashboard ? true : false),
          MenuItem(2, 'Add User', Icons.add_circle,
              currentPage == DrawerSectons.adduser ? true : false),
          MenuItem(3, 'Favourites', Icons.favorite,
              currentPage == DrawerSectons.favourites ? true : false),
          const Divider(
            thickness: 1.5,
            indent: 15,
            endIndent: 15,
          ),
          MenuItem(4, 'About Us', Icons.sticky_note_2_sharp,
              currentPage == DrawerSectons.aboutUs ? true : false),
        ],
      ),
    );
  }

  Widget MenuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[200] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSectons.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSectons.adduser;
            } else if (id == 3) {
              currentPage = DrawerSectons.favourites;
            } else if (id == 4) {
              currentPage = DrawerSectons.aboutUs;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSectons {
  dashboard,
  adduser,
  favourites,
  aboutUs,
}
