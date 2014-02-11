//
//  ALObservationObject.m
//  ALModelManager
//
//  Created by HoJun Lee on 2014. 2. 11..
//  Copyright (c) 2014년 HoJun Lee. All rights reserved.
//

#import "ALObservationObject.h"

@implementation ALObservationObject

#pragma mark -
#pragma mark - Initilization
- (id)init
{
    self = [super init];
    if(self) {
        self.valid = YES;
    }
    return self;
}

- (void)dealloc
{
    if(self.valid) {
        [self invalidate];
    }
}

#pragma mark -
#pragma mark - Key Value Observing Overriding
- (void)observeValueForKeyPath:(NSString *)path
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if(self.valid && (__bridge id)context == self &&
       ![[change valueForKey:NSKeyValueChangeNewKey] isEqual:[change valueForKey:NSKeyValueChangeOldKey]]) {
        self.block(self.source, change);
    } else {
        [super observeValueForKeyPath:path ofObject:object change:change context:context];
    }
}

#pragma mark -
#pragma mark - Public Method Implement
- (void)invalidate
{
    self.valid = NO;
    [self.source removeObserver:self forKeyPath:self.keyPath];
}

- (void)invoke
{
    self.block(self.source, @{});
}

@end
