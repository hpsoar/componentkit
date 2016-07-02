//
//  DoctorListVC.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "DoctorListVC.h"
#import "DoctorModel.h"

@interface TestHeaderView : UICollectionReusableView

@end

@implementation TestHeaderView


@end

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
    
    [self registerHeaderClass:[TestHeaderView class] identifier:@"header"];
    
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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    
    /* This is trick to get the right height for header, it would be better if we can reuse self.headerView, rather than to create a new on by deque...
     * one way to surpass this overhead, is to use a UIView for @"header", and add self.headerView to the @"header" view
     */
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        reusableview.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 50);
        reusableview.backgroundColor = [UIColor greenColor];
    }
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize headerSize = CGSizeMake(320, 104);
    return headerSize;
}

@end
