import 'package:flutter/material.dart';

import '../models/content_model.dart';

class Previews extends StatelessWidget {
  final String title;
  final List<Content> contentList;

  const Previews({super.key, required this.title, required this.contentList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
          ),
        ),
    Container(
        height: 165,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 8),
          scrollDirection: Axis.horizontal,
          itemCount: contentList.length,
          itemBuilder: (BuildContext context, int index){
            final Content content = contentList[index];
            return GestureDetector(
            onTap: (){print(content.name);},
            child: Stack(
              alignment: Alignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(content.imageUrl),
                            fit: BoxFit.cover
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(color: content.color!,width: 4)
                    ),
                  ),
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.black87,
                            Colors.black45,
                            Colors.transparent
                          ],
                          stops: [0,0.25,1],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(color: content.color!,width: 4)
                    ),
                  ),
                  Positioned(
                    left: 0,
                      right: 0,
                      bottom: 0,
                      child: Image.asset(content.titleImageUrl!)
                  )
              ],
            ),
        );
      }
    ),
        )
      ],
    );
  }
}
