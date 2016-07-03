//
//  CKComponent+HostingView.h
//  ComponentDemo
//
//  Created by HuangPeng on 6/30/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <ComponentKit/ComponentKit.h>

struct CKComponentHostingViewConfig {
    CKComponentSizeRangeFlexibility sizeRangeFlexibility;
    CGRect frame;
};

@interface CKComponent (HostingView) <CKComponentProvider, CKComponentHostingViewDelegate>

+ (CKComponentHostingView *)hostingView:(const CKComponentHostingViewConfig &)config;

@end
