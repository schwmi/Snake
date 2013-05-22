//
//  MSSnakeFeed.m
//  Snake
//
//  Created by Michael Schwarz on 19.04.13.
//  Copyright (c) 2013 Michael Schwarz. All rights reserved.
//

#import "MSSnakeFeed.h"

@implementation MSSnakeFeed

+ (MSSnakeFeed *)randomSnakeFeedWithMaxX:(NSInteger)maxX maxY:(NSInteger)maxY {
    MSSnakeFeed *snakeFeed = [[MSSnakeFeed alloc] init];
    snakeFeed->_xPosition = (rand() % maxX);
    snakeFeed->_yPosition = (rand() % maxY);
    return snakeFeed;
}

@end
