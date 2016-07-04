//
//  CKCollectionVC.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKCollectionVC.h"
#import "CKCollectionViewUpdater.h"

@interface CKCollectionVC () <CKComponentProvider, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) CKComponentFlexibleSizeRangeProvider *sizeRangeProvider;
@end

@implementation CKCollectionVC

#pragma mark - CKComponent

- (CKComponentFlexibleSizeRangeProvider *)sizeRangeProvider {
    if (_sizeRangeProvider == nil) {
        _sizeRangeProvider = [CKComponentFlexibleSizeRangeProvider providerWithFlexibility:CKComponentSizeRangeFlexibleHeight];
    }
    return _sizeRangeProvider;
}

- (CKCollectionViewDataSource *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[CKCollectionViewDataSource alloc] initWithCollectionView:self.collectionView
                                                     supplementaryViewDataSource:self
                                                               componentProvider:[self class]
                                                                         context:nil
                                                       cellConfigurationFunction:nil];
    }
    return _dataSource;
}

- (NIModelTableUpdater *)tableViewUpdater {
    if (_tableViewUpdater == nil) {
        CKCollectionViewUpdater *updater = [CKCollectionViewUpdater newWithDataSource:self.dataSource];
        _tableViewUpdater = [NIModelTableUpdater newWithTableViewModel:nil updater:updater];
    }
    return _tableViewUpdater;
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource sizeForItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataSource announceWillAppearForItemInCell:cell];
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataSource announceDidDisappearForItemInCell:cell];
}

#pragma mark - CKComponentProvider

+ (CKComponent *)componentForModel:(id<NSObject>)model context:(id<NSObject>)context {
    if ([model conformsToProtocol:@protocol(ComponentModelProtocol)]) {
        id<ComponentModelProtocol> componentModel = (id<ComponentModelProtocol>)model;
        if ([componentModel respondsToSelector:@selector(componentWithContext:)]) {
            return [componentModel componentWithContext:context];
        }
    }
    return nil;
}

@end

#pragma mark - supplementary view

@implementation CKCollectionVC (Supplementary)

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [self collectionView:collectionView headerAtIndexPath:indexPath];
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        return [self collectionView:collectionView footerAtIndexPath:indexPath];
    }
    return nil;
}

@end

BOOL scrolledToBottomWithBuffer(CGPoint contentOffset, CGSize contentSize, UIEdgeInsets contentInset, CGRect bounds) {
    CGFloat buffer = CGRectGetHeight(bounds) - contentInset.top - contentInset.bottom;
    const CGFloat maxVisibleY = (contentOffset.y + bounds.size.height);
    const CGFloat actualMaxY = (contentSize.height + contentInset.bottom);
    return ((maxVisibleY + buffer) >= actualMaxY);
}
