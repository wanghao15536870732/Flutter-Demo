package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.green.kinsomy.amaplocation.AmapLocationPlugin;
import bz.rxla.audioplayer.AudioplayerPlugin;
import com.mtechviral.musicfinder.MusicFinderPlugin;
import io.flutter.plugins.pathprovider.PathProviderPlugin;
import com.tekartik.sqflite.SqflitePlugin;

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
    PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"));
    SqflitePlugin.registerWith(registry.registrarFor("com.tekartik.sqflite.SqflitePlugin"));
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
