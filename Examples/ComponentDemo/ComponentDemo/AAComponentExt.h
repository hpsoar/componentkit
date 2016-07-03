//
//  AAComponentExt.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AACollectionModel.h"
#import "CKComponent+HostingView.h"

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
+ (instancetype)newWithView:(const CKComponentViewConfiguration &)view
                     insets:(UIEdgeInsets)insets
                      child:(const CKComponentChild &)child;

@end

#pragma mark - CKCompositeComponent

@interface CKCompositeComponent (Util)

+ (instancetype)newWithChild:(const CKComponentChild &)child;
+ (instancetype)newWithView:(const CKComponentViewConfiguration &)view
                      child:(const CKComponentChild &)child;

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

struct CKButtonComponentConfig {
    std::unordered_map<UIControlState, NSString *> titles;
    std::unordered_map<UIControlState, UIColor *> titleColors;
    std::unordered_map<UIControlState, UIImage *> images;
    std::unordered_map<UIControlState, NSString *> imageNames;
    std::unordered_map<UIControlState, UIImage *> backgroundImages;
    std::unordered_map<UIControlState, NSString *> backgroundImageNames;
    CKViewComponentAttributeValueMap view;
    CKComponentAction action;
    CKComponentSize size;
    CKButtonComponentAccessibilityConfiguration accessibility;
    UIFont *titleFont;
    BOOL disabled;
    BOOL selected;
};

@interface CKButtonComponent (Util)

+ (instancetype)newWithConfig:(const CKButtonComponentConfig &)config;

@end
