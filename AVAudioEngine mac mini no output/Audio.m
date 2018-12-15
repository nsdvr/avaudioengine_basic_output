//
//  Audio.m
//  AVAudioEngine mac mini no output
//
//  Created by Jakob Penca on 14.12.18.
//  Copyright © 2018 Jakob Penca. All rights reserved.
//

#import "Audio.h"
@import AVFoundation;

@interface Audio ()
@property (nonatomic) AVAudioEngine *engine;
@property (nonatomic) AVAudioPlayerNode *playerNode;
@property (nonatomic) AVAudioFile *audioFile;
@end

@implementation Audio

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static Audio *instance;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init {
    if(self = [super init]) {
        [self setup];
    }
    return self;
}

- (void) setup {
    self.engine = [AVAudioEngine new];
    self.playerNode = [AVAudioPlayerNode new];
    [self.engine attachNode:self.playerNode];
    [self.engine connect:self.playerNode to:self.engine.mainMixerNode format:nil];
    [self.engine prepare];
    NSError *err;
    [self.engine startAndReturnError:&err];
    if(err) {
        NSLog(@"AVAudioEngine start error: %@", err.localizedDescription);
    }
    
    NSError *fileErr;
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"HUUH" withExtension:@"wav"];
    self.audioFile = [[AVAudioFile alloc] initForReading:fileURL error:&fileErr];
    if(fileErr) {
        NSLog(@"error reading audio file");
        return;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(handleInterruption:)
                                                 name: AVAudioEngineConfigurationChangeNotification
                                               object: self.engine];
}

- (void) play {
    if(!self.audioFile) {
        NSLog(@"Can't play without audio file");
        return;
    }
    
    [self.playerNode scheduleFile:self.audioFile atTime:nil completionHandler:nil];
    [self.playerNode play];
}

- (void) handleInterruption:(NSNotification *) notification {
    NSLog(@"interruption");
    [self.engine stop];
    [self.engine startAndReturnError:nil];
}

@end
