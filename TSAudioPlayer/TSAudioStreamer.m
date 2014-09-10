//
// Created by Tobias Sundstrand on 14-08-26.
//

#import "TSAudioStreamer.h"
#import <AudioToolbox/AudioToolbox.h>

@interface TSAudioStreamer () <NSURLSessionDelegate, NSURLSessionDataDelegate>

@property(nonatomic, strong) NSURL *streamURL;
@property(nonatomic, assign) AudioFileStreamID streamID;
@property(nonatomic, assign) AudioQueueRef audioQueue;
@property(nonatomic, assign) BOOL isReadyForPlayback;
@property(nonatomic, assign) UInt64 totalPacketCount;
@property(nonatomic, assign) AudioStreamBasicDescription basicDescription;


- (void)setupAudioQueueFromBasicDescription:(AudioStreamBasicDescription)basicDescription;

@end

static void TSAudioStreamerPropertyListener (
        void *			            inClientData,
        AudioFileStreamID			inAudioFileStream,
        AudioFileStreamPropertyID	inPropertyID,
        UInt32 *					ioFlags) {
    
    TSAudioStreamer *streamer = (__bridge TSAudioStreamer *)(inClientData);
    
    if (inPropertyID == kAudioFileStreamProperty_DataFormat) {
        @synchronized(streamer){
            UInt32 basicDescriptionSize = sizeof(AudioStreamBasicDescription);
            AudioStreamBasicDescription basicDescription;
            AudioFileStreamGetProperty(inAudioFileStream, inPropertyID, &basicDescriptionSize, &basicDescription);
            [streamer setupAudioQueueFromBasicDescription:basicDescription];
            streamer.isReadyForPlayback = YES;
        }
    }else if(inPropertyID == kAudioFileStreamProperty_AudioDataPacketCount) {
        UInt32 propertySize = sizeof(UInt64);
        UInt64 packetCount;
        AudioFileStreamGetProperty(inAudioFileStream, inPropertyID, &propertySize, &packetCount);
        streamer.totalPacketCount = packetCount;
    }
}

static void TSAudioStreamerPacketsProvider (
        void *				            inClientData,
        UInt32							inNumberBytes,
        UInt32							inNumberPackets,
        const void *					inInputData,
        AudioStreamPacketDescription	*inPacketDescriptions){
    TSAudioStreamer *streamer = (__bridge TSAudioStreamer *)(inClientData);
    AudioQueueBufferRef buffer = nil;
    OSStatus error = AudioQueueAllocateBuffer(streamer.audioQueue, inNumberBytes, &buffer);
    if(error) {
        NSLog(@"Error allocating buffer");
    }
    
    memcpy(buffer->mAudioData, inInputData, inNumberBytes);
   
    buffer->mAudioDataByteSize = inNumberBytes;
    
    AudioQueueEnqueueBuffer(streamer.audioQueue, buffer, inNumberPackets, inPacketDescriptions);
    
}

static void TSAudioOutputCallback (
                                   void *                  inUserData,
                                   AudioQueueRef           inAQ,
                                   AudioQueueBufferRef     inBuffer
                                   ) {
    TSAudioStreamer *streamer = (__bridge TSAudioStreamer *)(inUserData);
    
}

@implementation TSAudioStreamer

- (instancetype)initWithURL:(NSURL *)streamURL {
    self = [super init];
    if(self) {
        _streamURL = streamURL;
        OSStatus streamStatus = AudioFileStreamOpen((__bridge void *)(self), TSAudioStreamerPropertyListener, TSAudioStreamerPacketsProvider, kAudioFileMP3Type, &_streamID);
        if(streamStatus) {
            NSLog(@"Error opening stream");
        }
    }
    return self;
}
- (void)setupAudioQueueFromBasicDescription:(AudioStreamBasicDescription)basicDescription {
    self.basicDescription = basicDescription;
    AudioQueueNewOutput(&basicDescription, TSAudioOutputCallback, (__bridge void *)(self), CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, 0, &_audioQueue);
}

- (void)prime {
    [self startDownload];
}

- (BOOL)play {
    @synchronized(self){
        if(!self.isReadyForPlayback) {
            return NO;
        }
        
        UInt32 numberOfPreparedFrames = 0;
        OSStatus error = 0;
        error = AudioQueuePrime(self.audioQueue, 0, &numberOfPreparedFrames);
        if(error) {
            NSLog(@"Error priming");
        }
        
        error =  AudioQueueStart(self.audioQueue, NULL);
        if(error) {
            NSLog(@"Error stating playback");
        }
        
        return error == kAudioServicesNoError;
    }
}

- (void)stop {
    AudioQueueStop(self.audioQueue, NO);
}

- (void)pause {
    AudioQueuePause(self.audioQueue);
}

- (NSTimeInterval)currentTime {
    AudioTimeStamp timeStamp;
    AudioQueueGetCurrentTime(self.audioQueue, NULL, &timeStamp, NULL);
    return timeStamp.mSampleTime / self.basicDescription.mSampleRate;
}

- (NSTimeInterval)totalTime {
    Float64 packetsPerSecond = self.basicDescription.mSampleRate / self.basicDescription.mFramesPerPacket;
    return self.totalPacketCount / packetsPerSecond;
}

- (void)startDownload {
    NSURLSession *downloadSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [downloadSession dataTaskWithURL:self.streamURL];
    [dataTask resume];
}

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    OSStatus error = AudioFileStreamParseBytes(self.streamID, data.length, data.bytes, 0);
    if (error) {
        NSLog(@"Error parsing bytes, error %i", (int)error);
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
        didCompleteWithError:(NSError *)error {
    NSLog(@"Error in downloading %@", error);
}

- (void)dealloc {
    if (self.streamID) {
        AudioFileStreamClose(self.streamID);
        self.streamID = nil;
    }
}

@end