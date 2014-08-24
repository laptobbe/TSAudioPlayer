//
//  TSAudioPlayer.h
//  TSAudioPlayer
//
//  Created by Tobias Sundstrand on 2014-08-24.
//
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface TSAudioPlayer : NSObject

- (instancetype)initWithURL:(NSURL *)url;
- (instancetype)initWithInputStream:(NSInputStream *)inputStream;
- (void)addOutputStream:(NSOutputStream *)outputStream;
- (void)seekTo:(NSTimeInterval)seekPosition;
- (void)play;
- (void)pause;
- (void)stop;


@end
