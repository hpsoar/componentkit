//
//  CKCollectionVC.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKCollectionVC.h"

@interface CKCollectionVC () <CKComponentProvider, UICollectionViewDelegateFlowLayout>
@end

@implementation CKCollectionVC
{
    CKComponentFlexibleSizeRangeProvider *_sizeRangeProvider;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sizeRangeProvider = [CKComponentFlexibleSizeRangeProvider providerWithFlexibility:CKComponentSizeRangeFlexibleHeight];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}

- (void)addSection {
    // Insert the initial section
    CKArrayControllerSections sections;
    sections.insert(0);
    [self.dataSource enqueueChangeset:{sections, {}} constrainedSize:{}];
}

- (void)clearSection {
    CKArrayControllerSections sections;
    sections.remove(0);
    [self.dataSource enqueueChangeset:{ sections, {} } constrainedSize:{}];
    
    [self addSection];
}

- (void)addModels:(NSArray *)models atIndex:(NSInteger)index {
    // Convert the array of quotes to a valid changeset
    CKArrayControllerInputItems items;
    for (NSInteger i = 0; i < models.count; i++) {
        items.insert([NSIndexPath indexPathForRow:index + i inSection:0], models[i]);
    }
    
    [self.dataSource enqueueChangeset:{{}, items}
                  constrainedSize:[_sizeRangeProvider sizeRangeForBoundingSize:self.collectionView.bounds.size]];
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


- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (UICollectionViewLayout *)layout {
    if (_layout == nil) {
        _layout = [self createLayout];
    }
    return _layout;
}

- (UICollectionViewLayout *)createLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumInteritemSpacing:0];
    [flowLayout setMinimumLineSpacing:0];
    return flowLayout;
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

#pragma mark - CKCollectionReusableView

@implementation CKCollectionReusableView

+ (NSString *)identifier {
    return NSStringFromClass(self);
}

@end

@implementation CKCollectionVC (Supplementary)

- (void)registerFooterClass:(Class)cls identifier:(NSString *)identifier {
    [self.collectionView registerClass:cls forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
}

- (void)registerHeaderClass:(Class)cls identifier:(NSString *)identifier {
    [self.collectionView registerClass:cls forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
}

- (void)registerFooterClass:(Class<CKCollectionReusableView>)cls {
    [self registerFooterClass:cls identifier:[cls identifier]];
}

- (void)registerHeaderClass:(Class<CKCollectionReusableView>)cls {
    [self registerHeaderClass:cls identifier:[cls identifier]];
}

#pragma mark - supplementary view


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end

BOOL scrolledToBottomWithBuffer(CGPoint contentOffset, CGSize contentSize, UIEdgeInsets contentInset, CGRect bounds) {
    CGFloat buffer = CGRectGetHeight(bounds) - contentInset.top - contentInset.bottom;
    const CGFloat maxVisibleY = (contentOffset.y + bounds.size.height);
    const CGFloat actualMaxY = (contentSize.height + contentInset.bottom);
    return ((maxVisibleY + buffer) >= actualMaxY);
}
