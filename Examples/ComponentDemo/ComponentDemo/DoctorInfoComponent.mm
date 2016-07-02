//
//  DoctorInfoComponent.m
//  ComponentDemo
//
//  Created by HuangPeng on 6/30/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "DoctorInfoComponent.h"

@interface TestButton : UIButton


@end

@implementation TestButton

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

@end

@interface DoctorNameTitleComponent : CKCompositeComponent

+ (instancetype)newWithDoctor:(DoctorModel *)doctor;

@end

@implementation DoctorNameTitleComponent

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

@implementation DoctorClinicHospitalComponent

+ (instancetype)newWithDoctor:(DoctorModel *)doctor {
    return [super newWithChild:{
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
            }
        }],
    }];
}

@end

@implementation DoctorInfoComponent

+ (instancetype)newWithDoctor:(DoctorModel *)doctor {
    return [super newWithChild:{
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
                        [UITextField class],
                        {
                            {@selector(setBackgroundColor:), [UIColor greenColor] },
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

+ (CKComponent *)componentForModel:(id)doctor context:(id<NSObject>)context {
    return [self newWithDoctor:doctor];
}

@end

@implementation DoctorModel (ComponentFactory)

- (CKComponent *)componentWithContext:(id<NSObject>)context {
    return [DoctorInfoComponent componentForModel:self context:context];
}

@end
