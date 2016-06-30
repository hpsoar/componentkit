//
//  DoctorInfoComponent.m
//  ComponentDemo
//
//  Created by HuangPeng on 6/30/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "DoctorInfoComponent.h"

@implementation DoctorModel


@end

@implementation DoctorInfoComponent

+ (instancetype)newWithDoctor:(DoctorModel *)doctor {
    return [super newWithComponent:[CKInsetComponent newWithInsets:UIEdgeInsetsMake(5, 10, 5, 10) component:[CKStackLayoutComponent newWithView:{} size:{} style:{
        .spacing = 8,
    } children:{
        {
            // name & title
            .component = [CKStackLayoutComponent newWithView:{} size:{} style:{
                .direction = CKStackLayoutDirectionHorizontal,
                .spacing = 5,
                .alignItems = CKStackLayoutAlignItemsEnd,
            } children:{
                {
                    {   // name
                        .component = [CKLabelComponent newWithLabelAttributes:{
                            .string = doctor.name,
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
                .maximumNumberOfLines = 2,
                .truncationString = @"...",
                .lineHeightMultiple = 1.2,
            }viewAttributes:{} size:{}],
        }
    }]]];
}

@end
