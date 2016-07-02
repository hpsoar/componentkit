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

@implementation DoctorInfoComponent

+ (instancetype)newWithDoctor:(DoctorModel *)doctor {
    return [super newWithChild:{
        [CKInsetComponent newWithView:{} insets:UIEdgeInsetsMake(5, 10, 5, 10) child:{
            [CKStackLayoutComponent newWithView:{} size:{} style:{
                .spacing = 8,
            }children:{
                {   // name & title
                    .component = [CKStackLayoutComponent newWithView:{} size:{} style:{
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
                },
                {
                    // clinic & hospital
                    .component = [CKStackLayoutComponent newWithView:{} size:{} style:{
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
