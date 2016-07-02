//
//  DoctorListVC.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "DoctorListVC.h"
#import "DoctorModel.h"

@interface DoctorListVC ()
@property (nonatomic, strong) DoctorListOptions *doctorListOptions;
@end

@implementation DoctorListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self enableHeaderRefresh];
    
    self.doctorListOptions = [DoctorModel doctorListOptions];
    self.modelOptions = self.doctorListOptions;
    self.modelController = [DoctorModel mockDoctorListController];
    
    [self addSection];
    
    [self loadModel:nil];
}

- (void)didLoadModel:(AAModelResult *)result {
    if (result.error) {
        
    }
    else {
        if (self.doctorListOptions.page == 0) {
            [self clearSection];
        }
        NSArray *doctors = result.model;
        if (doctors.count > 0) {
            [self addModels:doctors atIndex:self.doctorListOptions.page * self.doctorListOptions.pageSize];
        }
        
        if (doctors.count == self.doctorListOptions.pageSize) {
            self.doctorListOptions.page += 1;
        }
        
        [self enableFooterRefresh];
    }
}

@end
