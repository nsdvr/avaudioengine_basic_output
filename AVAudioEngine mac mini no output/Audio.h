//
//  Audio.h
//  AVAudioEngine mac mini no output
//
//  Created by Jakob Penca on 14.12.18.
//  Copyright © 2018 Jakob Penca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Audio : NSObject
+ (instancetype) sharedInstance;
- (void) play;
@end

NS_ASSUME_NONNULL_END
