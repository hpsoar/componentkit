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
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if( scrollView.contentSize.height == 0 ) {
        return ;
    }
    
    if (scrolledToBottomWithBuffer(scrollView.contentOffset, scrollView.contentSize, scrollView.contentInset, scrollView.bounds)) {
        [self loadDoctors];
    }
}

- (void)loadDoctors {
    [self.doctorModelController fetchDoctors:self.doctorListOptions callback:^(NSArray *doctors, NSError *error) {
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
