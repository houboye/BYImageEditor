//
//  BYImageEditorSlider.h
//  BYImageEditor
//
//  Created by 侯博野 on 2018/7/16.
//  Copyright © 2018 satelens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYImageEditorSlider : UISlider

+ (BYImageEditorSlider *)sliderWithMaxValue:(CGFloat)maxValue
                                   minValue:(CGFloat)minValue
                               defaultValue:(CGFloat)defaultValue
                                     target:(id)target
                                     action:(SEL)action;

@end
