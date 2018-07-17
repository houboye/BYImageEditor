//
//  BYImageEditorSlider.m
//  BYImageEditor
//
//  Created by 侯博野 on 2018/7/16.
//  Copyright © 2018 satelens. All rights reserved.
//

#import "BYImageEditorSlider.h"

@implementation BYImageEditorSlider

+ (BYImageEditorSlider *)sliderWithMaxValue:(CGFloat)maxValue
                                   minValue:(CGFloat)minValue
                               defaultValue:(CGFloat)defaultValue
                                     target:(id)target
                                     action:(SEL)action {
    BYImageEditorSlider *slider = [[BYImageEditorSlider alloc] init];
    slider.translatesAutoresizingMaskIntoConstraints = NO;
    
    slider.minimumValue = minValue;
    slider.maximumValue = maxValue;
    slider.value = defaultValue;//设置默认值
    
    //07.minimumTrackTintColor : 小于滑块当前值滑块条的颜色，默认为蓝色
    slider.minimumTrackTintColor = [UIColor redColor];
    //    //08.maximumTrackTintColor: 大于滑块当前值滑块条的颜色，默认为白色
    //    slider.maximumTrackTintColor = [UIColor whiteColor];
    //
    //    //09.thumbTintColor : 当前滑块的颜色，默认为白色
    //    slider.thumbTintColor = [UIColor whiteColor];
    [slider addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    slider.continuous = YES;//当放开手., 值才确定下来
    
    return slider;
}

@end
