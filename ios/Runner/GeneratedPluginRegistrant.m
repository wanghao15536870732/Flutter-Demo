//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <amap_location_plugin/AmapLocationPlugin.h>
#import <audioplayer/AudioplayerPlugin.h>
#import <flute_music_player/MusicFinderPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [AmapLocationPlugin registerWithRegistrar:[registry registrarForPlugin:@"AmapLocationPlugin"]];
  [AudioplayerPlugin registerWithRegistrar:[registry registrarForPlugin:@"AudioplayerPlugin"]];
  [MusicFinderPlugin registerWithRegistrar:[registry registrarForPlugin:@"MusicFinderPlugin"]];
}

@end
