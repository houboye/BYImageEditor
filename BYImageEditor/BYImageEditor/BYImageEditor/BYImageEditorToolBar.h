//
//  BYImageEditorToolBar.h
//  BYImageEditor
//
//  Created by 侯博野 on 2018/7/16.
//  Copyright © 2018 satelens. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BYImageEditorButton;
@class BYImageEditorSlider;

@protocol BYImageEditorToolBarDelegate <NSObject>

@required
- (void)editorToolBarUndoButtonClick:(BYImageEditorButton *)button;
- (void)editorToolBarSaveButtonClick:(BYImageEditorButton *)button;
- (void)editorToolBarRotationButtonClick:(BYImageEditorButton *)button;
- (void)editorToolBarRotationLeftButtonClick:(BYImageEditorButton *)button;
- (void)editorToolBarRotationRightButtonClick:(BYImageEditorButton *)button;
- (void)editorToolBarDrawButtonClick:(BYImageEditorButton *)button;
- (void)editorToolBarBrightnessButtonClick:(BYImageEditorButton *)button;
- (void)editorToolBarContrastButtonClick:(BYImageEditorButton *)button;
- (void)editorToolBarBrightnessSliderChanged:(BYImageEditorSlider *)slider value:(CGFloat)value;
- (void)editorToolBarContrastSliderChanged:(BYImageEditorSlider *)slider value:(CGFloat)value;

@end

@interface BYImageEditorToolBar : UIView

@property (weak, nonatomic) id<BYImageEditorToolBarDelegate> delegate;

@end
