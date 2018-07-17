//
//  BYImageEditorToolBar.m
//  BYImageEditor
//
//  Created by 侯博野 on 2018/7/16.
//  Copyright © 2018 satelens. All rights reserved.
//

#import "BYImageEditorToolBar.h"
#import "BYImageEditorButton.h"
#import "BYImageEditorSlider.h"

@interface BYImageEditorToolBar ()

// mainView的控件
@property (strong, nonatomic) BYImageEditorButton *undoButton;
@property (strong, nonatomic) BYImageEditorButton *saveButton;
@property (strong, nonatomic) BYImageEditorButton *brightnessButton;
@property (strong, nonatomic) BYImageEditorButton *contrastButton;
@property (strong, nonatomic) BYImageEditorButton *rotationButton; // 旋转180°
@property (strong, nonatomic) BYImageEditorButton *rotationLeftButton;
@property (strong, nonatomic) BYImageEditorButton *rotationRightButton;
@property (strong, nonatomic) BYImageEditorButton *drawButton; // 画笔

// 亮度滑块view
@property (strong, nonatomic) UIView *brightnessView;
@property (strong, nonatomic) BYImageEditorSlider *brightnessSlider;
@property (strong, nonatomic) BYImageEditorButton *brightnessBackButton;

// 对比度滑块View
@property (strong, nonatomic) UIView *contrastView;
@property (strong, nonatomic) BYImageEditorSlider *contrastSlider;
@property (strong, nonatomic) BYImageEditorButton *contrastBackButton;


@end

@implementation BYImageEditorToolBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupMainViews];
        [self setupBrightnessViews];
        [self setupContrastViews];
    }
    return self;
}

- (void)setupMainViews {
    self.undoButton = [BYImageEditorButton buttonWithImageName:@"" selectImageName:@"" selector:@selector(undoButtonClick:) target:self];
    [self.undoButton setTitle:@"撤销" forState:UIControlStateNormal];
    [self addSubview:self.undoButton];
    
    self.saveButton = [BYImageEditorButton buttonWithImageName:@"" selectImageName:@"" selector:@selector(saveButtonClick:) target:self];
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self addSubview:self.saveButton];
    
    self.brightnessButton = [BYImageEditorButton buttonWithImageName:@"" selectImageName:@"" selector:@selector(brightnessButtonClick:) target:self];
    [self.brightnessButton setTitle:@"亮度" forState:UIControlStateNormal];
    [self addSubview:self.brightnessButton];
    
    self.contrastButton = [BYImageEditorButton buttonWithImageName:@"" selectImageName:@"" selector:@selector(contrastButtonClick:) target:self];
    [self.contrastButton setTitle:@"对比度" forState:UIControlStateNormal];
    [self addSubview:self.contrastButton];
    
    self.rotationButton = [BYImageEditorButton buttonWithImageName:@"" selectImageName:@"" selector:@selector(rotationButtonClick:) target:self];
    [self.rotationButton setTitle:@"180°" forState:UIControlStateNormal];
    [self addSubview:self.rotationButton];
    
    self.rotationLeftButton = [BYImageEditorButton buttonWithImageName:@"" selectImageName:@"" selector:@selector(rotationLeftButtonClick:) target:self];
    [self.rotationLeftButton setTitle:@"左90°" forState:UIControlStateNormal];
    [self addSubview:self.rotationLeftButton];
    
    self.rotationRightButton = [BYImageEditorButton buttonWithImageName:@"" selectImageName:@"" selector:@selector(rotationRightButtonClick:) target:self];
    [self.rotationRightButton setTitle:@"右90°" forState:UIControlStateNormal];
    [self addSubview:self.rotationRightButton];
    
    self.drawButton = [BYImageEditorButton buttonWithImageName:@"" selectImageName:@"" selector:@selector(drawButtonClick:) target:self];
    [self.drawButton setTitle:@"画笔" forState:UIControlStateNormal];
    [self addSubview:self.drawButton];
    
    NSDictionary *views = @{@"undoButton": self.undoButton,
                            @"brightnessButton": self.brightnessButton,
                            @"rotationButton": self.rotationButton,
                            @"rotationLeftButton": self.rotationLeftButton,
                            @"saveButton": self.saveButton,
                            @"contrastButton": self.contrastButton,
                            @"rotationRightButton": self.rotationRightButton,
                            @"drawButton": self.drawButton,
                            };
    
    NSString *H1 = @"H:|-[undoButton][brightnessButton(undoButton)][rotationButton(undoButton)][rotationLeftButton(undoButton)]-|";
    NSString *H2 = @"H:|-[saveButton][contrastButton(saveButton)][rotationRightButton(saveButton)][drawButton(saveButton)]-|";
    NSString *V1 = @"V:|[undoButton][saveButton(undoButton)]|";
    NSString *V2 = @"V:|[brightnessButton][contrastButton(brightnessButton)]|";
    NSString *V3 = @"V:|[rotationButton][rotationRightButton(rotationButton)]|";
    NSString *V4 = @"V:|[rotationLeftButton][drawButton(rotationLeftButton)]|";
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:H1 options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:H2 options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:V1 options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:V2 options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:V3 options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:V4 options:0 metrics:nil views:views]];
}

- (void)setupBrightnessViews {
    self.brightnessView = [[UIView alloc] init];
    self.brightnessView.backgroundColor = [UIColor whiteColor];
    self.brightnessView.translatesAutoresizingMaskIntoConstraints = NO;
    self.brightnessView.hidden = YES;
    [self addSubview:self.brightnessView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[brightnessView]|" options:0 metrics:nil views:@{@"brightnessView": self.brightnessView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[brightnessView]|" options:0 metrics:nil views:@{@"brightnessView": self.brightnessView}]];
    
    self.brightnessBackButton = [BYImageEditorButton buttonWithImageName:@"" selectImageName:@"" selector:@selector(brightnessBackButtonClick:) target:self];
    [self.brightnessBackButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.brightnessView addSubview:self.brightnessBackButton];
    
    self.brightnessSlider = [BYImageEditorSlider sliderWithMaxValue:1.f minValue:-1.f defaultValue:0.2 target:self action:@selector(brightnessSliderChange:)];
    [self.brightnessView addSubview:self.brightnessSlider];
    
    NSDictionary *views = @{@"brightnessBackButton": self.brightnessBackButton,
                            @"brightnessSlider": self.brightnessSlider
                            };
    
    NSString *H1 = @"H:|[brightnessBackButton(60)][brightnessSlider]|";
    NSString *V1 = @"V:|[brightnessBackButton]|";
    NSString *V2 = @"V:|[brightnessSlider]|";
    
    [self.brightnessView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:H1 options:0 metrics:nil views:views]];
    [self.brightnessView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:V1 options:0 metrics:nil views:views]];
    [self.brightnessView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:V2 options:0 metrics:nil views:views]];
}

- (void)setupContrastViews {
    self.contrastView = [[UIView alloc] init];
    self.contrastView.backgroundColor = [UIColor whiteColor];
    self.contrastView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contrastView.hidden = YES;
    [self addSubview:self.contrastView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contrastView]|" options:0 metrics:nil views:@{@"contrastView": self.contrastView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contrastView]|" options:0 metrics:nil views:@{@"contrastView": self.contrastView}]];
    
    self.contrastBackButton = [BYImageEditorButton buttonWithImageName:@"" selectImageName:@"" selector:@selector(contrastBackButtonClick:) target:self];
    [self.contrastBackButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.contrastView addSubview:self.contrastBackButton];
    
    self.contrastSlider = [BYImageEditorSlider sliderWithMaxValue:4.f minValue:0 defaultValue:2.5 target:self action:@selector(contrastSliderChange:)];
    [self.contrastView addSubview:self.contrastSlider];
    
    NSDictionary *views = @{@"contrastBackButton": self.contrastBackButton,
                            @"contrastSlider": self.contrastSlider
                            };
    
    NSString *H1 = @"H:|[contrastBackButton(60)][contrastSlider]|";
    NSString *V1 = @"V:|[contrastBackButton]|";
    NSString *V2 = @"V:|[contrastSlider]|";
    
    [self.contrastView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:H1 options:0 metrics:nil views:views]];
    [self.contrastView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:V1 options:0 metrics:nil views:views]];
    [self.contrastView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:V2 options:0 metrics:nil views:views]];
}

- (void)undoButtonClick:(BYImageEditorButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(editorToolBarUndoButtonClick:)]) {
        [self.delegate editorToolBarUndoButtonClick:button];
    }
}

- (void)saveButtonClick:(BYImageEditorButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(editorToolBarSaveButtonClick:)]) {
        [self.delegate editorToolBarSaveButtonClick:button];
    }
}

- (void)brightnessButtonClick:(BYImageEditorButton *)button {
    // 显示亮度调节滑块
    self.brightnessView.hidden = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(editorToolBarBrightnessButtonClick:)]) {
        [self.delegate editorToolBarBrightnessButtonClick:button];
    }
}

- (void)brightnessBackButtonClick:(BYImageEditorButton *)button {
    // 隐藏brightnessView
    self.brightnessView.hidden = YES;
}

- (void)brightnessSliderChange:(BYImageEditorSlider *)slider {
    if (self.delegate && [self.delegate respondsToSelector:@selector(editorToolBarBrightnessSliderChanged:value:)]) {
        [self.delegate editorToolBarBrightnessSliderChanged:slider value:slider.value];
    }
}

- (void)contrastButtonClick:(BYImageEditorButton *)button {
    // 显示对比度调节滑块
    self.contrastView.hidden = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(editorToolBarContrastButtonClick:)]) {
        [self.delegate editorToolBarContrastButtonClick:button];
    }
}

- (void)contrastBackButtonClick:(BYImageEditorButton *)button {
    // 隐藏contrastView
    self.contrastView.hidden = YES;
}

- (void)contrastSliderChange:(BYImageEditorSlider *)slider {
    if (self.delegate && [self.delegate respondsToSelector:@selector(editorToolBarContrastSliderChanged:value:)]) {
        [self.delegate editorToolBarContrastSliderChanged:slider value:slider.value];
    }
}

- (void)rotationButtonClick:(BYImageEditorButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(editorToolBarRotationButtonClick:)]) {
        [self.delegate editorToolBarRotationButtonClick:button];
    }
}

- (void)rotationLeftButtonClick:(BYImageEditorButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(editorToolBarRotationLeftButtonClick:)]) {
        [self.delegate editorToolBarRotationLeftButtonClick:button];
    }
}

- (void)rotationRightButtonClick:(BYImageEditorButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(editorToolBarRotationRightButtonClick:)]) {
        [self.delegate editorToolBarRotationRightButtonClick:button];
    }
}

- (void)drawButtonClick:(BYImageEditorButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(editorToolBarDrawButtonClick:)]) {
        [self.delegate editorToolBarDrawButtonClick:button];
    }
}

@end

