//
//  AALabelNode.h
//  ComponentKit
//
//  Created by HuangPeng on 6/30/16.
//
//

#import <ComponentKit/ComponentKit.h>
#import <UIKit/UIKit.h>

struct AALabelNodeConfig {
    CKComponentSize size;
};

@interface AALabelNode : CKComponent

+ (instancetype)node:(const AALabelNodeConfig &)config;

@property (nonatomic, copy) NSString *string;
@property (nonatomic, copy) NSAttributedString *attributedString;
@property (nonatomic) AALabelNodeConfig config;
@property (nonatomic, weak) UILabel *label;

@end
