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
    return [self newWithView:config.view
                      insets:config.insets
                   component:config.component];
}

+ (instancetype)newWithView:(const CKComponentViewConfiguration &)view
                     insets:(UIEdgeInsets)insets
                      child:(const CKComponentChild &)child {
    return [self newWithView:view insets:insets component:child.component];
}

@end

@implementation CKCompositeComponent (Util)

+ (instancetype)newWithChild:(const CKComponentChild &)child {
    return [self newWithComponent:child.component];
}

+ (instancetype)newWithView:(const CKComponentViewConfiguration &)view
                      child:(const CKComponentChild &)child {
    return [self newWithView:view component:child.component];
}

@end

@implementation CKStackLayoutComponent (Util)

+ (instancetype)newWithConfig:(const CKStackLayoutComponentConfig &)config {
    return [self newWithView:config.view
                        size:config.size
                       style:config.style
                    children:config.children];
}

@end

@implementation CKButtonComponent (Util)

+ (instancetype)newWithConfig:(const CKButtonComponentConfig &)config {
    if (config.imageNames.size() > 0 ||
        config.backgroundImageNames.size() > 0) {
        CKButtonComponentConfig config0 = config;
        for (auto name : config.imageNames) {
            config0.images[name.first] = [UIImage imageNamed:name.second];
        }
        for (auto name : config.backgroundImageNames) {
            config0.backgroundImages[name.first] =
                [UIImage imageNamed:name.second];
        }
        return [self _newWithConfig:config0];
    } else {
        return [self _newWithConfig:config];
    }
}

+ (instancetype)_newWithConfig:(const CKButtonComponentConfig &)config {
    return [self newWithTitles:config.titles
                       titleColors:config.titleColors
                            images:config.images
                  backgroundImages:config.backgroundImages
                         titleFont:config.titleFont
                          selected:config.selected
                           enabled:!config.disabled
                            action:config.action
                              size:config.size
                        attributes:config.view
        accessibilityConfiguration:config.accessibility];
}

@end
