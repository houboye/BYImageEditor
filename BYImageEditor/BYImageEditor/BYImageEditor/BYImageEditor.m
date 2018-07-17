//
//  BYImageEditor.m
//  BYImageEditor
//
//  Created by 侯博野 on 2018/7/16.
//  Copyright © 2018 satelens. All rights reserved.
//

#import "BYImageEditor.h"
#import "BYImageEditorToolBar.h"
#import "BYImageTools.h"
#import "BYImageView.h"
#import "BYMarkView.h"

@interface BYImageEditor () <BYImageEditorToolBarDelegate>

@property (nonatomic, strong) NSMutableArray *imageArray; // 用于撤销功能，每次开始修改图片时一定要加进来一次（TODO Sqlite3做成本地存储）

@property (nonatomic, strong) UIImage *image; // 用来记录编辑状态,调整亮度对比度用

@property (nonatomic, strong) BYImageView *imageView;
@property (nonatomic, strong) BYImageEditorToolBar *toolBar;

@end

@implementation BYImageEditor

- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (void)setSourceImage:(UIImage *)sourceImage {
    _sourceImage = sourceImage;
    if (_imageView) {
        _imageView.image = sourceImage;
        _image = _imageView.image;
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.imageView.oldFrame = self.imageView.frame;
    self.imageView.leastFrame = CGRectMake(([UIScreen mainScreen].bounds.size.width - self.imageView.frame.size.width / 2) / 2,
                                           ([UIScreen mainScreen].bounds.size.height - self.imageView.frame.size.height) / 2 + 80,
                                           self.imageView.frame.size.width / 2 + 1,
                                           self.imageView.frame.size.height / 2 + 1);
    self.imageView.largeFrame = CGRectMake(0, 0, 2 * self.imageView.frame.size.width, 2 * self.imageView.frame.size.height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sourceImage = [UIImage imageNamed:@"aaa.jpg"];
    
    self.imageView = [[BYImageView alloc] init];
    self.imageView.userInteractionEnabled = YES;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    if (self.sourceImage) {
        self.imageView.image = self.sourceImage;
        self.image = self.sourceImage;
    }
    [self.imageView addRotationAndPinchAndPanGestureRecognizer];
    [self.view addSubview:self.imageView];
    
    self.toolBar = [[BYImageEditorToolBar alloc] init];
    self.toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.toolBar.delegate = self;
    [self.view addSubview:self.toolBar];
    
    NSDictionary *views = @{@"imageView": self.imageView,
                            @"toolBar": self.toolBar
                            };
    
    NSString *H1 = @"H:|[imageView]|";
    NSString *H2 = @"H:|[toolBar]|";
    NSString *V1 = @"V:|[imageView][toolBar(80)]|";
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:H1 options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:H2 options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:V1 options:0 metrics:nil views:views]];
}

// 每次开始编辑的时候都要调一次
- (void)recordImages {
    [self.imageArray addObject:self.imageView.image];
    NSLog(@"--------------%ld", self.imageArray.count);
}

#pragma mark - RCImageEditorToolBarDelegate
- (void)editorToolBarUndoButtonClick:(BYImageEditorButton *)button {
    if (self.imageView.isDraw) {
        // 画笔状态下减少线
        [self.imageView.markView undo];
    } else {
        // 其余状态下直接显示上一张图片
        if (self.imageArray.count > 0) {
            if (self.imageArray.count == 1) {
                self.imageView.image = [self.imageArray firstObject];
                [self.imageArray removeLastObject];
            } else {
                self.imageView.image = [self.imageArray lastObject];
                [self.imageArray removeLastObject];
            }
        } else {
            self.imageView.image = self.sourceImage;
        }
    }
}

- (void)editorToolBarBrightnessButtonClick:(BYImageEditorButton *)button {
    [self recordImages];
}

-(void)editorToolBarBrightnessSliderChanged:(BYImageEditorSlider *)slider value:(CGFloat)value {
    self.imageView.image = [BYImageTools imageBrightnessWithImage:self.image byValue:value];
}

- (void)editorToolBarRotationButtonClick:(BYImageEditorButton *)button {
    [self recordImages];
    self.imageView.image = [BYImageTools imageRotationWithImage:self.imageView.image orientation:UIImageOrientationDown];
    self.image = self.imageView.image;
}

- (void)editorToolBarRotationLeftButtonClick:(BYImageEditorButton *)button {
    [self recordImages];
    self.imageView.image = [BYImageTools imageRotationWithImage:self.imageView.image orientation:UIImageOrientationLeft];
    self.image = self.imageView.image;
}

- (void)editorToolBarSaveButtonClick:(BYImageEditorButton *)button {
    // TODO 保存到相册
    NSLog(@"保存");
}

- (void)editorToolBarContrastButtonClick:(BYImageEditorButton *)button {
    [self recordImages];
}

- (void)editorToolBarContrastSliderChanged:(BYImageEditorSlider *)slider value:(CGFloat)value {
    self.imageView.image = [BYImageTools imageContrastWithImage:self.image byValue:value];
}

- (void)editorToolBarRotationRightButtonClick:(BYImageEditorButton *)button {
    [self recordImages];
    self.imageView.image = [BYImageTools imageRotationWithImage:self.imageView.image orientation:UIImageOrientationRight];
    self.image = self.imageView.image;
}

- (void)editorToolBarDrawButtonClick:(BYImageEditorButton *)button {
    if (self.imageView.isDraw) {
        UIImage * markingImage = self.imageView.image;
        
        CGFloat w = self.imageView.frame.size.width;
        CGFloat h = self.imageView.frame.size.height;
        
        //截取markView
        UIGraphicsBeginImageContext(self.imageView.markView.frame.size);
        [self.imageView.markView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *img1 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //将原图与截图绘制在同一张图上
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), YES, 1.0f);
        [markingImage drawInRect:CGRectMake(0, 0, w, h)];
        [img1 drawInRect:CGRectMake(0, 0, w, h)];
        self.imageView.image = img1;
        
        UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.imageView.image = resultImg;
        [self.imageView.markView cleanup];
    }
    self.imageView.isDraw = !self.imageView.isDraw;
    self.imageView.markView.hidden = !self.imageView.markView.hidden;
}

@end

