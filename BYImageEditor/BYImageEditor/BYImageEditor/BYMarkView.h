//
//  BYMarkView.h
//  BYImageEditor
//
//  Created by 侯博野 on 2018/7/17.
//  Copyright © 2018 satelens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYMarkView : UIView

- (void)changeDrawColor:(UIColor *)color;

- (void)undo;
- (void)redo;

- (void)cleanup;

@end
