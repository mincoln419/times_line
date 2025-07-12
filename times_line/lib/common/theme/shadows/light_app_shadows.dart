import 'package:times_line/common/common.dart';
import 'package:flutter/material.dart';

class LightAppShadows extends AbsThemeShadows {
  const LightAppShadows();

  @override
  BoxShadow get buttonShadow => const BoxShadow(
        offset: Offset(0, 2),
        blurRadius: 4,
        color: Color.fromARGB(20, 0, 0, 0),
      );

  @override
  BoxShadow get thickTextShadow => const BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 2,
        color: Color.fromARGB(30, 0, 0, 0),
      );

  @override
  BoxShadow get defaultShadow => const BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 3,
        color: Color.fromARGB(15, 0, 0, 0),
      );

  @override
  BoxShadow get textShadow => const BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 2,
        color: Color.fromARGB(20, 0, 0, 0),
      );

  @override
  BoxShadow get buttonShadowSmall => const BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 2,
        color: Color.fromARGB(15, 0, 0, 0),
      );
}
