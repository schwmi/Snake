//
//  MSSnake.h
//  Snake
//
//  Created by Michael Schwarz on 19.04.13.
//  Copyright (c) 2013 Michael Schwarz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSSnakeFeed;

typedef enum {
    MSSnakeMoveDirectionUp,
    MSSnakeMoveDirectionDown,
    MSSnakeMoveDirectionLeft,
    MSSnakeMoveDirectionRight
} MSSnakeMoveDirection;

@interface MSSnakeElement : NSObject

@property (nonatomic, assign) NSInteger xPosition;
@property (nonatomic, assign) NSInteger yPosition;

+ (NSArray *)getSnake;
+ (void)reset;
+ (void)moveSnakeInDirection:(MSSnakeMoveDirection)moveDirection grow:(BOOL)grow;
+ (BOOL)isOnFeedElement:(MSSnakeFeed *)feed;
+ (BOOL)snakeCrashedMaxX:(NSInteger)maxX maxY:(NSInteger)maxY;

@end
