//
//  TSAudioPlayer.m
//  TSAudioPlayer
//
//  Created by Tobias Sundstrand on 2014-08-24.
//
//

#import "TSAudioPlayer.h"

@interface TSAudioPlayer () <NSURLSessionDownloadDelegate>
@property (nonatomic, strong)NSMutableArray *outputStreams;
@property AudioQueueRef audioQueue;
@property NSInputStream *inputStream;

@property(nonatomic, strong) NSURLSession *backgroundSession;
@property(nonatomic, strong) NSOperationQueue *delegateQueue;
@property NSURLSessionDownloadTask *downloadTask;


@end

@implementation TSAudioPlayer

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if(self) {
        _downloadTask = [self.backgroundSession downloadTaskWithURL:url];
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
        _backgroundSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration backgroundSessionConfiguration:@"TSAudioPlayer"] delegate:self delegateQueue:self.delegateQueue];
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
    [self.downloadTask resume];
}

- (void)pause {

}

- (void)stop {

}
#pragma mark - URLSession delegate methods

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
        totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {

}

- (void)URLSession:(NSURLSession *)session
                     downloadTask:(NSURLSessionDownloadTask *)downloadTask
        didFinishDownloadingToURL:(NSURL *)location {

}
@end
