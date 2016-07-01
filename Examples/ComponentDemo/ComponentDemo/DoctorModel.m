//
//  DoctorModel.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "DoctorModel.h"


@implementation DoctorModel

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    return [propertyName mj_underlineFromCamel];
}

@end

@implementation DoctorListOptions

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    return [propertyName mj_underlineFromCamel];
}

- (Class)modelClass {
    return [DoctorModel class];
}

- (void)reset {
    [super reset];
    self.page = 0;
}

@end

@implementation MockDoctorModelDataSource

- (void)fetch:(AAModelOptions *)options callback:(void (^)(id, NSError *))callback {
    DoctorListOptions *doctorListOptions = (DoctorListOptions *)options;
    
    NSArray *names = @[@"张三", @"李四", @"王麻子", ];
    NSArray *titles = @[ @"主任医师", @"副主任医师", @"院长" ];
    NSArray *clinics = @[ @"内科", @"外科", @"骨科", @"神经科", @"内分泌科", @"眼科", @"牙科" ];
    NSArray *hospitals = @[ @"北医三院", @"校医院", @"协和医院", @"同济医院" ];
    NSArray *goodAts = @[ @"吃饭、睡觉、打豆豆", @"无所不会、无所不能", @"什么都不会。" ];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:20];
    NSInteger dataCount = names.count * titles.count * clinics.count * goodAts.count * 5;
    if (doctorListOptions.pageSize * doctorListOptions.page < dataCount) {
        for (NSInteger i = 0; i < doctorListOptions.pageSize; ++i) {
            NSDictionary *d = @{ @"id": @(doctorListOptions.page * 20 + i),
                                 @"name": names[arc4random() % 3],
                                 @"title": titles[arc4random() % 3],
                                 @"clinic": clinics[arc4random() % 7],
                                 @"hospital": hospitals[arc4random() % 4],
                                 @"good_at": goodAts[arc4random() % 3],
                                };
            [result addObject:d];
        }
    }
    
    if (callback) {
        callback(result, nil);
    }
}

@end

@implementation DoctorModel (API)

+ (DoctorListOptions *)doctorListOptions {
    DoctorListOptions *options = [DoctorListOptions new];
    options.pageSize = 20;
    return options;
}

+ (AAModelController *)mockDoctorListController {
    return [[AAModelController alloc] initWithDataSource:[MockDoctorModelDataSource new]];
}

+ (AAModelController *)doctorListController {
    AAURLModelDataSource *dataSource = [[AAURLModelDataSource alloc] initWithAPI:@"/api/doctor/list/"];
    return [[AAModelController alloc] initWithDataSource:dataSource];
}

@end