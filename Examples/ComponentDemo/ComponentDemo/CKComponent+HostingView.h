//
//  CKComponent+HostingView.h
//  ComponentDemo
//
//  Created by HuangPeng on 6/30/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <ComponentKit/ComponentKit.h>
#import <ComponentKit/CKComponentHostingView.h>
#import <ComponentKit/CKComponentProvider.h>

@interface CKComponent (HostingView) <CKComponentProvider, CKComponentHostingViewDelegate>

+ (CKComponentHostingView *)hostingViewWithFrame:(CGRect)frame;

@end
