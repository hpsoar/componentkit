//
//  AAStackNode.h
//  ComponentKit
//
//  Created by HuangPeng on 6/30/16.
//
//

#import <ComponentKit/ComponentKit.h>

struct AAStackNodeConfig {
    const std::vector<CKStackLayoutComponentChild> children;
    CKStackLayoutComponentStyle style;
    CKComponentSize size;
};

@interface AAStackNode : CKStackLayoutComponent

+ (instancetype)node:(const AAStackNodeConfig &)config;

@end
