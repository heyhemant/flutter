import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../global.dart';

class DetailsScreen extends StatefulWidget {
  final int id;

  const DetailsScreen({Key key, @required this.id}) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool _showMoreAbout = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, _) => Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: MediaQuery.of(context).size.height / 3,
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(templeInfo[widget.id].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.5),
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: DraggableScrollableSheet(
                  initialChildSize: 2 / 3,
                  minChildSize: 2 / 3,
                  maxChildSize: 1,
                  builder: (context, scrollController) => Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          offset: Offset(0, -3),
                          blurRadius: 5.0,
                        )
                      ],
                    ),
                    child: ListView(
                      controller: scrollController,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${templeInfo[widget.id].name}",
                                    style: Theme.of(context).textTheme.subtitle,
                                  ),
                                  Text(
                                    "${templeInfo[widget.id].type}",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: MyColors.orange,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                                onPressed: (){
                                  launch('${templeInfo[widget.id].mob}');
                                },
                              ),
                            ),
                            SizedBox(width: 15),
                            Container(
                              decoration: BoxDecoration(
                                color: MyColors.darkGreen,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  launch('${templeInfo[widget.id].mail}');
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SmoothStarRating(
                              rating: templeInfo[widget.id].reviews,
                              size: 15,
                              color: MyColors.orange,
                            ),
                            Text("(${templeInfo[0].reviewCount} Reviews)"),
                            Expanded(
                              child: FlatButton(
                                child: FittedBox(
                                  child: Text(
                                    "See all reviews",
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(color: MyColors.blue),
                                  ),
                                ),
                                onPressed: () {

                                },
                              ),
                            )
                          ],
                        ),
                        Text(
                          "About",
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        Wrap(
                          children: <Widget>[
                            Text(
                              "${templeInfo[widget.id].about}",
                              maxLines: _showMoreAbout ? null : 1,
                            ),
                            FlatButton(
                              child: Text(
                                _showMoreAbout ? "See Less" : "See More",
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(color: MyColors.blue),
                              ),
                              onPressed: () {
                                setState(() {
                                  _showMoreAbout = !_showMoreAbout;
                                });
                              },
                            )
                          ],
                        ),
                        Text(
                          "Opening Hours",
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        Row(
                          children: <Widget>[
                            Text("${templeInfo[widget.id].workingHours}"),
                            SizedBox(width: 15),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(9.0),
                                child: Text(
                                  "Open",
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      .copyWith(color: MyColors.darkGreen),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Color(0xffdbf3e8),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Stats",
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        SizedBox(height: 11),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text("${templeInfo[widget.id].bookingCount}",
                                    style: Theme.of(context).textTheme.title),
                                Text(
                                  "Workers",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                    "${templeInfo[widget.id].wasbuild} Years Ago",
                                    style: Theme.of(context).textTheme.title),
                                Text(
                                  "Age",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text("${templeInfo[widget.id].certifications}",
                                    style: Theme.of(context).textTheme.title),
                                Text(
                                  "Was Destroy",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            color: MyColors.blue,
                            child: Text(
                              "Make A Visit",
                              style: Theme.of(context).textTheme.button,
                            ),
                            onPressed: () {
                              launch("${templeInfo[widget.id].sms}");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
_launchcall() async {
  const url = 'tel:+91 8094820068';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
launchemail() async {
  const url = 'mailto:hemantbanjara855@gmail.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}