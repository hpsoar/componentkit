//
//  DoctorListVC2.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "DoctorListVC2.h"
#import "DoctorModel.h"
#import "DoctorInfoComponent.h"
#import <CKComponentSubclass.h>

@interface DoctorListVC2()
@property (nonatomic, strong) DoctorListOptions *doctorListOptions;
@end

@implementation DoctorListVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self enableHeaderRefresh];
    
    self.doctorListOptions = [DoctorModel doctorListOptions];
    self.modelOptions = self.doctorListOptions;
    self.modelController = [DoctorModel mockDoctorListController];
    
    [self addSection];
    
    [self loadModel:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStyleDone target:self action:@selector(getTextField:)];
}


- (void)getTextField:(id)sender {
    
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
        
        [self test:doctors.firstObject];
        
        [self enableFooterRefresh];
    }
}

- (void)test:(DoctorModel *)doctor {
    DoctorInfoComponent *c = (DoctorInfoComponent *)[doctor componentWithContext:nil];
    CKSizeRange contrainedSize = CKSizeRange(CGSizeMake(CGRectGetWidth(self.view.frame), 0),
                                             CGSizeMake(CGRectGetWidth(self.view.frame), INFINITY));
    CKComponentLayout layout = [c layoutThatFits:contrainedSize parentSize:contrainedSize.max];
}

@end
