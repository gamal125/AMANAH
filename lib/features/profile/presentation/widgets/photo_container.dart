import 'package:flutter/material.dart';

import '../../../../core/utils/colors/colors.dart';

class PhotoContainer extends StatelessWidget {
  final String url;
  const PhotoContainer({required this.url,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                                            height: 250,
                                            width: 350,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                     url),
                                                  fit: BoxFit.fill,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                border:
                                                    Border.all(color: primary)),
                                          );
  }
}