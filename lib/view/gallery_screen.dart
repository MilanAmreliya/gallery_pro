import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery/view/edit_video_screen.dart';
import 'package:gallery/view/photo_detail_screen.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';
import '../model/pref_man.dart';
import 'favirt_grid.dart';

class GalleryScreen extends StatefulWidget {
  final bool isSelected;
  const GalleryScreen({Key? key, required this.isSelected}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<Album>? _albums;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    initAsync();
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums = await PhotoGallery.listAlbums(
          mediumType: widget.isSelected ? MediumType.image : MediumType.video);
      setState(() {
        _albums = albums;
        _loading = false;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS &&
            await Permission.storage.request().isGranted &&
            await Permission.photos.request().isGranted ||
        Platform.isAndroid && await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : LayoutBuilder(
            builder: (context, constraints) {
              double gridWidth = (constraints.maxWidth - 5) / 3;
              double gridHeight = gridWidth + 35;
              double ratio = gridWidth / gridHeight;
              return GridView.builder(
                  itemCount: _albums!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: ratio,
                      childAspectRatio: 2 / 2.6,
                      crossAxisCount: 3,
                      mainAxisSpacing: 5),
                  itemBuilder: (BuildContext context, int index) {
                    List likePhoto = PreferenceManager.getLikePhoto() == null
                        ? []
                        : PreferenceManager.getLikePhoto();

                    if (likePhoto.isNotEmpty && index == 0) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(FavGrid());
                        },
                        child: Column(
                          children: [
                            Container(
                              color: Colors.grey[300],
                              height: gridWidth,
                              width: gridWidth,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Favouritdte",
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "(${likePhoto.length})",
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AlbumPage(_albums![index]),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: Colors.grey[300],
                            height: gridWidth,
                            width: gridWidth,
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              placeholder: MemoryImage(kTransparentImage),
                              image: AlbumThumbnailProvider(
                                albumId: _albums![index].id,
                                mediumType: _albums![index].mediumType,
                                highQuality: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _albums![index].name ?? "Unnamed Album",
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "(${_albums![index].name?.length.toString()})",
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
          );
  }
}

class AlbumPage extends StatefulWidget {
  final Album album;

  AlbumPage(Album album) : album = album;

  @override
  State<StatefulWidget> createState() => AlbumPageState();
}

class AlbumPageState extends State<AlbumPage> {
  List<Medium>? _media;

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    MediaPage mediaPage = await widget.album.listMedia();
    setState(() {
      _media = mediaPage.items;
    });
  }

  File? file;
  File? _image;
  String? filePath;
  Future convertMediumToFile(Medium medium) async {
    final obtainedFile = await PhotoGallery.getFile(mediumId: medium.id);
    setState(
      () {
        file = obtainedFile;
        filePath = obtainedFile.path;
      },
    );
    return obtainedFile;
  }

  // Future<File?> getFile(Medium medium) async {
  //   setState(
  //     () async {
  //       file = await convertMediumToFile(medium);
  //     },
  //   );
  //   return file;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              "assets/icons/ic_gallery.png",
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 10),
            const Text("Gallery"),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: PreferenceManager.getGrid() == null
            ? 4
            : PreferenceManager.getGrid(),
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        children: [
          ..._media!.map(
            (medium) {
              return GestureDetector(
                onTap: () async {
                  await convertMediumToFile(medium).then(
                    (value) => medium.mediumType == MediumType.image
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PhotoDetailScreen(
                                  file: file!,
                                  imageName: medium.title,
                                  path: filePath!,
                                  medium: medium,
                                );
                              },
                            ),
                          )
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoEditor(file: file!),
                            ),
                          ),
                  );
                },
                child: Container(
                  color: Colors.grey[300],
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: MemoryImage(kTransparentImage),
                    image: ThumbnailProvider(
                      mediumId: medium.id,
                      mediumType: medium.mediumType,
                      highQuality: true,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ViewerPage extends StatelessWidget {
  final Medium medium;
  ViewerPage(Medium medium) : medium = medium;
  @override
  Widget build(BuildContext context) {
    DateTime? date = medium.creationDate ?? medium.modifiedDate;
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: medium.mediumType == MediumType.image
          ? FadeInImage(
              fit: BoxFit.cover,
              placeholder: MemoryImage(kTransparentImage),
              image: PhotoProvider(mediumId: medium.id),
            )
          : VideoProvider(
              mediumId: medium.id,
            ),
    );
  }
}

class VideoProvider extends StatefulWidget {
  final String mediumId;

  const VideoProvider({
    required this.mediumId,
  });

  @override
  _VideoProviderState createState() => _VideoProviderState();
}

class _VideoProviderState extends State<VideoProvider> {
  VideoPlayerController? _controller;
  File? _file;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAsync();
    });
    super.initState();
  }

  Future<void> initAsync() async {
    try {
      _file = await PhotoGallery.getFile(mediumId: widget.mediumId);
      _controller = VideoPlayerController.file(_file!);
      _controller?.initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    } catch (e) {
      print("Failed : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _controller == null || !_controller!.value.isInitialized
        ? Container()
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    _controller!.value.isPlaying
                        ? _controller!.pause()
                        : _controller!.play();
                  });
                },
                child: Icon(
                  _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            ],
          );
  }
}
