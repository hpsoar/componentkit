//
//  AACollectionVC.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "AACollectionVC.h"

@implementation AACollectionVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
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

- (RefreshController *)refreshController {
    if (_refreshController == nil) {
        _refreshController = [[RefreshController alloc] initWithScrollView:self.collectionView delegate:self];
    }
    return _refreshController;
}

@end

#pragma mark - AACollectionReusableView

@implementation AACollectionReusableView

+ (NSString *)identifier {
    return NSStringFromClass(self);
}

@end

#pragma mark - Supplementary

@implementation AACollectionVC (Supplementary)

- (void)registerFooterClass:(Class)cls identifier:(NSString *)identifier {
    [self.collectionView registerClass:cls forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
}

- (void)registerHeaderClass:(Class)cls identifier:(NSString *)identifier {
    [self.collectionView registerClass:cls forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
}

- (void)registerFooterClass:(Class<AACollectionReusableView>)cls {
    [self registerFooterClass:cls identifier:[cls identifier]];
}

- (void)registerHeaderClass:(Class<AACollectionReusableView>)cls {
    [self registerHeaderClass:cls identifier:[cls identifier]];
}

#pragma mark - supplementary view


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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
                           headerAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
                           footerAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end