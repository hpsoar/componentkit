//
//  AAComponentExt.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "AAComponentExt.h"

@implementation CKInsetComponent (Util)

+ (instancetype)newWithConfig:(const CKInsetComponentConfig &)config {
    return [self newWithView:config.view insets:config.insets component:config.component];
}

+ (instancetype)newWithView:(const CKComponentViewConfiguration &)view insets:(UIEdgeInsets)insets child:(const CKComponentChild &)child {
    return [self newWithView:view insets:insets component:child.component];
}

@end

@implementation CKCompositeComponent (Util)

+ (instancetype)newWithChild:(const CKComponentChild &)child {
    return [self newWithComponent:child.component];
}

@end

@implementation CKStackLayoutComponent (Util)

+ (instancetype)newWithConfig:(const CKStackLayoutComponentConfig &)config {
    return [self newWithView:config.view size:config.size style:config.style children:config.children];
}

@end