//
//  BYMarkView.m
//  BYImageEditor
//
//  Created by 侯博野 on 2018/7/17.
//  Copyright © 2018 satelens. All rights reserved.
//

#import "BYMarkView.h"

@interface Line : NSObject

@property (nonatomic) CGPoint start;
@property (nonatomic) CGPoint end;
@property (nonatomic, retain) UIColor * color;

@end
@implementation Line

- (id)init
{
    self = [super init];
    if (self) {
        [self setColor:[UIColor whiteColor]];
    }
    return self;
}

@end

@interface BYMarkView ()

@property (nonatomic) Line *currentLine;
@property (nonatomic) UIColor *drawColor;
@property (nonatomic, strong) NSMutableArray * completedLines;

@end
@implementation BYMarkView

@synthesize currentLine, completedLines, drawColor;

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        completedLines = [NSMutableArray array];
        drawColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
        
        [self setClipsToBounds:YES];
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:NO];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 5.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    for (Line * line in self.completedLines) {
        [[line color]set];
        CGContextMoveToPoint(context, [line start].x, [line start].y);
        CGContextAddLineToPoint(context, [line end].x, [line end].y);
        CGContextStrokePath(context);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.undoManager beginUndoGrouping];
    
    CGPoint point = [[touches anyObject] locationInView:self];
    
    Line * newLine = [Line new];
    [newLine setStart:point];
    [newLine setEnd:point];
    [newLine setColor:drawColor];
    
    currentLine = newLine;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    [currentLine setEnd:point];
    
    [self addLine:currentLine];
    
    Line *newLine = [[Line alloc] init];
    [newLine setStart:point];
    [newLine setEnd:point];
    [newLine setColor:drawColor];
    
    currentLine = newLine;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setNeedsDisplay];
    
    [self.undoManager endUndoGrouping];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)addLine:(Line*)line {
    [[self.undoManager prepareWithInvocationTarget:self] removeLine:line];
    [completedLines addObject:line];
    [self setNeedsDisplay];
}

- (void)removeLine:(Line*)line {
    if ([completedLines containsObject:line]) {
        [[self.undoManager prepareWithInvocationTarget:self] addLine:line];
        [completedLines removeObject:line];
        [self setNeedsDisplay];
    }
}

- (void)changeDrawColor:(UIColor *)color {
    drawColor = color;
}

- (void)undo {
    if ([self.undoManager canUndo]) {
        [self.undoManager undo];
    }
}

- (void)redo {
    if ([self.undoManager canRedo]) {
        [self.undoManager redo];
    }
}

- (void)cleanup {
    while (![self.undoManager canUndo]) {
        [self.undoManager undo];
    }
}

@end
