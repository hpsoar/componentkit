//
//  UIVew+AAKit.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/5/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "UIView+AAKit.h"

@implementation UIView (AAKit)

+ (instancetype)newWithProps:(NSArray *)props {
    UIView *v = [self new];
    [v aa_setProps:props];
    return v;
}

- (void)aa_setProps:(NSArray *)props {
    [props enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj apply:self];
    }];
}

- (instancetype)aa_addSubviews:(NSArray *)subviews {
    [subviews enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx,
                                           BOOL *_Nonnull stop) {
        [self addSubview:obj];
    }];
    return self;
}

@end

@implementation AAViewProp

+ (instancetype)newWithSelector:(SEL)selector {
    AALayerProp *p = [self new];
    p.selector = selector;
    return p;
}

- (id)copyWithZone:(NSZone *)zone {
    AALayerProp *p = [[self class] newWithSelector:self.selector];
    return p;
}

- (instancetype)apply:(id)v {
    if ([v isKindOfClass:[UIView class]]) {
        if ([v respondsToSelector:self.selector]) {
            [v performSelector:self.selector withObject:self.value];
        }
    }
    else {
        NSLog(@"%@ is not supported", v);
    }
    return self;
}

- (id(^)(id))bind {
    return ^(id value) {
        self.value = value;
        return self;
    };
}

- (id(^)(float))bindFloat {
    return ^(float value) {
        self.value = @(value);
        return self;
    };
}

- (id(^)(BOOL))bindBool {
    return ^(BOOL value) {
        self.value = @(value);
        return self;
    };
}

- (id(^)(NSInteger))bindInt {
    return ^(NSInteger value) {
        self.value = @(value);
        return self;
    };
}

- (id(^)(float))bindFontSize {
    return ^(float fontSize) {
        self.value = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

- (id(^)(NSInteger))bindHexColor {
    return ^(NSInteger hexColor) {
        int r = (hexColor & 0xff0000) >> 16;
        int g = (hexColor & 0xff00) >> 8;
        int b = hexColor & 0xff;
        self.value = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b/255.0 alpha:1];
        return self;
    };
}

@end

@implementation AALayerProp

- (instancetype)apply:(id)v {
    if ([v isKindOfClass:[UIView class]]) {
        return [self apply:[v layer]];
    }
    else if ([v isKindOfClass:[CALayer class]]) {
        if ([v respondsToSelector:self.selector]) {
            [v performSelector:self.selector withObject:self.value];
        }
    }
    else {
        NSLog(@"%@ is not supported", v);
    }
    
    return self;
}

@end

AALayerProp *aa_layerProp(SEL selector) {
    AALayerProp *prop = [AALayerProp newWithSelector:selector];
    return prop;
}

AAViewProp *aa_viewProp(SEL selector) {
    AAViewProp *prop = [AAViewProp newWithSelector:selector];
    return prop;
}

AAViewProp *viewPropBackColor;
AAViewProp *viewPropClipToBounds;

AAViewProp *labelPropFont;
AAViewProp *labelPropFontSize;
AAViewProp *labelPropTextColor;
AAViewProp *labelPropTextHexColor;
AAViewProp *labelPropNumberOfLines;
AAViewProp *labelPropLineBreak;

AAViewProp *btnPropTitle;
AAViewProp *btnPropTitleColor;
AAViewProp *btnPropTitleHexColor;
AAViewProp *btnPropImage;
AAViewProp *btnPropBackImage;
AAViewProp *btnPropSelected;
AAViewProp *btnPropEnabled;
AAViewProp *btnPropAction;

AALayerProp *layerPropMaskToBounds;
AALayerProp *layerPropCornerRadius;
AALayerProp *layerPropBorderColor;
AALayerProp *layerPropBorderWidth;

AALayerProp *layerPropShadowOffset;
AALayerProp *layerPropShadowSize;
AALayerProp *layerPropShadowColor;
AALayerProp *layerPropShadowOpacity;
