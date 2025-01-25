import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:missing/Pages/home.dart';
import 'package:missing/bloc/cubit.dart';
import 'package:missing/generated/l10n.dart';
import 'package:missing/widget/url.dart';

class Infopost extends StatefulWidget {
  final String id1;
  final bool similar;
  Infopost({required this.id1, required this.similar});

  @override
  State<Infopost> createState() => _InfopostState();
}

class _InfopostState extends State<Infopost> {
  late Map<String, dynamic> data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    log('${widget.id1} ${widget.similar}');
    infoUserAndChild();
  }

  Future<void> infoUserAndChild() async {
    try {
      final response = await http.get(
        Uri.parse(Url.serverlink + Url.info_user_and_chaild + widget.id1),
        headers: {
          'Content-Type': 'application/json',
          'token': MyCubit.get(context).token,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
          isLoading = false;
        });
      } else {
        log('Error: Failed to fetch data, status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => HomePage(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: screenHeight * .04,
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Image.network(
                                data["img_url_full"],
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Flexible(
                              flex: 1,
                              child: Image.network(
                                widget.similar
                                    ? data["similar_img_url_full"]
                                    : Url.imgsearch,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Center(
                      child: Text(
                        S.of(context).ChildInformation,
                        style: TextStyle(
                          fontSize: screenHeight * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildInfoText(
                        '${S.of(context).Name}: ${data["name"]}', screenHeight),
                    _buildInfoText(
                        '${S.of(context).Age}: ${data["age"]}', screenHeight),
                    _buildInfoText('${S.of(context).Gender}: ${data["gender"]}',
                        screenHeight),
                    SizedBox(height: screenHeight * 0.02),
                    _buildInfoText(
                        '${S.of(context).Status}: ${widget.similar ? S.of(context).LostOrFound : S.of(context).Lost}',
                        screenHeight),
                    SizedBox(height: screenHeight * 0.03),
                    _buildInfoText(
                        '${S.of(context).WhereFindHim}: ${data["Where_find_him"]}',
                        screenHeight),
                    SizedBox(height: screenHeight * 0.02),
                    _buildInfoText(
                        '${S.of(context).WhenFindHim}: ${data["When_find_him"]}',
                        screenHeight),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      S.of(context).OtherPartyInformationFound,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenHeight * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildInfoText(
                        '${S.of(context).Name}: ${data["id_user"]["name"]}',
                        screenHeight),
                    _buildInfoText(
                        '${S.of(context).Phone}: ${data["id_user"]["phone"]}',
                        screenHeight),
                    _buildInfoText(
                        '${S.of(context).Email}: ${data["id_user"]["email"]}',
                        screenHeight),
                    SizedBox(height: screenHeight * 0.03),
                    widget.similar
                        ? _buildAdditionalInfo(screenHeight)
                        : Text(S.of(context).NotFoundYet),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildInfoText(String text, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: screenHeight * 0.03,
        ),
      ),
    );
  }

  Widget _buildAdditionalInfo(double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).OtherPartyInformationMissing,
          style: TextStyle(
            fontSize: screenHeight * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        _buildInfoText(
            '${S.of(context).Name}: ${data["id_user_similar"]["name"]}',
            screenHeight),
        _buildInfoText(
            '${S.of(context).Phone}: ${data["id_user_similar"]["phone"]}',
            screenHeight),
        _buildInfoText(
            '${S.of(context).Email}: ${data["id_user_similar"]["email"]}',
            screenHeight),
      ],
    );
  }
}
