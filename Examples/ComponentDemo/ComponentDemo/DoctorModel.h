//
//  DoctorModel.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
#import "AAModelOptions.h"

@interface DoctorModel : NSObject

@property (nonatomic) NSInteger Id;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *clinic;
@property(nonatomic, copy) NSString *hospital;
@property(nonatomic, copy) NSString *goodAt;

@end

@interface DoctorListOptions : AAModelOptions
@property (nonatomic) NSInteger page;
@property (nonatomic) NSInteger pageSize;
@end

@interface MockDoctorModelDataSource : NSObject <AAModelDataSource>

@end

@interface DoctorModel (API)

+ (DoctorListOptions *)doctorListOptions;
+ (AAModelController *)mockDoctorListController;
+ (AAModelController *)doctorListController;
   
@end
