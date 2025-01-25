import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:missing/Pages/home.dart';
import 'package:missing/Pages/infopost.dart';
import 'package:missing/bloc/bloc_state.dart';
import 'package:missing/bloc/cubit.dart';
import 'package:missing/generated/l10n.dart';
import 'package:missing/widget/helpwidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class UploadImageScreen extends StatefulWidget {
  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  XFile? _imageFile;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  late TextEditingController Where_find_him;
  late TextEditingController Age;
  late TextEditingController name;
  late TextEditingController when_find_him;
  FocusNode focus_Where_find_him = FocusNode();
  FocusNode focus_Age = FocusNode();
  FocusNode focus_name = FocusNode();
  FocusNode focus_when_find_him = FocusNode();

  @override
  void initState() {
    super.initState();
    Where_find_him = TextEditingController();
    Age = TextEditingController();
    name = TextEditingController();
    when_find_him = TextEditingController();
    focus_Where_find_him.addListener(() {
      setState(() {});
    });
    focus_Age.addListener(() {
      setState(() {});
    });
    focus_name.addListener(() {
      setState(() {});
    });
    focus_when_find_him.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    Age.dispose();
    when_find_him.dispose();
    name.dispose();
    when_find_him.dispose();
    focus_when_find_him.dispose();
    focus_Age.dispose();
    focus_Where_find_him.dispose();
    focus_name.dispose();
    super.dispose();
  }

  String token = "";

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  void _showErrorDialog(BuildContext context, String message, Function f) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      btnOkText: S.of(context).Ok,
      btnCancelText: S.of(context).Cancel,
      title: S.of(context).Info,
      desc: message,
      btnOkOnPress: () => f(),
    ).show();
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      _showErrorDialog(context, S.of(context).NoImageSelected, () {
        Navigator.pop(context);
      });
      return;
    }

    if (name.text.isEmpty ||
        Age.text.isEmpty ||
        when_find_him.text.isEmpty ||
        Where_find_him.text.isEmpty) {
      _showErrorDialog(context, S.of(context).FillAllFields, () {
        Navigator.pop(context);
      });
      return;
    }

    try {
      Uint8List imageBytes = await _imageFile!.readAsBytes();

      final Map<String, String> requestData = {
        'name': name.text,
        'age': Age.text,
        'When_find_him': when_find_him.text,
        'gender': MyCubit.get(context).groupValue,
        'Where_find_him': Where_find_him.text,
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:3000/Foundimg'),
      );

      request.headers['token'] = MyCubit.get(context).token;
      request.fields.addAll(requestData);
      request.files.add(
        http.MultipartFile.fromBytes(
          'img',
          imageBytes,
          filename: _imageFile!.name,
        ),
      );

      setState(() {
        _isLoading = true;
      });

      _showErrorDialog(context, S.of(context).Uploading, () {});

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseData);

        Navigator.pop(context);

        if (jsonResponse["message"] == "Image matched") {
          if (jsonResponse["info"] != null && jsonResponse["info"].isNotEmpty) {
            var info = jsonResponse["info"][0];
            if (info["_id"] != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Infopost(
                    id1: info["_id"],
                    similar: true,
                  ),
                ),
              );
              return;
            }
          }
        }
        _showErrorDialog(context, S.of(context).notmatch, () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
          );
        });
      } else {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseData);
        _showErrorDialog(context,
            "${S.of(context).UploadFailed}: ${jsonResponse["message"]}", () {
          Navigator.pop(context);
        });
      }
    } catch (e) {
      _showErrorDialog(context, "${S.of(context).ErrorWhileUploading}: $e", () {
        Navigator.pop(context);
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<MyCubit, BlocState>(
        listener: (context, state) {},
        builder: (context, state) {
          MyCubit cubit = MyCubit.get(context);
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
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "${cubit.foundOrMissing}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: screenHeight * .04),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    if (_imageFile == null)
                      InkWell(
                        onTap: _pickImage,
                        child: Container(
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.09,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context).Upload_Photo,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenHeight * .04),
                              ),
                              SizedBox(
                                width: screenWidth * .02,
                              ),
                              Icon(
                                Icons.file_upload_outlined,
                                size: screenHeight * .07,
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Image.network(
                        _imageFile!.path,
                        height: screenHeight * 0.2,
                        width: screenWidth * 0.6,
                        fit: BoxFit.contain,
                      ),
                    SizedBox(height: screenHeight * 0.04),
                    CustomInputFields.buildTextField(context,
                        controller: name,
                        hint: S.of(context).name,
                        focus: focus_name),
                    SizedBox(height: screenHeight * 0.04),
                    CustomInputFields.buildTextField(
                      context,
                      controller: Age,
                      hint: S.of(context).age,
                      focus: focus_Age,
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    CustomInputFields.buildTextField(
                      context,
                      controller: when_find_him,
                      hint: MyCubit.get(context).when_find_missing,
                      focus: focus_when_find_him,
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    CustomInputFields.buildTextField(
                      context,
                      controller: Where_find_him,
                      hint: MyCubit.get(context).where_found_missing,
                      focus: focus_Where_find_him,
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: 'male',
                          groupValue: cubit.groupValue,
                          onChanged: (value) {
                            cubit.changeGroupValue(value!);
                          },
                        ),
                        Text(S.of(context).Male),
                        Radio<String>(
                          value: 'female',
                          groupValue: cubit.groupValue,
                          onChanged: (value) {
                            cubit.changeGroupValue(value!);
                          },
                        ),
                        Text(S.of(context).Female),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    InkWell(
                      onTap: _isLoading ? null : _uploadImage,
                      child: Container(
                        width: screenWidth * 0.6,
                        height: screenHeight * 0.08,
                        decoration: BoxDecoration(
                          color: _isLoading ? Colors.grey : Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            _isLoading
                                ? S.of(context).Uploading
                                : S.of(context).Upload,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: screenHeight * 0.03),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
