//
//  AAStackNode.m
//  ComponentKit
//
//  Created by HuangPeng on 6/30/16.
//
//

#import "AAStackNode.h"

@implementation AAStackNode

+ (instancetype)node:(const AAStackNodeConfig &)config {
    return [super newWithView:{} size:config.size style:config.style children:config.children];
}

@end
