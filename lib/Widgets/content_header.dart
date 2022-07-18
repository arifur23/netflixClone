import 'package:flutter/material.dart';
import 'package:netflix_clone/models/content_model.dart';
import 'package:video_player/video_player.dart';

import 'widgets.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;

  const ContentHeader({super.key, required this.featuredContent});

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _ContentHeaderMobile(featuredContent: featuredContent),
        tablet: Center(child: Text('tablet'),),
        desktop: _ContentHeaderDesktop(featuredContent: featuredContent));
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final Content featuredContent;

  const _ContentHeaderMobile({super.key, required this.featuredContent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(featuredContent.imageUrl,),
                fit: BoxFit.cover
            ),

          ),
        ),
        Container(
          height: 500,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
              )
          ),
        ),
        Positioned(
            bottom: 110,
            child: SizedBox(
              width: 250,
              child: Image.asset((featuredContent.titleImageUrl!)),
            )
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VerticalIconButton(
                    icon: Icons.info_outline,
                    title: "List",
                    onTap: (){ print('List');}
                ),
                PlayButton(),
                VerticalIconButton(
                    icon: Icons.info_outline,
                    title: "Info",
                    onTap: (){ print('Info');}
                ),
              ],
            )
        )
      ],
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;

  const _ContentHeaderDesktop({super.key, required this.featuredContent});

  @override
  State<_ContentHeaderDesktop> createState() => _ContentHeaderDesktopState();
}

class _ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {

  late VideoPlayerController _videoPlayerController;
  bool isMuted = true;

  @override
  void initState()  {
    _videoPlayerController = VideoPlayerController.network(widget.featuredContent.videoUrl!)
    ..initialize().then((_) => setState((){}))..setVolume(0)..play();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _videoPlayerController.value.isPlaying ?
            _videoPlayerController.pause() :
            _videoPlayerController.play();
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
              aspectRatio: _videoPlayerController.value.isInitialized
                  ? _videoPlayerController.value.aspectRatio
                  : 2.344,
            child: _videoPlayerController.value.isInitialized
            ? VideoPlayer(_videoPlayerController)
            : Image.asset(
              widget.featuredContent.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          AspectRatio(
            aspectRatio: _videoPlayerController.value.isInitialized
                ? _videoPlayerController.value.aspectRatio
                : 2.344,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter
                  )
              ),
            ),
          ),

          Positioned(
            left: 60,
              right: 60,
              bottom: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250,
                    child: Image.asset(widget.featuredContent.titleImageUrl!,),
                  ),
                  const SizedBox(height: 15,),
                  Text(
                    widget.featuredContent.description!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(color: Colors.black,offset: Offset(2.0, 4.0), blurRadius: 6)
                      ]
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      const PlayButton(),
                      const SizedBox(width: 16,),
                      ElevatedButton.icon(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.fromLTRB(25, 10, 30, 10),
                            ),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                          ),
                          onPressed: (){},
                          icon: const Icon(Icons.info_outline,size: 30, color: Colors.black,),
                          label: const Text(
                            'More Info',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                            ),
                          )),
                      const SizedBox(width: 20,),
                      if (_videoPlayerController.value.isInitialized)
                        IconButton(
                          onPressed: (){
                            setState(
                                    (){
                                  isMuted
                                      ? _videoPlayerController.setVolume(100)
                                      : _videoPlayerController.setVolume(0);
                                  isMuted = _videoPlayerController.value.volume == 0;
                                }
                            );
                          },
                          icon: Icon(
                            isMuted ? Icons.volume_off : Icons.volume_up,
                          ),
                          color: Colors.white,
                          iconSize: 30,
                        )
                    ],
                  )
                ],
              )
          ),

        ],
      ),
    );
  }
}


class PlayButton extends StatelessWidget {
   const PlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        padding: !Responsive.isDesktop(context)
          ? MaterialStateProperty.all(
          const EdgeInsets.fromLTRB(15, 5, 20, 5),
        )
          : MaterialStateProperty.all(
          const EdgeInsets.fromLTRB(25, 10, 30, 10),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
      ),
        onPressed: (){print('Play');},
        icon: const Icon(Icons.play_arrow,size: 30,color: Colors.black,),
        label: const Text('Play',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600
        ),
        ));
  }
}

