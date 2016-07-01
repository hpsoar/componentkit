//
//  AAModelOptions.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "AAModelOptions.h"
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

- (void)updateWithJSON:(id)JSON error:(NSError *)error modelClass:(Class)cls {
    self.JSON = JSON;
    self.error = error;
    if (JSON && cls) {
        self.model = [self parseJSON:JSON cls:cls];
    }
}

- (id)parseJSON:(id)JSON cls:(Class)cls {
    if ([JSON isKindOfClass:[NSDictionary class]]) {
        return [cls mj_objectWithKeyValues:JSON];
    }
    else if ([JSON isKindOfClass:[NSArray class]]) {
        return [cls mj_objectArrayWithKeyValuesArray:JSON];
    }
    return nil;
}

@end

@implementation AAModelController {
    id<AAModelDataSource> _dataSource;
}

- (instancetype)initWithDataSource:(id<AAModelDataSource>)dataSource {
    self = [super init];
    if (self) {
        _dataSource = dataSource;
    }
    return self;
}

- (void)fetch:(AAModelOptions *)options callback:(void(^)(AAModelResult *result))callback {
    // 请求数据
    [_dataSource fetch:options callback:^(id JSON, NSError *error) {
        // 构造结果
        AAModelResult *result = [AAModelResult new];
        [result updateWithJSON:JSON error:error modelClass:[options modelClass]];
        
        // callback
        if (callback) {
            callback(result);
        }
    }];
}

@end

@implementation AAURLModelDataSource

- (instancetype)initWithAPI:(NSString *)API method:(NSString *)method timeout:(NSTimeInterval)timeout {
    self = [super init];
    if (self) {
        self.API = API;
        self.method = method;
        self.timeout = timeout;
    }
    return self;
}

- (instancetype)initWithAPI:(NSString *)API {
    return [self initWithAPI:API method:@"GET" timeout:10];
}

- (void)fetch:(AAModelOptions *)options callback:(void (^)(id, NSError *))callback {
    NSDictionary *parameters = [options mj_keyValues];
    // send request
}

@end
