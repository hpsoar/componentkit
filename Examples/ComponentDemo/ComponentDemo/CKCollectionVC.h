//
//  CKCollectionVC.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAComponentExt.h"

/*
 *  1. create your Model & ModelController
 *  2. create your component
 *  3. Model implement ComponentModelProtocol
 *  4. inherit & implement CKCollectionVC
 *  5. create dataSource
 *  6. load data
 *  7. add to dataSource
 *  8. show
 */


@interface CKCollectionVC : UIViewController <UICollectionViewDelegate>

- (void)addSection;
- (void)clearSection;
- (void)addModels:(NSArray *)models atIndex:(NSInteger)index;
- (UICollectionViewLayout *)createLayout;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewLayout *layout;
@property (nonatomic, strong) CKCollectionViewDataSource *dataSource;

@end

@protocol CKCollectionReusableView <NSObject>

+ (NSString *)identifier;

@end

@interface CKCollectionReusableView : UICollectionReusableView <CKCollectionReusableView>

@end

@interface CKCollectionVC (Supplementary) <CKSupplementaryViewDataSource>

- (void)registerHeaderClass:(Class)cls identifier:(NSString *)identifier;
- (void)registerFooterClass:(Class)cls identifier:(NSString *)identifier;
- (void)registerHeaderClass:(Class<CKCollectionReusableView>)cls;
- (void)registerFooterClass:(Class<CKCollectionReusableView>)cls;

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
                           headerAtIndexPath:(NSIndexPath *)indexPath;

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
                           footerAtIndexPath:(NSIndexPath *)indexPath;

@end

BOOL scrolledToBottomWithBuffer(CGPoint contentOffset, CGSize contentSize, UIEdgeInsets contentInset, CGRect bounds);
