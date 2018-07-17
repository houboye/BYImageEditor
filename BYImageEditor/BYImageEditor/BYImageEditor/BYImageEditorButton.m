//
//  BYImageEditorButton.m
//  BYImageEditor
//
//  Created by 侯博野 on 2018/7/16.
//  Copyright © 2018 satelens. All rights reserved.
//

#import "BYImageEditorButton.h"

@implementation BYImageEditorButton

+ (BYImageEditorButton *)buttonWithImageName:(NSString *)imageName
                             selectImageName:(NSString *)selectImageName
                                    selector:(SEL)selector
                                      target:(id)target {
    BYImageEditorButton *button = [[BYImageEditorButton alloc] init];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    return button;
}

@end
