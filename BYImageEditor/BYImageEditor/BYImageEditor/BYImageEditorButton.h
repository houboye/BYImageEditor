//
//  BYImageEditorButton.h
//  BYImageEditor
//
//  Created by 侯博野 on 2018/7/16.
//  Copyright © 2018 satelens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYImageEditorButton : UIButton

+ (BYImageEditorButton *)buttonWithImageName:(NSString *)imageName
                             selectImageName:(NSString *)selectImageName
                                    selector:(SEL)selector
                                      target:(id)target;

@end
