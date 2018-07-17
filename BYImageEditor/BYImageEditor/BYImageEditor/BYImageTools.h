//
//  BYImageTools.h
//  BYImageEditor
//
//  Created by 侯博野 on 2018/7/16.
//  Copyright © 2018 satelens. All rights reserved.
//

#import <UIKit/UIKit.h>

// 该类都是在原来的基础上得到一张新图片
@interface BYImageTools : NSObject
// 修改亮度   -1---1   数越大越亮
+ (UIImage *)imageBrightnessWithImage:(UIImage *)image byValue:(float)value;

// 修改饱和度  0---2
+ (UIImage *)imageSaturationWithImage:(UIImage *)image byValue:(float)value;

// 修改对比度  0---4
+ (UIImage *)imageContrastWithImage:(UIImage *)image byValue:(float)value;

// 旋转
+ (UIImage *)imageRotationWithImage:(UIImage *)image orientation:(UIImageOrientation)orientation;

// 缩放到指定大小
+ (UIImage *)imageZoomWithImage:(UIImage *)image size:(CGSize)size;

// 通过缩放系数
+ (UIImage *)imageZoomWithImage:(UIImage *)image scale:(float)scale;

// 通过计算得到缩放系数
+ (UIImage *)imageZoomWithImage:(UIImage *)image targetSize:(CGSize)targetSize;

@end
