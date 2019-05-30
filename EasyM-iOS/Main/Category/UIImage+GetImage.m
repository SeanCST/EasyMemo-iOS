//
//  UIImage+GetImage.m
//  EasyM-iOS
//
//  Created by SeanCST on 2019/5/30.
//  Copyright © 2019 NilOrg. All rights reserved.
//

#import "UIImage+GetImage.h"

@implementation UIImage (GetImage)

// 颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
