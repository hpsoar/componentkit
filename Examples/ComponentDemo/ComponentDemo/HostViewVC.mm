//
//  HostViewVC.m
//  ComponentDemo
//
//  Created by HuangPeng on 6/30/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "HostViewVC.h"
#import <ComponentKit/CKComponentProvider.h>
#import <ComponentKit/CKComponentHostingView.h>
#import "DoctorInfoComponent.h"

@interface HostViewVC ()  < CKComponentProvider, CKComponentHostingViewDelegate >

@end

@implementation HostViewVC {
    CKComponentDataSource *_componentDataSource;
    CKComponentFlexibleSizeRangeProvider *_sizeRangeProvider;
    DoctorModel *_doctor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _sizeRangeProvider = [CKComponentFlexibleSizeRangeProvider providerWithFlexibility:CKComponentSizeRangeFlexibleHeight];
    CKComponentHostingView *hostingView = [[CKComponentHostingView alloc] initWithComponentProvider:[self class]
                                                                                  sizeRangeProvider:_sizeRangeProvider];
    hostingView.delegate = self;
    
    CGSize size = [hostingView sizeThatFits:CGSizeMake(self.view.frame.size.width, FLT_MAX)];
    hostingView.frame = CGRectMake(0, 100, size.width, size.height);    
    [self.view addSubview:hostingView];
    
    _doctor = [DoctorModel new];
    _doctor.name = @"张三";
    _doctor.title = @"主任医师";
    _doctor.clinic = @"内科";
    _doctor.hospital = @"北医三院";
    _doctor.goodAt = @"你好SD罚点啥发生的发生的发生的发撒的发水电费撒旦法的说法的说法艺术硕士艺术硕士艺术硕士爱迪生发生的发撒的发水电费大师发生的发生的发生的发生的发生的4333333333";
    [hostingView updateModel:_doctor mode:CKUpdateModeAsynchronous];
}

#pragma mark - CKComponentProvider

+ (CKComponent *)componentForModel:(id<NSObject>)story context:(id<NSObject>)context {
    return [DoctorInfoComponent newWithDoctor:story];
}

#pragma mark - CKComponentHostingViewDelegate <NSObject>
- (void)componentHostingViewDidInvalidateSize:(CKComponentHostingView *)hostingView {
    NSLog(@"componentHostingViewDidInvalidateSize");
    
}

@end
