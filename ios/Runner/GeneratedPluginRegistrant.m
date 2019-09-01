//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <amap_location_plugin/AmapLocationPlugin.h>
#import <audioplayer/AudioplayerPlugin.h>
#import <flute_music_player/MusicFinderPlugin.h>
#import <flutter_webview_plugin/FlutterWebviewPlugin.h>
#import <video_player/VideoPlayerPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [AmapLocationPlugin registerWithRegistrar:[registry registrarForPlugin:@"AmapLocationPlugin"]];
  [AudioplayerPlugin registerWithRegistrar:[registry registrarForPlugin:@"AudioplayerPlugin"]];
  [MusicFinderPlugin registerWithRegistrar:[registry registrarForPlugin:@"MusicFinderPlugin"]];
  [FlutterWebviewPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterWebviewPlugin"]];
  [FLTVideoPlayerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTVideoPlayerPlugin"]];
}

@end
