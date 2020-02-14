package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.green.kinsomy.amaplocation.AmapLocationPlugin;
import bz.rxla.audioplayer.AudioplayerPlugin;
import com.mtechviral.musicfinder.MusicFinderPlugin;
import com.flutter_webview_plugin.FlutterWebviewPlugin;
import flutter.plugins.screen.screen.ScreenPlugin;
import io.flutter.plugins.videoplayer.VideoPlayerPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    AmapLocationPlugin.registerWith(registry.registrarFor("com.green.kinsomy.amaplocation.AmapLocationPlugin"));
    AudioplayerPlugin.registerWith(registry.registrarFor("bz.rxla.audioplayer.AudioplayerPlugin"));
    MusicFinderPlugin.registerWith(registry.registrarFor("com.mtechviral.musicfinder.MusicFinderPlugin"));
    FlutterWebviewPlugin.registerWith(registry.registrarFor("com.flutter_webview_plugin.FlutterWebviewPlugin"));
    ScreenPlugin.registerWith(registry.registrarFor("flutter.plugins.screen.screen.ScreenPlugin"));
    VideoPlayerPlugin.registerWith(registry.registrarFor("io.flutter.plugins.videoplayer.VideoPlayerPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
