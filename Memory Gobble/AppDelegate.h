//
//  AppDelegate.h
//  Memory Gobble
//
//  Created by Slipp D. on 12/6/13.
//  Copyright (c) 2013 Slipp D. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (retain) IBOutlet NSTextField *totalGobbledLabel;
@property (retain) IBOutlet NSTextField *sizeField;
- (IBAction)gobble:(id)sender;

@end
