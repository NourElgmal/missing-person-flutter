import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:missing/bloc/cubit.dart';
import 'package:missing/widget/url.dart';
import 'package:flutter/material.dart';
import 'package:missing/generated/l10n.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Myuploads extends StatefulWidget {
  @override
  State<Myuploads> createState() => _MyuploadsState();
}

class _MyuploadsState extends State<Myuploads> {
  List<Map<String, dynamic>> img_arr = [];
  Future<void> getallimg(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse(Url.serverlink + Url.get_my_img),
        headers: {
          'Content-Type': 'application/json',
          'token': MyCubit.get(context).token,
        },
      );

      log("Response Status Code: ${response.statusCode}");

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

  Future<void> _deleteItem(String id) async {
    try {
      final response = await http.delete(
        Uri.parse(Url.serverlink + Url.delete_img + id),
        headers: {
          'Content-Type': 'application/json',
          'token': MyCubit.get(context).token,
        },
      );
      if (response.statusCode == 200) {
        _showError(context, S.of(context).Image_deleted, () {
          getallimg(context);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _showErrorDialog(BuildContext context, String message, Function f) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: S.of(context).Info,
      desc: message,
      btnOkText: S.of(context).Ok,
      btnCancelText: S.of(context).Cancel,
      btnOkOnPress: () => f(),
      btnCancelOnPress: () {},
    ).show();
  }

  void _showError(BuildContext context, String message, Function f) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: S.of(context).Info,
      btnOkText: S.of(context).Ok,
      btnCancelText: S.of(context).Cancel,
      desc: message,
      btnOkOnPress: () => f(),
    ).show();
  }

  @override
  void initState() {
    super.initState();
    getallimg(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).MyUploads),
      ),
      body: Center(
          child: Container(
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
                        padding:
                            EdgeInsets.symmetric(horizontal: screenwidth * .02),
                      ),
                      Container(
                        child: Image.network(
                          img_arr[index]["img_url_full"],
                          width: MediaQuery.of(context).size.width * .2,
                        ),
                      ),
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
                                    onPressed: () {},
                                    color: Colors.purple,
                                    child: Text(
                                      S.of(context).ShowInformation,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Lexend",
                                          fontSize: screenHeight * .03),
                                    ),
                                  )
                                : MaterialButton(
                                    onPressed: () {},
                                    color: Colors.red,
                                    child: Text(
                                      S.of(context).Pending,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Lexend",
                                          fontSize: screenHeight * .02),
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
                          width: MediaQuery.of(context).size.width * .2,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _showErrorDialog(
                              context, S.of(context).sure_delete_img, () {
                            _deleteItem(img_arr[index]["_id"]);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
              ],
            );
          },
        ),
      )),
    );
  }
}
