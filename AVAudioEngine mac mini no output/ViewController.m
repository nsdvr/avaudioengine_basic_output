//
//  ViewController.m
//  AVAudioEngine mac mini no output
//
//  Created by Jakob Penca on 14.12.18.
//  Copyright © 2018 Jakob Penca. All rights reserved.
//

#import "ViewController.h"
#import "Audio.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)playButtonPressed:(NSButton *)sender {
    [[Audio sharedInstance] play];
}

@end
