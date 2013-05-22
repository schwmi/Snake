//
//  MSSnake.m
//  Snake
//
//  Created by Michael Schwarz on 19.04.13.
//  Copyright (c) 2013 Michael Schwarz. All rights reserved.
//

#import "MSSnakeElement.h"
#import "MSSnakeFeed.h"

static NSArray *snakeArray;

@implementation MSSnakeElement

+ (void)initialize {
    [MSSnakeElement reset];
}

+ (NSArray *)getSnake {
    return snakeArray;
}

+ (void)reset {
    snakeArray = @[[[MSSnakeElement alloc] initWithXPosition:3 yPosition:1],
                   [[MSSnakeElement alloc] initWithXPosition:2 yPosition:1],
                   [[MSSnakeElement alloc] initWithXPosition:1 yPosition:1]
                   ];
}

+ (void)moveSnakeInDirection:(MSSnakeMoveDirection)moveDirection grow:(BOOL)grow {
    NSInteger dx = 0, dy = 0;
    switch (moveDirection) {
        case MSSnakeMoveDirectionDown:
            dy = 1;
            break;
        case MSSnakeMoveDirectionLeft:
            dx = -1;
            break;
        case MSSnakeMoveDirectionRight:
            dx = 1;
            break;
        case MSSnakeMoveDirectionUp:
            dy = -1;
    }
    MSSnakeElement *oldFirstElement = [snakeArray objectAtIndex:0];
    MSSnakeElement *newFirstElement = [[MSSnakeElement alloc] initWithXPosition:oldFirstElement.xPosition + dx yPosition:oldFirstElement.yPosition + dy];
    
    NSMutableArray *mutableSnakeArray = [snakeArray mutableCopy];
    if (!grow) {
        [mutableSnakeArray removeLastObject];
    }
    
    [mutableSnakeArray insertObject:newFirstElement atIndex:0];
    snakeArray = [mutableSnakeArray copy];
}

+ (BOOL)isOnFeedElement:(MSSnakeFeed *)feed {
    for (MSSnakeElement *element in snakeArray) {
        if (element.xPosition == feed.xPosition &&
            element.yPosition == feed.yPosition) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)snakeCrashedMaxX:(NSInteger)maxX maxY:(NSInteger)maxY {
    MSSnakeElement *snakeElem = [snakeArray objectAtIndex:0];
    if (snakeElem.yPosition > maxY || snakeElem.yPosition < 0) {
        return YES;
    }
    
    if (snakeElem.xPosition > maxX || snakeElem.xPosition < 0) {
        return YES;
    }
    
    NSInteger overlapcount = 0;
    for (MSSnakeElement *element in snakeArray) {
        if (element.xPosition == snakeElem.xPosition &&
            element.yPosition == snakeElem.yPosition) {
            overlapcount++;
        }
        if (overlapcount > 1) {
            return YES;
        }
    }
    return NO;
}

- (MSSnakeElement *)initWithXPosition:(CGFloat)x yPosition:(CGFloat)y {
    self = [super init];
    if (self) {
        self.xPosition = x;
        self.yPosition = y;
    }
    return self;
}

@end
