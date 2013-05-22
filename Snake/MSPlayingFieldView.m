//
//  MSPlayingFieldView.m
//  Snake
//
//  Created by Michael Schwarz on 19.04.13.
//  Copyright (c) 2013 Michael Schwarz. All rights reserved.
//

#import "MSPlayingFieldView.h"
#import "MSSnakeElement.h"
#import "MSSnakeFeed.h"

@interface MSPlayingFieldView()

@property (nonatomic, assign) CGFloat borderWidthX;
@property (nonatomic, assign) CGFloat borderWidthY;

@end

@implementation MSPlayingFieldView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _gameElementWidth = 20.f;
        [self calculateBorderWidth];
    }
    return self;
}

- (void)setSnakeArray:(NSArray *)snakeArray {
    _snakeArray = snakeArray;
    [self setNeedsDisplay];
}

- (void)setGameElementWidth:(CGFloat)gameElementWidth {
    _gameElementWidth = gameElementWidth;
    [self calculateBorderWidth];
    [self setNeedsDisplay];
}

- (void)setSnakeFeed:(MSSnakeFeed *)snakeFeed {
    _snakeFeed = snakeFeed;
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self calculateBorderWidth];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    {
        //Draw PlayingField
        CGContextSetRGBFillColor(context, 0.f, 0.f, 0.f, 1.f);
        CGContextFillRect(context, rect);
        CGRect playingFieldRect = CGRectInset(rect, _borderWidthX, _borderWidthY);
        CGContextSetRGBFillColor(context, 1.f, 1.f, 1.f, 1.f);
        CGContextFillRect(context, playingFieldRect);
        
        if (_snakeFeed) {
            CGContextSetRGBFillColor(context, 218.f/255.f, 165.f/255.f, 32.f/255.f, 1.f);
            CGRect feedRect = CGRectMake(_snakeFeed.xPosition * _gameElementWidth, _snakeFeed.yPosition * _gameElementWidth, _gameElementWidth, _gameElementWidth);
            feedRect = CGRectOffset(feedRect, _borderWidthX, _borderWidthY);
            CGContextFillRect(context, feedRect);
        }
        
        
        
        CGContextSetRGBFillColor(context, 0.5f, 0.5f, 0.5f, 1.f);
        //Draw Snake
        for (MSSnakeElement * snakeElem in _snakeArray) {
            CGRect snakeElemRect =CGRectMake(snakeElem.xPosition * _gameElementWidth, snakeElem.yPosition * _gameElementWidth, _gameElementWidth, _gameElementWidth);
            snakeElemRect = CGRectOffset(snakeElemRect, _borderWidthX, _borderWidthY);
            CGContextFillRect(context, snakeElemRect);
        }
    }
    CGContextRestoreGState(context);
}

- (NSInteger)maxXGameCoord {
    return (NSInteger)self.frame.size.width / _gameElementWidth - 1;
}

- (NSInteger)maxYGameCoord {
    return (NSInteger)self.frame.size.height / _gameElementWidth - 1;
}

- (void)calculateBorderWidth {
    _borderWidthX = self.frame.size.width - ((NSInteger)(self.frame.size.width / _gameElementWidth)) * _gameElementWidth;
    _borderWidthY = self.frame.size.height - ((NSInteger)(self.frame.size.height / _gameElementWidth)) * _gameElementWidth;
    _borderWidthX /= 2.f;
    _borderWidthY /= 2.f;
}

@end
