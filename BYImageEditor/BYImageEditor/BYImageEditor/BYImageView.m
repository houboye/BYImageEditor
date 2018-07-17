//
//  BYImageView.m
//  BYImageEditor
//
//  Created by 侯博野 on 2018/7/17.
//  Copyright © 2018 satelens. All rights reserved.
//

#import "BYImageView.h"
#import "BYMarkView.h"

@interface BYImageView ()

@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGestureRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@property (nonatomic, strong) BYMarkView *markView;

@end

@implementation BYImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.markView = [[BYMarkView alloc] init];
        self.markView.translatesAutoresizingMaskIntoConstraints = NO;
        self.markView.hidden = YES;
        [self addSubview:self.markView];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[markView]|" options:0 metrics:nil views:@{@"markView": self.markView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[markView]|" options:0 metrics:nil views:@{@"markView": self.markView}]];
    }
    return self;
}

- (void)setIsDraw:(BOOL)isDraw {
    _isDraw = isDraw;
    // 解决与缩放功能的手势冲突
    if (isDraw) {
        [self removeAllGestureRecognizer];
    } else {
        [self reAddAllGestureRecognizer];
    }
}

- (void)removeAllGestureRecognizer {
    if (self.pinchGestureRecognizer) {
        [self removeGestureRecognizer:self.pinchGestureRecognizer];
    }
    if (self.panGestureRecognizer) {
        [self removeGestureRecognizer:self.panGestureRecognizer];
    }
}

- (void)reAddAllGestureRecognizer {
    if (self.pinchGestureRecognizer && ![[self gestureRecognizers] containsObject:self.pinchGestureRecognizer]) {
        [self addGestureRecognizer:self.pinchGestureRecognizer];
    }
    if (self.panGestureRecognizer && ![[self gestureRecognizers] containsObject:self.panGestureRecognizer]) {
        [self addGestureRecognizer:self.panGestureRecognizer];
    }
}

// 添加所有的手势 ！！！注意后添加的手势先响应，我们先响应缩放手势，别改变顺序
- (void)addRotationAndPinchAndPanGestureRecognizer {
    // 旋转手势
    //    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    //    [self addGestureRecognizer:rotationGestureRecognizer];
    
    // 移动手势
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self addGestureRecognizer:self.panGestureRecognizer];
    
    // 缩放手势
    self.pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [self addGestureRecognizer:self.pinchGestureRecognizer];
}

// 处理旋转手势
- (void)rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer {
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

// 处理缩放手势
- (void)pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer {
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        if (view.frame.size.width < self.oldFrame.size.width / 2) {
            //                view.frame = self.leastFrame;
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, self.leastFrame.size.width, self.leastFrame.size.height);
        }
        if (view.frame.size.width > 2 * self.oldFrame.size.width) {
            //                view.frame = self.largeFrame;
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, self.largeFrame.size.width, self.largeFrame.size.height);
        }
        self.markView.frame = view.frame;
        pinchGestureRecognizer.scale = 1;
    }
}

// 处理拖拉手势
- (void)panView:(UIPanGestureRecognizer *)panGestureRecognizer {
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [self.markView setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}

@end

