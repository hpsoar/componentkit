//
//  AATableObjectCatalog.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/4/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "AATableObjectCatalog.h"

@implementation AATableObject
@synthesize cellHeight = _cellHeight;
@synthesize needsLayout = _needsLayout;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.needsLayout = YES;
    }
    return self;
}

- (void)layoutForItem:(id)item
            indexPath:(NSIndexPath *)indexPath
            tableView:(UITableView *)tableView {
}

@end

@implementation AATableCell

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
    AATableObject *tableObject = object;
    [tableObject layoutForItem:object indexPath:indexPath tableView:tableView];
    return tableObject.cellHeight;
}

- (BOOL)shouldUpdateCellWithObject:(id)object {
    return YES;
}

@end

@implementation DoctorInfoTableObject

+ (instancetype)newWithDoctor:(DoctorModel *)doctor {
    DoctorInfoTableObject *object = [self new];
    object.doctor = doctor;
    return object;
}

- (Class)cellClass {
    return [DoctorInfoTableCell class];
}

- (void)layoutForItem:(id)item
            indexPath:(NSIndexPath *)indexPath
            tableView:(UITableView *)tableView {
}

@end

@interface UIView (Util)

- (instancetype)aa_addToSuperview:(UIView *)superView;

@end

@implementation UIView (Util)

- (instancetype)aa_addToSuperview:(UIView *)superview {
    [superview addSubview:self];
    return self;
}

- (instancetype)aa_addSubviews:(NSArray *)subviews {
    [subviews enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx,
                                           BOOL *_Nonnull stop) {
        [self addSubview:obj];
    }];
    return self;
}

@end

@interface LayerProp : NSObject <NSCopying>

+ (instancetype)newWithSelector:(SEL)selector;

@property (nonatomic) SEL selector;

@end

@implementation LayerProp

+ (instancetype)newWithSelector:(SEL)selector {
    LayerProp *p = [self new];
    p.selector = selector;
    return p;
}

- (id)copyWithZone:(NSZone *)zone {
    LayerProp *p = [[self class] newWithSelector:self.selector];
    return p;
}

@end

@interface ViewProp : LayerProp

@end

@implementation ViewProp


@end

#define aa_viewProp(a) [ViewProp newWithSelector:@selector(a)]
#define aa_layerProp(a) [LayerProp newWithSelector:@selector(a)]

@implementation DoctorInfoTableCell {
    UILabel *_nameLabel;
    UILabel *_titleLabel;
    UILabel *_clinicLabel;
    UILabel *_hospitalLabel;
    UILabel *_goodAtLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView aa_addSubviews:@[
            _nameLabel = [UILabel new],
            _titleLabel = [UILabel new],
            _clinicLabel = [UILabel new],
            _hospitalLabel = [UILabel new],
            _goodAtLabel = [UILabel new],
        ]];
        
        NSDictionary *style = @{ aa_viewProp(setBackgroundColor:) : [UIColor redColor],
                                 aa_viewProp(setFont:) : [UIFont systemFontOfSize:16],
                                 aa_layerProp(setCornerRadius:): @5,
                                };
    }
    return self;
}

- (BOOL)shouldUpdateCellWithObject:(id)object {
    [super shouldUpdateCellWithObject:object];
    
    DoctorModel *doctor = object;
    _nameLabel.text = doctor.name;
    _titleLabel.text = doctor.title;
    _clinicLabel.text = doctor.clinic;
    _clinicLabel.text = doctor.hospital;
    _goodAtLabel.text = doctor.goodAt;
    
    return YES;
}

@end