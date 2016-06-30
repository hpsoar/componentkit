//
//  DoctorInfoComponent.h
//  ComponentDemo
//
//  Created by HuangPeng on 6/30/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <ComponentKit/ComponentKit.h>

@interface DoctorModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *clinic;
@property (nonatomic, copy) NSString *hospital;
@property (nonatomic, copy) NSString *goodAt;

@end

@interface DoctorInfoComponent : CKCompositeComponent

+ (instancetype)newWithDoctor:(DoctorModel *)doctor;


@end
