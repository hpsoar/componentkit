//
//  AALabelComponent.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/5/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <ComponentKit/ComponentKit.h>

typedef NS_ENUM(NSInteger, LabelShiftType) {
    LabelShiftTypeNone,
    LabelShiftTypeTop,
    LabelShiftTypeBottom,
};

@interface AALabel : UILabel

@property (nonatomic) LabelShiftType shiftType;
@property (nonatomic) BOOL detectChineseOnShift;
@property (nonatomic) BOOL shiftAsChineseString;

@end

struct AALabelComponentConfig {
    CKLabelAttributes attributes;
    CKViewComponentAttributeValueMap viewAttributes;
    CKComponentSize size;
    LabelShiftType shiftType;
    BOOL detectChineseOnShift;
    BOOL shiftAsChineseString;
};

@interface AALabelComponent : CKComponent

+ (instancetype)newWithLabelAttributes:(const CKLabelAttributes &)attributes
                        viewAttributes:(const CKViewComponentAttributeValueMap &)viewAttributes
                                  size:(const CKComponentSize &)size;

+ (instancetype)newWithConfig:(const AALabelComponentConfig &)config;

@property (nonatomic) CKLabelAttributes style;

@property (nonatomic, weak) UILabel *label;

@end
