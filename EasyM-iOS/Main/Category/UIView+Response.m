//
//  UIView+Response.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/28.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "UIView+Response.h"

@implementation UIView (Response)

- (UIViewController *)parentViewController {
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    
    return nil;
}

@end
