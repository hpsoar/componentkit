//
//  AAComponentExt.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CKComponent+HostingView.h"
#import "AACollectionModel.h"

#pragma mark - CKInsetComponent

struct CKComponentChild {
    CKComponent *component;
};

struct CKInsetComponentConfig {
    CKComponentViewConfiguration view;
    UIEdgeInsets insets;
    CKComponent *component;
};

@interface CKInsetComponent (Util)

+ (instancetype)newWithConfig:(const CKInsetComponentConfig &)config;
+ (instancetype)newWithView:(const CKComponentViewConfiguration &)view insets:(UIEdgeInsets)insets child:(const CKComponentChild &)child;

@end

#pragma mark - CKCompositeComponent

@interface CKCompositeComponent (Util)

+ (instancetype)newWithChild:(const CKComponentChild &)child;

@end


#pragma mark - CKStackLayoutComponent

/*
 + (instancetype)newWithView:(const CKComponentViewConfiguration &)view
 size:(const CKComponentSize &)size
 style:(const CKStackLayoutComponentStyle &)style
 children:(const std::vector<CKStackLayoutComponentChild> &)children;
 */

struct CKStackLayoutComponentConfig {
    CKComponentViewConfiguration view;
    CKComponentSize size;
    CKStackLayoutComponentStyle style;
    std::vector<CKStackLayoutComponentChild> children;
};

@interface CKStackLayoutComponent (Util)

+ (instancetype)newWithConfig:(const CKStackLayoutComponentConfig &)config;

@end


