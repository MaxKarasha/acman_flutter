import 'package:acman_app/widget/aliment.dart';
import 'package:acman_app/widget/card_item.dart';
import 'package:acman_app/widget/page.dart';
import 'package:acman_app/widget/pager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// Import the library.
import 'package:signalr_client/signalr_client.dart';


// The location of the SignalR Server.
final serverUrl = "192.168.10.50:51001";
// Creates the connection by using the HubConnectionBuilder.
final hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();


class PlanningPage extends StatelessWidget {
  PlanningPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Планирование"),
        ),
      body: Container(
        child: RaisedButton(
          onPressed: null,
          child: const Text(
              'ping',
              style: TextStyle(fontSize: 20)
          ),
        ),
      ),
    );
//  return Container(
//    child: MenuPager(
//      children: Aliments.aliments
//          .map(
//            (aliment) => Page(
//          title: "Планирование",
//          background: aliment.background,
//          icon: aliment.bottomImage,
//          child: CardItem(
//            child: AlimentWidget(
//              aliment: aliment,
//              theme: aliment.background,
//            ),
//          ),
//        ),
//      )
//          .toList(),
//    ),
//  );
  }
}
class Aliments {
  static List<Aliment> aliments = [
    Aliment(
        name: "Dunkin Donut",
        background: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [const Color(0xFFFD8183), const Color(0xFFFB425A)],
        ),
        subtitle: "Strawberry Frosted",
        image: "assets/images/donut.svg",
        bottomImage: "assets/images/bottom_donut.svg",
        totalCalories: 420.0,
        runTime: 47.0,
        bikeTime: 45.0,
        swimTime: 41.0,
        workoutTime: 52.0),
    Aliment(
        name: "Burger",
        background: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [const Color(0xFFF8C08E), const Color(0xFFFDA65B)],
        ),
        subtitle: "McDonald's: Big Mac",
        image: "assets/images/burger.svg",
        bottomImage: "assets/images/bottom_burger.svg",
        totalCalories: 560.0,
        runTime: 112.0,
        bikeTime: 69.0,
        swimTime: 61.0,
        workoutTime: 101.0),
    Aliment(
        name: "Ice Cream",
        background: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [const Color(0xFF6CD8F0), const Color(0xFF6AD89D)],
        ),
        subtitle: "Vanilla Ice Cream",
        image: "assets/images/ice_cream.svg",
        bottomImage: "assets/images/bottom_ice_cream.svg",
        totalCalories: 210.0,
        runTime: 36.0,
        bikeTime: 31.0,
        swimTime: 25.0,
        workoutTime: 41.0),
    Aliment(
        name: "Pizza",
        background: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [const Color(0xFFEE0979), const Color(0xFFFF6A00)],
        ),
        subtitle: "Chorizo Pizza",
        image: "assets/images/pizza.svg",
        bottomImage: "assets/images/bottom_pizza.svg",
        totalCalories: 238.0,
        runTime: 40.0,
        bikeTime: 35.0,
        swimTime: 30.0,
        workoutTime: 50.0),
    Aliment(
        name: "Cake",
        background: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [const Color(0xFFFBD3E9), const Color(0xFFBB377D)],
        ),
        subtitle: "Cherry Cake",
        image: "assets/images/cake.svg",
        bottomImage: "assets/images/bottom_cake.svg",
        totalCalories: 195.0,
        runTime: 33.0,
        bikeTime: 29.0,
        swimTime: 24.0,
        workoutTime: 39.0),
  ];
}
class Aliment {
  final String name;
  final LinearGradient background;
  final String subtitle;
  final String image;
  final String bottomImage;
  final double totalCalories;
  final double runTime;
  final double bikeTime;
  final double swimTime;
  final double workoutTime;

  Aliment({ this.name,
    this.background,
    this.subtitle,
    this.image,
    this.bottomImage,
    this.totalCalories,
    this.runTime,
    this.bikeTime,
    this.swimTime,
    this.workoutTime
  });

}