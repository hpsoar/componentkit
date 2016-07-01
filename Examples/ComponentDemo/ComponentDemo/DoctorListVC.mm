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
@property (nonatomic, strong) DoctorModelController *doctorModelController;
@property (nonatomic, strong) DoctorListOptions *doctorListOptions;
@end

@implementation DoctorListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.doctorModelController = [MockDoctorModelController new];
    self.doctorListOptions = [DoctorListOptions new];
    self.doctorListOptions.pageSize = 20;
    
    [self addSection];
    
    [self loadDoctors];
    
    [self enableFooterRefresh];
}

- (void)beginFooterRefreshing {
    [self loadDoctors];
}

- (void)loadDoctors {
    [self.doctorModelController fetchDoctors:self.doctorListOptions callback:^(NSArray *doctors, NSError *error) {
        [self endFooterRefreshing];
        
        if (error) {
            
        }
        else {
            [self didLoadDoctors:doctors];
        }
    }];
}

- (void)didLoadDoctors:(NSArray *)doctors {
    if (doctors.count > 0) {
        [self addModels:doctors atIndex:self.doctorListOptions.page * self.doctorListOptions.pageSize];
        
        [self.collectionView reloadData];
    }
    
    if (doctors.count == self.doctorListOptions.pageSize) {
        self.doctorListOptions.page += 1;
    }
}

@end
