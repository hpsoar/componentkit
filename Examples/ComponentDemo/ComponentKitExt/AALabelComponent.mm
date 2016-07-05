//
//  AALabelComponent.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/5/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "AALabelComponent.h"

@interface AALabel ()
@property(nonatomic, strong) UIView *a;
@property(nonatomic, strong) UIView *b;
@property(nonatomic, strong) UIView *c;
@property(nonatomic, strong) UIView *d;
@end
@implementation AALabel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.a = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        self.b = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        self.c = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        self.d = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        [self addSubview:self.a];
        [self addSubview:self.b];
        [self addSubview:self.c];
        [self addSubview:self.d];
        self.a.backgroundColor = [UIColor redColor];
        self.b.backgroundColor = [UIColor greenColor];
        self.c.backgroundColor = [UIColor blueColor];
        self.d.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)setCenter:(CGPoint)center {    
    BOOL hasChinese = self.shiftAsChineseString;
    
//    self.a.frame = CGRectMake(0, 0, 20, self.font.ascender - self.font.descender);
//    self.b.frame = CGRectMake(20, 0, 20, self.font.ascender);
//    self.c.frame = CGRectMake(40, self.font.ascender - self.font.capHeight, 20, self.font.capHeight);
    
    if (self.detectChineseOnShift && !self.shiftAsChineseString) {
        hasChinese = [self hasChinese];
    }
    hasChinese = NO;
    
    CGFloat topMargin = 0;
    CGFloat bottomMargin = 0;
    
    if (hasChinese) {
        topMargin = (self.font.lineHeight - self.font.ascender) / 2;
        bottomMargin = topMargin;
    }
    else {
        topMargin = self.font.ascender - self.font.capHeight;
        bottomMargin = -self.font.descender;
    }
    
    if (self.shiftType == LabelShiftTypeBottom) {
        center.y += bottomMargin;
    }
    else if (self.shiftType == LabelShiftTypeTop) {
        center.y -= topMargin;
    }
    [super setCenter:center];
}

- (BOOL)hasChinese {
    NSString *str = self.text;
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

@end

@interface AALabelComponentConfigWrapper : NSObject

@property (nonatomic) AALabelComponentConfig config;

@end

@implementation AALabelComponentConfigWrapper


@end

@implementation AALabelComponent {
    CGSize _intrinsicSize;
}

+ (instancetype)newWithLabelAttributes:(const CKLabelAttributes &)attributes
                        viewAttributes:(const CKViewComponentAttributeValueMap &)viewAttributes
                                  size:(const CKComponentSize &)size
{
    AALabelComponentConfig config = {
        .attributes = attributes,
        .viewAttributes = viewAttributes,
        .size = size,
        .shiftType = LabelShiftTypeBottom,
        .detectChineseOnShift = YES,
    };
    return [self newWithConfig:config];
}

+ (instancetype)newWithConfig:(const AALabelComponentConfig &)config {
    //    static const CKComponentViewAttribute titleFontAttribute = {"CKButtonComponent.titleFont", ^(UIButton *button, id value){
    //        button.titleLabel.font = value;
    //    }};
    
    static const CKComponentViewAttribute configurationAttribute = {
        "AALabelComponent.config",
        ^(AALabel *view, AALabelComponentConfigWrapper *wrapper) {
            const AALabelComponentConfig &config = wrapper.config;
            view.font = config.attributes.font;
            view.textColor = config.attributes.color;
            view.text = config.attributes.string;
            view.shiftType = config.shiftType;
            view.detectChineseOnShift = config.detectChineseOnShift;
        },
        // No unapplicator.
        nil,
        nil
        //        ^(AALabel *view, AALabelComponentConfig *oldConfig, AALabelComponentConfig *newConfig) {
        //        }
    };
    
    AALabelComponentConfigWrapper *wrapper = [AALabelComponentConfigWrapper new];
    wrapper.config = config;
    
    CKViewComponentAttributeValueMap vAttrs(config.viewAttributes);
    vAttrs.insert({
        {configurationAttribute, wrapper },
    });
    
    AALabelComponent *c = [super newWithView:{ [AALabel class], std::move(vAttrs) } size:config.size];
    c.style = config.attributes;
    return c;
}

- (CKComponentLayout)computeLayoutThatFits:(CKSizeRange)constrainedSize
{
    _intrinsicSize = [self.style.string boundingRectWithSize:constrainedSize.max options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: self.style.font } context:nil].size;
    return {self, constrainedSize.clamp(_intrinsicSize)};
}

@end
