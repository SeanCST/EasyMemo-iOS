//
//  ZYHeadImageClipController.h
//  UniversalApp
//
//  Created by 肖恩伟 on 2018/5/11.
//  Copyright © 2018年 刘鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZYHeadImageLoadBlock)(UIImage *);


@interface ZYHeadImageClipController : UIViewController

/**
 *  裁剪完的回调处理
 */
@property (nonatomic,copy) ZYHeadImageLoadBlock ZYHeadImageBlock;
/**
 *  需要裁剪的图片
 */
@property (nonatomic,strong) UIImage * oldImage;

@end
