import 'dart:convert';
import 'dart:developer';
import 'package:missing/Pages/infopost.dart';
import 'package:missing/bloc/cubit.dart';
import 'package:flutter/material.dart';
import 'package:missing/Pages/found&missing.dart';
import 'package:missing/generated/l10n.dart';
import 'package:missing/widget/helpwidget.dart';
import 'package:missing/widget/url.dart';
import 'package:missing/widget/popupmenue.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> img_arr = [];
  Future<void> getallimg(BuildContext context) async {
    print(MyCubit.get(context).token);
    try {
      final response = await http.get(
        Uri.parse(Url.serverlink + Url.get_all_img),
        headers: {
          'Content-Type': 'application/json',
          'token': MyCubit.get(context).token,
        },
      );

      log("Response Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isEmpty) {
          throw Exception('No images found');
        }

        setState(() {
          img_arr = data.cast<Map<String, dynamic>>();
        });
      } else {
        log("Error: ${response.body}");
        throw Exception('Failed to load image data');
      }
    } catch (e) {
      log('Error getting image data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getallimg(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          snap: true,
          floating: true,
          collapsedHeight: screenHeight * 0.15,
          leading: PopupMenu.getPopupMenuButton(context),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03),
                    child: Text(
                      S.of(context).Search,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.height * 0.04),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  CustomInputFields.ButtonSin(
                    context,
                    name: S.of(context).MissingChild,
                    color: const Color.fromARGB(255, 166, 75, 182),
                    textColor: Colors.black,
                    onVisibilityToggle: () {
                      final myCubit = MyCubit.get(context);
                      myCubit.changeFoundMissing(S.of(context).Missingor);
                      myCubit
                          .changeWhenFindMissing(S.of(context).when_miss_him);
                      myCubit
                          .changeWhereFindMissing(S.of(context).where_miss_him);
                      print(myCubit.foundOrMissing);
                      print(myCubit.when_find_missing);
                      print(myCubit.where_found_missing);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadImageScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  CustomInputFields.ButtonSin(
                    context,
                    name: S.of(context).FoundChild,
                    color: const Color.fromARGB(255, 166, 75, 182),
                    textColor: Colors.black,
                    onVisibilityToggle: () {
                      MyCubit.get(context)
                          .changeFoundMissing(S.of(context).foundOr);
                      MyCubit.get(context)
                          .changeWhenFindMissing(S.of(context).when_find_him);
                      MyCubit.get(context)
                          .changeWhereFindMissing(S.of(context).where_find_him);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadImageScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03),
                    child: Text(
                      S.of(context).Alerts,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.height * 0.04),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    height: screenHeight * 0.95,
                    child: ListView.builder(
                      itemCount: img_arr.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenwidth * .02)),
                                  Container(
                                      child: Image.network(
                                    img_arr[index]["img_url_full"],
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    (loadingProgress
                                                            .expectedTotalBytes ??
                                                        1)
                                                : null,
                                          ),
                                        );
                                      }
                                    },
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      return Icon(Icons.error,
                                          color: Colors.red);
                                    },
                                  )),
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenwidth * .1),
                                          child: Text(
                                            (img_arr[index]["similar"])
                                                ? S.of(context).Match
                                                : S.of(context).NoMatch,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Lexend",
                                              fontSize: screenHeight * .02,
                                            ),
                                          ),
                                        ),
                                        (img_arr[index]["similar"])
                                            ? MaterialButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Infopost(
                                                                id1: img_arr[
                                                                        index]
                                                                    ["_id"],
                                                                similar: img_arr[
                                                                        index][
                                                                    "similar"])),
                                                  );
                                                },
                                                color: Colors.purple,
                                                child: Text(
                                                  S.of(context).ShowInformation,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "Lexend",
                                                      fontSize:
                                                          screenHeight * .03),
                                                ),
                                              )
                                            : MaterialButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Infopost(
                                                                id1: img_arr[
                                                                        index]
                                                                    ["_id"],
                                                                similar: img_arr[
                                                                        index][
                                                                    "similar"])),
                                                  );
                                                },
                                                color: Colors.red,
                                                child: Text(
                                                  S.of(context).Pending,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "Lexend",
                                                      fontSize:
                                                          screenHeight * .02),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      child: Image.network(
                                    img_arr[index]["similar"]
                                        ? img_arr[index]["similar_img_url_full"]
                                        : Url.imgsearch,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    (loadingProgress
                                                            .expectedTotalBytes ??
                                                        1)
                                                : null,
                                          ),
                                        );
                                      }
                                    },
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      return Icon(Icons.error,
                                          color: Colors.red);
                                    },
                                  ))
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
