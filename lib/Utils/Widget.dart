import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'Day.dart';
import 'Dimentions.dart';

class TabLayout extends StatefulWidget {
  var productList;

  TabLayout({Key? key}) : super(key: key);

  @override
  State<TabLayout> createState() => _TabLayoutState();
}

class _TabLayoutState extends State<TabLayout> {
  @override
  void initState() {
    super.initState();
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: TabBar(
              indicator: RectangularIndicator(
                color: Theme.of(context).primaryColor,
                bottomLeftRadius: 100,
                bottomRightRadius: 100,
                topLeftRadius: 100,
                topRightRadius: 100,
              ),
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              tabs: const [
                Tab(text: "1D"),
                Tab(text: "1W"),
                Tab(text: "1M"),
                Tab(text: "6M"),
                Tab(text: "1Y")
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              LineChartWidget(),
              LineChartWidget(),
              LineChartWidget(),
              LineChartWidget(),
              LineChartWidget()
            ],
          ),
        ),
      ),
    );
  }
}

//Details Card
class DetailCard extends StatelessWidget {
  String count;
  String title;
  DetailCard(this.count, this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    height: 50,
                    width: 50,
                    child: SvgPicture.asset(
                      "assets/shipment.svg",
                      height: Dimentions.height50,
                      width: Dimentions.width50,
                    )),
                const SizedBox(width: 10),
                Text(
                  count,
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            Text(
              title,
              style: GoogleFonts.lato(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
