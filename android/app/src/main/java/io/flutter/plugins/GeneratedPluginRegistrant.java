package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.green.kinsomy.amaplocation.AmapLocationPlugin;
import com.mtechviral.musicfinder.MusicFinderPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    AmapLocationPlugin.registerWith(registry.registrarFor("com.green.kinsomy.amaplocation.AmapLocationPlugin"));
    MusicFinderPlugin.registerWith(registry.registrarFor("com.mtechviral.musicfinder.MusicFinderPlugin"));
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
