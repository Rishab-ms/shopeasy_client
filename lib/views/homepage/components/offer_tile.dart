import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OfferTile extends StatelessWidget {
  const OfferTile({
    Key? key,
    required this.context,
    required this.url,
  }) : super(key: key);

  final BuildContext context;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              //image
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  fadeInDuration: const Duration(milliseconds: 500),
                  placeholderFadeInDuration: const Duration(milliseconds: 500),
                ),
              ),
              //black overlay gradient from bottom to top
              Positioned(
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black87,
                        Colors.black54,
                        Colors.black38,
                        Colors.black26,
                        Colors.black12,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                ),
              ),

              //offer text
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Up to 50% off',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'On all products',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.8),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
