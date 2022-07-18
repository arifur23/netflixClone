import 'package:flutter/material.dart';
import 'package:netflix_clone/Widgets/widgets.dart';

import '../assets.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;

  const CustomAppBar({super.key, this.scrollOffset = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 24),
      color: Colors.black.withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
      child: const Responsive(
        mobile: _CustomAppBarMobile(),
        desktop: _CustomAppBarDesktop(), tablet: Center(
        child: Text('Tablet Version'),
      ),
      ),
    );
  }
}

class _CustomAppBarMobile extends StatelessWidget {
  const _CustomAppBarMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo0),
          const SizedBox(width: 12,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _AppBarButton(title: 'TV Shows',onTap: (){ print('TV Shows'); },),
                _AppBarButton(title: 'Movies',onTap: (){ print('Movies'); },),
                _AppBarButton(title: 'My List',onTap: (){ print('My List'); },)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppBarDesktop extends StatelessWidget {
  const _CustomAppBarDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo1),
          const SizedBox(width: 80,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _AppBarButton(title: 'Home',onTap: (){ print('Home'); },),
                _AppBarButton(title: 'TV Shows',onTap: (){ print('TV Shows'); },),
                _AppBarButton(title: 'Movies',onTap: (){ print('Movies'); },),
                _AppBarButton(title: 'Latest',onTap: (){ print('Latest'); },),
                _AppBarButton(title: 'My List',onTap: (){ print('My List'); },),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.search),
                  iconSize: 28,
                  color: Colors.white,
                ),
                _AppBarButton(title: 'TV Shows',onTap: (){ print('KIDS'); },),
                _AppBarButton(title: 'Movies',onTap: (){ print('DVD'); },),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.card_giftcard),
                  iconSize: 28,
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.notifications),
                  iconSize: 28,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const _AppBarButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(title,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600
        ),),
    );
  }
}

