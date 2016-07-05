//
//  UIVew+AAKit.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/5/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AAKit)

+ (instancetype)newWithProps:(NSArray *)props;

- (void)aa_setProps:(NSArray *)props;

@end

@interface AAViewProp : NSObject <NSCopying>

+ (instancetype)newWithSelector:(SEL)selector;

- (instancetype)apply:(id)v;

@property (nonatomic, copy) id (^bind)(id value);
@property (nonatomic, copy) id (^bindFloat)(float value);
@property (nonatomic, copy) id (^bindBool)(BOOL value);
@property (nonatomic, copy) id (^bindInt)(NSInteger value);
@property (nonatomic, copy) id (^bindFontSize)(float fontSize);
@property (nonatomic, copy) id (^bindHexColor)(NSInteger color);

@property (nonatomic) SEL selector;
@property (nonatomic, strong) id value;
@property (nonatomic, strong) id value1;

@end

@interface AALayerProp : AAViewProp


@end

AALayerProp *aa_layerProp(SEL selector);
AAViewProp *aa_viewProp(SEL selector);

#define layerProp(sel) aa_layerProp(@selector(sel))
#define viewProp(sel) aa_viewProp(@selector(sel))

extern AAViewProp *viewPropBackColor;
extern AAViewProp *viewPropClipToBounds;

extern AAViewProp *labelPropFont;
extern AAViewProp *labelPropFontSize;
extern AAViewProp *labelPropTextColor;
extern AAViewProp *labelPropTextHexColor;
extern AAViewProp *labelPropNumberOfLines;
extern AAViewProp *labelPropLineBreak;

extern AAViewProp *btnPropTitle;
extern AAViewProp *btnPropTitleColor;
extern AAViewProp *btnPropTitleHexColor;
extern AAViewProp *btnPropImage;
extern AAViewProp *btnPropBackImage;
extern AAViewProp *btnPropSelected;
extern AAViewProp *btnPropEnabled;
extern AAViewProp *btnPropAction;

extern AALayerProp *layerPropMaskToBounds;
extern AALayerProp *layerPropCornerRadius;
extern AALayerProp *layerPropBorderColor;
extern AALayerProp *layerPropBorderWidth;

extern AALayerProp *layerPropShadowOffset;
extern AALayerProp *layerPropShadowSize;
extern AALayerProp *layerPropShadowColor;
extern AALayerProp *layerPropShadowOpacity;
