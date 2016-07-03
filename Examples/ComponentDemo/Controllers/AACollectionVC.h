//
//  AACollectionVC.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshController.h"

#pragma mark - AACollectionVC

@interface AACollectionVC : UIViewController  <UICollectionViewDelegate, RefreshControllerDelegate>

- (UICollectionViewLayout *)createLayout;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewLayout *layout;
@property (nonatomic, strong) RefreshController *refreshController;

@end

#pragma mark - footer & header

@protocol AACollectionReusableView <NSObject>

+ (NSString *)identifier;

@end

@interface AACollectionReusableView : UICollectionReusableView <AACollectionReusableView>

@end

#pragma mark - Supplementary

@interface AACollectionVC (Supplementary)

- (void)registerHeaderClass:(Class)cls identifier:(NSString *)identifier;
- (void)registerFooterClass:(Class)cls identifier:(NSString *)identifier;
- (void)registerHeaderClass:(Class<AACollectionReusableView>)cls;
- (void)registerFooterClass:(Class<AACollectionReusableView>)cls;

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
                           headerAtIndexPath:(NSIndexPath *)indexPath;

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
                           footerAtIndexPath:(NSIndexPath *)indexPath;

@end
