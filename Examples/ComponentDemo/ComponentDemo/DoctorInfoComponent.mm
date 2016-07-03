//
//  DoctorInfoComponent.m
//  ComponentDemo
//
//  Created by HuangPeng on 6/30/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "DoctorInfoComponent.h"
#import <ComponentKit/CKComponentSubclass.h>

@interface DoctorNameTitleComponent : CKCompositeComponent

+ (instancetype)newWithDoctor:(DoctorModel *)doctor;

@end

@implementation DoctorNameTitleComponent {
    
}

+ (instancetype)newWithDoctor:(DoctorModel *)doctor {
    return [super newWithChild:{
        [CKStackLayoutComponent newWithView:{} size:{} style:{
            .direction = CKStackLayoutDirectionHorizontal,
            .spacing = 5,
            .alignItems = CKStackLayoutAlignItemsEnd,
        } children:{
            {   // name
                .component = [CKLabelComponent newWithLabelAttributes:{
                    .string = [NSString stringWithFormat:@"%zi %@", doctor.Id, doctor.name],
                    .font = [UIFont systemFontOfSize:16],
                    .color = [UIColor redColor],
                } viewAttributes:{} size:{}],
            },
            {   // title
                .component = [CKLabelComponent newWithLabelAttributes:{
                    .string = doctor.title,
                    .font = [UIFont systemFontOfSize:12],
                    .color = [UIColor blueColor],
                }viewAttributes:{} size:{}],
            }
        }],
    }];
}

@end

@interface DoctorClinicHospitalComponent : CKCompositeComponent

+ (instancetype)newWithDoctor:(DoctorModel *)doctor;

@end

@implementation DoctorClinicHospitalComponent {
    DoctorModel *_doctor;
}

+ (id)initialState {
    return @NO;
}

+ (instancetype)newWithDoctor:(DoctorModel *)doctor {
    CKComponentScope scope(self);
    
    DoctorClinicHospitalComponent *c = [super newWithChild:{
        [CKStackLayoutComponent newWithView:{} size:{} style:{
            .direction = CKStackLayoutDirectionHorizontal,
            .spacing = 5,
            .alignItems = CKStackLayoutAlignItemsEnd,
        }children:{
            {
                // clinic
                .component = [CKLabelComponent newWithLabelAttributes:{
                    .string = doctor.clinic,
                    .font = [UIFont systemFontOfSize:12],
                    .color = [UIColor blackColor],
                }viewAttributes:{} size:{}],
            },
            {
                // hospital
                .component = [CKLabelComponent newWithLabelAttributes:{
                    .string = doctor.hospital,
                    .font = [UIFont systemFontOfSize:12],
                    .color = [UIColor blackColor],
                }viewAttributes:{} size:{}]
            },           
            {
                .component = [CKButtonComponent newWithTitles:{
                    { UIControlStateNormal, @"hello" },
                }titleColors:{
                    { UIControlStateNormal, [UIColor greenColor], }
                }images:{} backgroundImages:{} titleFont:{} selected:NO enabled:YES action:@selector(tap:) size:{
                    .width = 80,
                    .height = 30
                } attributes:{
                    { @selector(setBackgroundColor:), [UIColor lightGrayColor] },
                    { CKComponentViewAttribute::LayerAttribute(@selector(setCornerRadius:)), @4 },
                } accessibilityConfiguration:{}]
            }
        }],
    }];
    
    c->_doctor = doctor;
    
    return c;
}

- (void)tap:(id)sender {
    _doctor.goodAt = [MockDoctorModelDataSource randomGoodAt];
    [self updateState:^id(id oldState) {
        return [oldState boolValue] ? @NO : @YES;
    } mode:CKUpdateModeAsynchronous];
}

@end

@implementation DoctorInfoComponent

+ (instancetype)newWithDoctor:(DoctorModel *)doctor {
    CKComponentScope scope(self);
    
    return [super newWithView:{
        [UIView class],
        {
            { @selector(setBackgroundColor:), [UIColor whiteColor] },
            { @selector(setClipsToBounds:), YES },
        }
    } child:{
        [CKInsetComponent newWithView:{} insets:UIEdgeInsetsMake(5, 10, 5, 10) child:{
            [CKStackLayoutComponent newWithView:{} size:{} style:{
                .spacing = 8,
            }children:{
                {   // name & title
                    .component = [DoctorNameTitleComponent newWithDoctor:doctor],
                },
                {
                    // clinic & hospital
                    .component = [DoctorClinicHospitalComponent newWithDoctor:doctor],
                },
                {
                    // good at
                    .component = [CKLabelComponent newWithLabelAttributes:{
                        .string = doctor.goodAt,
                        .font = [UIFont systemFontOfSize:12],
                        .color = [UIColor grayColor],
                        .maximumNumberOfLines = 4,
                        .truncationString = @"...",
                        .lineHeightMultiple = 1.2,
                    }viewAttributes:{} size:{}],
                },
                {
                    .component = [CKComponent newWithView:{
                        [UIView class],
                        {
                            {@selector(setBackgroundColor:), [UIColor greenColor] },
                        },
                        {
                            .isAccessibilityElement = @(YES),
                            .accessibilityIdentifier = [NSString stringWithFormat:@"%@ %zi", doctor.name, doctor.Id],
                        }
                        } size:{
                            .width = 300,
                            .height = 40,
                        }],
                }
            }]
        }]
    }];
}

- (std::vector<CKComponentAnimation>)animationsFromPreviousComponent:(DoctorInfoComponent *)previousComponent
{
    return {{ previousComponent, scaleToAppear() }};
}

static CAAnimation *scaleToAppear()
{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)];
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    scale.duration = 0.2;
    return scale;
}

+ (CKComponent *)componentForModel:(id)doctor context:(id<NSObject>)context {
    return [self newWithDoctor:doctor];
}

@end

@implementation DoctorModel (ComponentFactory)

- (CKComponent *)componentWithContext:(id<NSObject>)context {
    return [DoctorInfoComponent componentForModel:self context:context];
}

@end
