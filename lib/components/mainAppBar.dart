import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_recognition/speech_recognition.dart';

class MainAppBar extends StatefulWidget {
  Function filterByName;

  MainAppBar({this.filterByName}) : assert(filterByName != null);

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  SpeechRecognition _speech;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activateSpeechRecognizer();
  }

  void activateSpeechRecognizer() {
    requestPermission();

    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler((result) {
      setState(() {
        _speechRecognitionAvailable = result;
      });
    });
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  void requestPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.microphone);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.microphone]);
    }
  }

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) =>
      setState(() => print("current locale: $locale"));

  void onRecognitionStarted() => setState(() => {
        transcription = '',
        _isListening = true,
      });

  void onRecognitionComplete() => setState(
        () => {
          _isListening = false,
          widget.filterByName(transcription),
        },
      );

  void onRecognitionResult(String text) {
    setState(() {
      transcription = text;
    });
  }

  void stop() {
    _speech.stop().then((result) {
      setState(() {
        _isListening = result;
      });
    });
  }

  void start() {
    _speech.listen(locale: 'en_US').then((result) {
      print('Started listening => result $result');
    });
  }

  void cancel() {
    _speech.cancel().then((result) {
      setState(() {
        _isListening = result;
      });
    });
  }

  Widget _buildVoiceInput() {
    return IconButton(
      icon: Icon(Icons.mic),
      onPressed: _speechRecognitionAvailable && !_isListening
          ? () => start()
          : () => stop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 0.5),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Text('Pokemon', style: TextStyle(fontSize: 20)),
              SizedBox(height: 15),
              TextField(
                onChanged: (String text) {
                  widget.filterByName(text);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: _buildVoiceInput(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(900),
                    ),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  labelText: 'Search',
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
