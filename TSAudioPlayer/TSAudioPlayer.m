//
//  TSAudioPlayer.m
//  TSAudioPlayer
//
//  Created by Tobias Sundstrand on 2014-08-24.
//
//

#import "TSAudioPlayer.h"



@interface TSAudioPlayer () <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

@property(nonatomic, strong) NSMutableArray *outputStreams;

@property(nonatomic, strong) NSInputStream *inputStream;
@property(nonatomic, strong) NSURLSession *backgroundSession;
@property(nonatomic, strong) NSOperationQueue *delegateQueue;
@property(nonatomic, strong) NSMutableData *audioDataCache;
@property(nonatomic, strong) NSURLSessionDataTask *streamTask;

@end

@implementation TSAudioPlayer

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if(self) {
        _streamTask = [self.backgroundSession dataTaskWithURL:url];
    }
    return self;
}

- (NSOperationQueue *)delegateQueue {
    if(!_delegateQueue) {
        _delegateQueue = [[NSOperationQueue alloc] init];
    }
    return _delegateQueue;
}

- (NSURLSession *)backgroundSession {
   if(!_backgroundSession) {
        _backgroundSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"TSAudioPlayer"] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _backgroundSession;
}

- (instancetype)initWithInputStream:(NSInputStream *)inputStream {
    self = [super init];
    if(self) {
        _inputStream = inputStream;
    }
    return self;
}

- (void)addOutputStream:(NSOutputStream *)outputStream {
    @synchronized (self) {
        [self.outputStreams addObject:outputStream];
    }
}


- (void)seekTo:(NSTimeInterval)seekPosition {

}

- (void)play {
    [self.streamTask resume];
}

- (void)pause {

}

- (void)stop {

}
#pragma mark - URLSession delegate methods

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {

}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    @synchronized (self) {
        [self.audioDataCache appendData:data];
    }
}

/*
static const int kNumberBuffers = 5;                              // 1
struct AQPlayerState {
    AudioStreamBasicDescription   mDataFormat;                    // 2
    AudioQueueRef                 mQueue;                         // 3
    AudioQueueBufferRef           mBuffers[kNumberBuffers];       // 4
    UInt32                        bufferByteSize;                 // 6
    SInt64                        mCurrentPacket;                 // 7
    UInt32                        mNumPacketsToRead;              // 8
    AudioStreamPacketDescription  *mPacketDescs;                  // 9
    bool                          mIsRunning;                     // 10
};

static void HandleOutputBuffer (
        void                *aqData,
        AudioQueueRef       inAQ,
        AudioQueueBufferRef inBuffer
) {
    struct AQPlayerState *pAqData = (struct AQPlayerState *) aqData;        // 1
    if (pAqData->mIsRunning == 0) return;                     // 2
    UInt32 numPackets = pAqData->mNumPacketsToRead;           // 4

    if (numPackets > 0) {                                     // 5
        inBuffer->mAudioDataByteSize = ;  // 6
        AudioQueueEnqueueBuffer (
                pAqData->mQueue,
                inBuffer,
                (pAqData->mPacketDescs ? numPackets : 0),
                pAqData->mPacketDescs
        );
        pAqData->mCurrentPacket += numPackets;                // 7
    } else {
        AudioQueueStop (
                pAqData->mQueue,
                false
        );
        pAqData->mIsRunning = false;
    }
}
*/
@end
