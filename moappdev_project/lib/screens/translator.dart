import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:translator/translator.dart';

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({Key? key}) : super(key: key);

  @override
  _TranslatorPageState createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  Color appColor = const Color.fromRGBO(134, 201, 245, 1);

  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "";

  GoogleTranslator translator = GoogleTranslator();
  var output;
  String? dropdownValue;

  static const Map<String, String> lang = {
    "English": "en",
    "Korean": "ko",
    "Japanese": "ja",
    "Chinese": "zh-cn",
  };

  void trans() {
    translator.translate(scannedText, to: "$dropdownValue").then((value) {
      setState(() {
        output = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: const Text("Translator"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (textScanning) const CircularProgressIndicator(),
              if (!textScanning && imageFile == null)
                Container(
                  width: 300,
                  height: 300,
                  color: Colors.grey[300]!,
                ),
              if (imageFile != null) Image.file(File(imageFile!.path)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.grey,
                          shadowColor: Colors.grey[400],
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                        onPressed: () {
                          getImage(ImageSource.gallery);
                          dropdownValue = null;
                          output = null;
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.image,
                                size: 30,
                              ),
                              Text(
                                "Gallery",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 3.0,
                color: Colors.lightBlue,
              ),
              Row(
                children: const [
                  Text(
                    'Text: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,),
                  ),
                  SizedBox(height: 1,),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                scannedText,
                style: const TextStyle(fontSize: 20),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Select Language here =>",
                        style: TextStyle(fontSize: 17.0, color: Colors.deepPurple),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            trans();
                          });
                        },
                        items: lang
                            .map((string, value) {
                              return MapEntry(
                                string,
                                DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(string),
                                ),
                              );
                            })
                            .values
                            .toList(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 3.0,
                    color: Colors.lightBlue,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Translated Text: ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    output == null
                        ? "Please Select Language"
                        : output.toString(),
                    style: const TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    // final textDetector = GoogleMlKit.vision.textDetector();
    // RecognizedText recognisedText = await textDetector.processImage(inputImage);
    // await textDetector.close();

    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    scannedText = "";
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    textScanning = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }
}
