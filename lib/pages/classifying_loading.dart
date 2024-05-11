import 'package:bicol_folkdance/pages/output_done.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';

class ClassifyingLoading extends StatefulWidget {
  final File videoFile;
  const ClassifyingLoading({Key? key, required this.videoFile})
      : super(key: key);

  @override
  _ClassifyingLoadingState createState() => _ClassifyingLoadingState();
}

class _ClassifyingLoadingState extends State<ClassifyingLoading> {
  int totalFrames = 0;
  int processedFrame = 0;
  Map<String, int> count = {
    "Sinakiki": 0,
    "Jota Camarines": 0,
    "Pandanggo Rinconada": 0,
    "Jota Bicolana": 0,
    "Bicol Cariñosa": 0,
    "Saguin Saguin": 0,
    "Paseo de Bicol": 0,
    "Pantomina de Albay": 0,
    "Lapay Bantigue": 0,
    "Pastores Tubog": 0,
  };

  Map<String, dynamic> _prediction = {};
  @override
  void initState() {
    super.initState();
    // Delay duration
    const delayDuration =
        Duration(seconds: 1); // Adjust the delay time as needed
    loadInterpreters().then((value) {
      // Navigate to the next page after the delay
      classify().then((r) {
        if (!mounted) {
          return;
        }
        Future.delayed(delayDuration, () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ClassificationDone(
                prediction: _prediction,
              ), // Navigate to the next page
            ),
          );
        });
      });
    });
  }

  getLargestDance() {
    String largestDance = '';
    double largestPercentage = 0;
    Map<String, String> classesPercentage = {};
    count.forEach((key, value) {
      double percentage = (value / count.values.reduce((a, b) => a + b)) * 100;
      classesPercentage[key] = percentage.toStringAsFixed(2);
      if (percentage > largestPercentage) {
        largestPercentage = percentage;
        largestDance = key;
      }
    });

    return {
      "dance": largestDance,
      "score": largestPercentage,
      "stats": classesPercentage,
    };
  }

  Future classify() async {
    final videoFrames = await extractFrames(widget.videoFile, fps: 1);
    setState(() {
      totalFrames = videoFrames.length;
    });
    for (var i = 0; i < videoFrames.length; i++) {
      if (!mounted) {
        break;
      }
      print("Processing Frame ${i + 1}.....");
      var frame = img.decodeImage(File(videoFrames[i]).readAsBytesSync())!;
      var imageHeight = frame.height;
      var imageWidth = frame.width;
      var cropRegion = initCropRegion(imageHeight, imageWidth);
      var im = cropAndResize(frame, cropRegion, [256, 256]);
      var keypointsWithScore = await moveNetInference(im, frame, cropRegion);
      List<double> keypoints = keypointsWithScore
          .expand((list1) =>
              list1.expand((list2) => list2.expand((list3) => list3)))
          .toList();
      print(keypoints);
      var output = await classifierInference([keypoints]);
      print(output);
      count[output['class']] = count[output['class']]! + 1;
      processedFrame += 1;
      setState(() {});
    }
    if (!mounted) {
      return;
    }
    _prediction = getLargestDance();
    print(_prediction);
    print("Predicted Dance : ${_prediction['dance']}");
  }

  late IsolateInterpreter _classifier;
  late IsolateInterpreter _moveNet;
  final classes = [
    "Sinakiki",
    "Jota Camarines",
    "Pandanggo Rinconada",
    "Jota Bicolana",
    "Bicol Cariñosa",
    "Saguin Saguin",
    "Paseo de Bicol",
    "Pantomina de Albay",
    "Lapay Bantigue",
    "Pastores Tubog",
  ];

  Future<void> loadInterpreters() async {
    try {
      var moveNetOptions = InterpreterOptions();
      moveNetOptions.threads = 4;
      final moveNet = await Interpreter.fromAsset(
          'assets/models/movenet_thunder.tflite',
          options: moveNetOptions); // Load the model from assets
      moveNet.allocateTensors();
      _moveNet = await IsolateInterpreter.create(address: moveNet.address);
      var classifierOptions = InterpreterOptions();
      classifierOptions.threads = 4;
      final classfier = await Interpreter.fromAsset(
          'assets/models/pose_classifier_89(2).tflite',
          options: classifierOptions); // Load the model from assets
      classfier.allocateTensors();
      _classifier = await IsolateInterpreter.create(address: classfier.address);
      print("Interpreter loaded successfully");
    } catch (e) {
      print("Failed to load the interpreter: $e");
    }
  }

  Map<String, double> initCropRegion(int imageHeight, int imageWidth) {
    double xMin, yMin, boxWidth, boxHeight;

    if (imageWidth > imageHeight) {
      xMin = 0.0;
      boxWidth = 1.0;
      // Pad the vertical dimension to become a square image.
      yMin = (imageHeight / 2 - imageWidth / 2) / imageHeight;
      boxHeight = imageWidth / imageHeight;
    } else {
      yMin = 0.0;
      boxHeight = 1.0;
      // Pad the horizontal dimension to become a square image.
      xMin = (imageWidth / 2 - imageHeight / 2) / imageWidth;
      boxWidth = imageHeight / imageWidth;
    }

    return {
      'y_min': yMin,
      'x_min': xMin,
      'y_max': yMin + boxHeight,
      'x_max': xMin + boxWidth,
      'height': boxHeight,
      'width': boxWidth
    };
  }

  img.Image cropAndResize(
      img.Image image, Map<String, double> cropRegion, List<int> cropSize) {
    double yMin = cropRegion['y_min']!;
    double xMin = cropRegion['x_min']!;
    double yMax = cropRegion['y_max']!;
    double xMax = cropRegion['x_max']!;

    int cropTop = (yMin < 0) ? 0 : (yMin * image.height).toInt();
    int cropBottom = (yMax >= 1) ? image.height : (yMax * image.height).toInt();
    int cropLeft = (xMin < 0) ? 0 : (xMin * image.width).toInt();
    int cropRight = (xMax >= 1) ? image.width : (xMax * image.width).toInt();

    int paddingTop = (yMin < 0) ? (0 - yMin * image.height).toInt() : 0;
    int paddingBottom = (yMax >= 1) ? ((yMax - 1) * image.height).toInt() : 0;
    int paddingLeft = (xMin < 0) ? (0 - xMin * image.width).toInt() : 0;
    int paddingRight = (xMax >= 1) ? ((xMax - 1) * image.width).toInt() : 0;

    // Crop image
    img.Image outputImage = img.copyCrop(
        image, cropLeft, cropTop, cropRight - cropLeft, cropBottom - cropTop);

    // Add padding
    outputImage = addPadding(
        outputImage, paddingTop, paddingBottom, paddingLeft, paddingRight);
    // Resize image
    outputImage =
        img.copyResize(outputImage, width: cropSize[0], height: cropSize[1]);

    return outputImage;
  }

  img.Image addPadding(
      img.Image image, int top, int bottom, int left, int right) {
    img.Image paddedImage =
        img.Image(image.width + left + right, image.height + top + bottom);

    // Fill the padded image with the border color (in this case, black)
    img.fill(paddedImage, img.getColor(0, 0, 0));

    // Copy the original image to the padded image
    paddedImage = img.copyInto(paddedImage, image, dstX: left, dstY: top);

    return paddedImage;
  }

  Future<List<String>> extractFrames(File videoFile, {int fps = 4}) async {
    final ffmpeg = FlutterFFmpeg();
    final Directory appDocDir = await getApplicationDocumentsDirectory();

    final framesDirectory = Directory(appDocDir.path);
    List<FileSystemEntity> files = framesDirectory.listSync();

    // Iterate through the files and delete them
    for (FileSystemEntity file in files) {
      if (file is File) {
        file.deleteSync();
      }
    }
    final String outputPath = '${appDocDir.path}/frame%d.jpg';

    // Execute FFmpeg command to extract frames from 0 to 15 seconds
    final arguments = [
      '-i',
      videoFile.path,
      '-ss',
      '0', // Starting time (0 seconds)
      '-t',
      '15', // Duration (15 seconds)
      '-vf',
      'fps=$fps',
      outputPath,
    ];
    await ffmpeg.executeWithArguments(arguments);

    // Return list of extracted frames as img.Image
    if (framesDirectory.existsSync()) {
      final frames = framesDirectory
          .listSync()
          .where((file) => file.path.endsWith('.jpg'))
          .map((file) => file.path)
          .toList();
      return frames;
    }
    return [];
  }

  Future<List<List<List<List<double>>>>> moveNetInference(img.Image image,
      img.Image baseImage, Map<String, double> cropRegion) async {
    List<List<List<int>>> tensor = List.generate(
      256,
      (j) => List.generate(256, (k) => List.filled(3, 0)),
    );

    for (int y = 0; y < 256; y++) {
      for (int x = 0; x < 256; x++) {
        int pixel = image.getPixel(x, y);
        tensor[y][x][0] = img.getRed(pixel); // Red channel
        tensor[y][x][1] = img.getGreen(pixel); // Green channel
        tensor[y][x][2] = img.getBlue(pixel); // Blue channel
      }
    }

    var keypointsWithScores = List.generate(
      1,
      (_) => List.generate(
        1,
        (_) => List.generate(
          17,
          (_) => List.filled(3, 0.0),
        ),
      ),
    );

    await _moveNet.run([tensor], keypointsWithScores);

    for (int i = 0; i < 17; i++) {
      var y = baseImage.height *
          (cropRegion['y_min']! +
              cropRegion['height']! * keypointsWithScores[0][0][i][0]);
      var x = baseImage.width *
          (cropRegion['x_min']! +
              cropRegion['width']! * keypointsWithScores[0][0][i][1]);
      keypointsWithScores[0][0][i][0] = x;
      keypointsWithScores[0][0][i][1] = y;
      keypointsWithScores[0][0][i][2] = keypointsWithScores[0][0][i][2];
    }

    return keypointsWithScores;
  }

  dynamic classifierInference(List<List<double>> keypoints) async {
    var output = List.generate(
      1,
      (_) => List.filled(10, 0.0),
    );

    await _classifier.run([keypoints], output);

    int index = output[0]
        .asMap()
        .entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
    return {
      "index": index,
      "score": (output[0][index] * 100).toStringAsFixed(2),
      "class": classes[index],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/classfyingdance_loading.jpg'), // Background image
            fit: BoxFit.cover, // Cover the whole container
          ),
        ),
        child: Stack(
          children: [
            Positioned(
                bottom: 200, // Adjust top position
                left: MediaQuery.of(context).size.width / 2 -
                    20, // Center horizontally
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white), // Change indicator color to white
                    ),
                    totalFrames != 0
                        ? Text("$processedFrame/$totalFrames")
                        : const Text("Extracting Frames")
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(const MaterialApp(
//     title: 'BFD',
//     home: ClassifyingLoading(),
//   ));
// }
