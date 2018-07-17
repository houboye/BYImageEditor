//
//  BYImageView.h
//  BYImageEditor
//
//  Created by 侯博野 on 2018/7/17.
//  Copyright © 2018 satelens. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BYMarkView;

@interface BYImageView : UIImageView

@property (nonatomic, strong, readonly) BYMarkView *markView;

@property (nonatomic, assign) CGFloat lastScale;
@property (nonatomic, assign) CGRect oldFrame; //保存图片原来的大小
@property (nonatomic, assign) CGRect largeFrame; //确定图片放大最大的程度
@property (nonatomic, assign) CGRect leastFrame; //确定图片缩小最小的程度

@property (nonatomic, assign) BOOL isDraw; // 是否为涂鸦模式

// 先去掉旋转手势
- (void)addRotationAndPinchAndPanGestureRecognizer;

@end
