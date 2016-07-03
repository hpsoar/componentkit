//
//  AAModelOptions.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "AAModelKit.h"
#import <MJExtension.h>

@implementation AAModelOptions

+ (NSArray *)mj_ignoredPropertyNames {
    return @[ @"loadingStatus" ];
}

- (Class)modelClass {
    return nil;
}

- (void)reset {
    self.loadingStatus = AAModelLoadingStatusNone;
}

- (BOOL)canLoad {
    return self.loadingStatus != AAModelLoadingStatusLoading;
}

- (BOOL)failed {
    return self.loadingStatus == AAModelLoadingStatusFailed;
}

- (BOOL)loaded {
    return self.loadingStatus == AAModelLoadingStatusSucceed;    
}

@end

@implementation AAModelResult

+ (instancetype)newWithJSON:(id)JSON model:(id)model error:(NSError *)error {
    AAModelResult *result = [self new];
    result.JSON = JSON;
    result.error = error;
    result.model = model;
    return result;
}

@end

@implementation AAModelController {
    id<AAModelDataSource> _dataSource;
}

+ (instancetype)newWithDataSource:(id<AAModelDataSource>)dataSource {
    return [[self alloc] initWithDataSource:dataSource];
}

- (instancetype)initWithDataSource:(id<AAModelDataSource>)dataSource {
    self = [super init];
    if (self) {
        _dataSource = dataSource;
    }
    return self;
}

- (void)fetch:(AAModelOptions *)options callback:(void(^)(AAModelResult *result))callback {
    // request raw data
    [_dataSource fetch:options callback:^(id JSON, NSError *error) {
        // parse model
        id model = [self parseModel:JSON cls:[options modelClass]];
        
        // build result
        AAModelResult *result = [AAModelResult newWithJSON:JSON model:model error:error];
        
        // callback
        if (callback) {
            callback(result);
        }
    }];
}

// parse model
- (id)parseModel:(id)JSON cls:(Class)cls {
    if ([JSON isKindOfClass:[NSDictionary class]]) {
        return [cls mj_objectWithKeyValues:JSON];
    }
    else if ([JSON isKindOfClass:[NSArray class]]) {
        return [cls mj_objectArrayWithKeyValuesArray:JSON];
    }
    return nil;
}

@end

@implementation AAModelAPIOptions

+ (instancetype)newWithAPI:(NSString *)API {
    return [self newWithAPI:API method:@"GET" timeout:10];
}

+ (instancetype)newWithAPI:(NSString *)API method:(NSString *)method timeout:(NSTimeInterval)timeout {
    AAModelAPIOptions *options = [self new];
    options.API = API;
    options.method = method;
    options.timeout = timeout;
    return options;
}

@end

@implementation AAURLModelOptions

@end

@implementation AAURLModelDataSource

+ (instancetype)newWithAPI:(NSString *)API {
    return [self newWithAPI:API method:@"GET"];
}

+ (instancetype)newWithAPI:(NSString *)API method:(NSString *)method {
    return [self newWithOptions:[AAModelAPIOptions newWithAPI:API method:method timeout:10]];
}

+ (instancetype)newWithOptions:(AAModelAPIOptions *)apiOptions {
    AAURLModelDataSource *dataSource = [self new];
    dataSource.apiOptions = apiOptions;
    return dataSource;        
}

- (void)fetch:(AAModelOptions *)options callback:(void (^)(id, NSError *))callback {
    NSDictionary *parameters = [options mj_keyValues];
    // send request
}

@end
