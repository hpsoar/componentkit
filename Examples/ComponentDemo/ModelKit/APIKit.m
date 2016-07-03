//
//  APIKit.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "APIKit.h"

@implementation APIResult


@end

@implementation APIOptions

+ (instancetype)newWithAPI:(NSString *)API {
    return [self newWithAPI:API method:@"GET" timeout:10];
}

+ (instancetype)newWithAPI:(NSString *)API method:(NSString *)method timeout:(NSTimeInterval)timeout {
    APIOptions *options = [self new];
    options.API = API;
    options.method = method;
    options.timeout = timeout;
    return options;
}

@end