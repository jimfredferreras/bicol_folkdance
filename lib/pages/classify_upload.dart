import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'video_preview.dart';

class ClassifyUpload extends StatefulWidget {
  const ClassifyUpload({Key? key}) : super(key: key);

  @override
  State<ClassifyUpload> createState() => _ClassifyUploadState();
}

class _ClassifyUploadState extends State<ClassifyUpload> {
  late File _videoFile;


  Future<void> _pickVideo(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowCompression: false,
    );
    if (result != null) {
      final file = File(result.files.single.path!);
      final videoDimensions = await _getVideoDimensions(file);

      // Check if video is landscape (width > height)
      if (videoDimensions.width > videoDimensions.height) {
        setState(() {
          _videoFile = file;
      });
       
        // Navigate to the VideoPreviewScreen
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VideoPreviewScreen(videoFile: _videoFile),
        ));
      } else {
        // Show error message or dialog for landscape video required
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('UPLOAD FAILED!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            content: Text(
                'The system only accepts landscape videos. Please upload a landscape video.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<Size> _getVideoDimensions(File file) async {
    final videoController = VideoPlayerController.file(file);
    await videoController.initialize();
    final double width = videoController.value.size.width;
    final double height = videoController.value.size.height;
    await videoController.dispose();
    return Size(width, height);
  }

  Future<Duration> _getVideoLength(File file) async {
    final videoController = VideoPlayerController.file(file);
    await videoController.initialize();
    final Duration duration = videoController.value.duration;
    await videoController.dispose();
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/bg2.jpg', // Assuming bg_app.jpg is in the assets folder
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => _pickVideo(context), // Pass context here
                child: SizedBox(
                  width: 150, // Adjust width as needed
                  height: 150, // Adjust height as needed
                  child: Image.asset(
                    'assets/upload_button.png', // Assuming upload_button.png is in the assets folder
                    fit: BoxFit
                        .contain, // You can adjust the fit based on your requirements
                  ),
                ),
              ),
              SizedBox(
                height: 10, // Add some space between the button and text
              ),
              Text(
                'U P L O A D',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
