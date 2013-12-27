//
//  AppDelegate.m
//  Memory Gobble
//
//  Created by Slipp D. on 12/6/13.
//  Copyright (c) 2013 Slipp D. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () {
	size_t _gobbledTotalMiB;
	
	NSPointerArray *_mallocedPtrs;
}

@property (copy, readonly) NSString *gobbledTotalMiBText;

@end


@implementation AppDelegate

- (NSString *)gobbledTotalMiBText {
	return [NSString stringWithFormat:@"%zu MiB", _gobbledTotalMiB];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	_gobbledTotalMiB = 0;
	_mallocedPtrs = [[NSPointerArray alloc] initWithOptions:NSPointerFunctionsOpaqueMemory];
	
	// Insert code here to initialize your application
	
	self.totalGobbledLabel.stringValue = self.gobbledTotalMiBText;
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
	for (NSInteger ptrI = _mallocedPtrs.count - 1; ptrI >= 0; ptrI--) {
		void *ptr = [_mallocedPtrs pointerAtIndex:ptrI];
		free(ptr);
		[_mallocedPtrs replacePointerAtIndex:ptrI withPointer:NULL];
	}
	[_mallocedPtrs release];
	_mallocedPtrs = nil;
}

- (IBAction)gobble:(id)sender
{
	int gobbleMiBs = self.sizeField.intValue;
	if (gobbleMiBs <= 0)
		return;
	
	static const size_t kMiBInBytes = 1024 * 1024;
	
	void *mallocedPtr = calloc(gobbleMiBs, kMiBInBytes);
	if (mallocedPtr != NULL) {
		for (int gobbleI = 0; gobbleI < gobbleMiBs; ++gobbleI) {
			for (int byteI = 0; byteI < kMiBInBytes; ++byteI) {
				char randByte = rand() % 256;
				*(char *)(mallocedPtr + (gobbleI * kMiBInBytes) + byteI) = randByte;
			}
		}
		
		[_mallocedPtrs addPointer:mallocedPtr];
		
		_gobbledTotalMiB += gobbleMiBs;
		self.totalGobbledLabel.stringValue = self.gobbledTotalMiBText;
	}
}

@end
