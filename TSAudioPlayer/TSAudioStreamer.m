//
// Created by Tobias Sundstrand on 14-08-26.
//

#import "TSAudioStreamer.h"
#import <AudioToolbox/AudioToolbox.h>

static const int kNumberBuffers = 5;                              // 1
struct TSPlayerState {
    AudioStreamBasicDescription   mDataFormat;                    // 2
    AudioQueueRef                 mQueue;                         // 3
    AudioQueueBufferRef           mBuffers[kNumberBuffers];       // 4
    UInt32                        bufferByteSize;                 // 6
    SInt64                        mCurrentPacket;                 // 7
    UInt32                        mNumPacketsToRead;              // 8
    AudioStreamPacketDescription  *mPacketDescs;                  // 9
    bool                          mIsRunning;                     // 10
};
typedef struct TSPlayerState TSPlayerState;


static void TSAudioStreamerPropertyListener (
        void *			            inClientData,
        AudioFileStreamID			inAudioFileStream,
        AudioFileStreamPropertyID	inPropertyID,
        UInt32 *					ioFlags) {


}

static void TSAudioStreamerPacketsProvider (
        void *				            inClientData,
        UInt32							inNumberBytes,
        UInt32							inNumberPackets,
        const void *					inInputData,
        AudioStreamPacketDescription	*inPacketDescriptions){


}
@interface TSAudioStreamer () <NSURLSessionDelegate, NSURLSessionDataDelegate>

@property(nonatomic, assign) struct TSPlayerState playerState;
@property(nonatomic, strong) NSURL *streamURL;
@property(nonatomic, assign) AudioFileStreamID streamID;

@end

@implementation TSAudioStreamer

- (instancetype)initWithURL:(NSURL *)streamURL {
    self = [super init];
    if(self) {
        _streamURL = streamURL;
    }
    return self;
}

- (void)play {
    OSStatus status = AudioFileStreamOpen(&_playerState, TSAudioStreamerPropertyListener, TSAudioStreamerPacketsProvider, kAudioFileMP3Type, &_streamID);
    if (status == kAudioServicesNoError) {
        [self startDownload];
    }else {
        NSLog(@"Error opening stream, error %i", (int)status);
    }
}

- (void)startDownload {
    NSURLSession *downloadSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [downloadSession dataTaskWithURL:self.streamURL];
    [dataTask resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    AudioFileStreamParseBytes(self.streamID, data.length, data.bytes, 0);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
        didCompleteWithError:(NSError *)error {
    NSLog(@"Error in downloading %@", error);
}


@end