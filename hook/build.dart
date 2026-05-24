import 'package:hooks/hooks.dart';
import 'package:flutter_scene/build_hooks.dart';

void main(List<String> args) {
  build(args, (input, output) async {
    buildModels(
      buildInput: input,
      inputFilePaths: [
        // 'minecraft_sprunki_oren_after_blender.glb',
        // 'zombie_after_blender.glb', //
        // 'toilet_after_blender.glb', //
        // 'tvman_supreme.glb',
        // 'cameraman_supreme_god.glb',
        // 'skibidi_yisus.glb',
        // 'tv_man_supreme.glb',
        // 'tvman_multiple_supreme.glb',
        // 'tvman_multiple.glb',
        // 'tvman_supreme.glb',
        // 'tvwoman.glb',
      ],
    );
  });
}
