//
//  DoctorModel.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

@interface DoctorModel : NSObject

@property (nonatomic) NSInteger Id;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *clinic;
@property(nonatomic, copy) NSString *hospital;
@property(nonatomic, copy) NSString *goodAt;

@end

@interface DoctorListOptions : NSObject
@property (nonatomic) NSInteger page;
@property (nonatomic) NSInteger pageSize;
@end

@interface DoctorModelController : NSObject

- (void)fetchDoctors:(DoctorListOptions *)options
            callback:(void (^)(NSArray *doctors, NSError *error))callback;

@end

@interface MockDoctorModelController : DoctorModelController

@end