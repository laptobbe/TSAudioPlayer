//
// Created by Tobias Sundstrand on 14-08-26.
//

#import <Foundation/Foundation.h>


@interface TSAudioStreamer : NSObject


- (instancetype)initWithURL:(NSURL *)streamURL;

- (void)prime;
- (BOOL)play;
- (void)stop;
- (void)pause;

@end