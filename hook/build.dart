import 'package:native_assets_cli/native_assets_cli.dart';
import 'package:flutter_scene_importer/build_hooks.dart';

void main(List<String> args) {
  build(args, (config, output) async {
    buildModels(
      buildInput: config,
      inputFilePaths: [
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
