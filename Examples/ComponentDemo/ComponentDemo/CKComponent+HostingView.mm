//
//  CKComponent+HostingView.m
//  ComponentDemo
//
//  Created by HuangPeng on 6/30/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKComponent+HostingView.h"

@implementation CKComponent (HostingView)

+ (CKComponentHostingView *)hostingView:(const CKComponentHostingViewConfig &)config {
    static id<CKComponentSizeRangeProviding> sizeRangeProvider = [CKComponentFlexibleSizeRangeProvider providerWithFlexibility:config.sizeRangeFlexibility];
    CKComponentHostingView *hostingView = [[CKComponentHostingView alloc] initWithComponentProvider:[self class]
                                                                                  sizeRangeProvider:sizeRangeProvider];
    hostingView.delegate = self;
    hostingView.frame = config.frame;
    return hostingView;
}

+ (CKComponent *)componentForModel:(id<NSObject>)model context:(id<NSObject>)context {
    return nil;
}

#pragma mark - CKComponentHostingViewDelegate <NSObject>
- (void)componentHostingViewDidInvalidateSize:(CKComponentHostingView *)hostingView {
    NSLog(@"componentHostingViewDidInvalidateSize");
    
}

@end
