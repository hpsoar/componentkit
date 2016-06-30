//
//  AALabelNode.m
//  ComponentKit
//
//  Created by HuangPeng on 6/30/16.
//
//

#import "AALabelNode.h"

@implementation AALabelNode

+ (instancetype)node:(const AALabelNodeConfig &)config {
    return [super newWithView:{} size:config.size];
}

- (CKComponentLayout)computeLayoutThatFits:(CKSizeRange)constrainedSize {
    CGSize size;
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
    if (self.string) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16],
                                     NSParagraphStyleAttributeName: paragraphStyle.copy};
        
        size = [self.string boundingRectWithSize:constrainedSize.max options:options attributes:attributes context:nil].size;
    }
    else if (self.attributedString) {
        size = [self.attributedString boundingRectWithSize:constrainedSize.max options:options context:nil].size;
    }
    else {
        
    }
    return { self, constrainedSize.clamp(size) };
}

@end
