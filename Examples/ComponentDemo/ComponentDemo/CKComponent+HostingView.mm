//
//  CKComponent+HostingView.m
//  ComponentDemo
//
//  Created by HuangPeng on 6/30/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKComponent+HostingView.h"

@implementation CKComponent (HostingView)

+ (CKComponentHostingView *)hostingViewWithFrame:(CGRect)frame {
    static id<CKComponentSizeRangeProviding> sizeRangeProvider = [CKComponentFlexibleSizeRangeProvider providerWithFlexibility:CKComponentSizeRangeFlexibleHeight];
    CKComponentHostingView *hostingView = [[CKComponentHostingView alloc] initWithComponentProvider:[self class]
                                                                                  sizeRangeProvider:sizeRangeProvider];
    hostingView.delegate = self;
    hostingView.frame = frame;
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
