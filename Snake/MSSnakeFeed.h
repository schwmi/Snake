//
//  MSSnakeFeed.h
//  Snake
//
//  Created by Michael Schwarz on 19.04.13.
//  Copyright (c) 2013 Michael Schwarz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSSnakeFeed : NSObject

@property (nonatomic, readonly) NSInteger xPosition;
@property (nonatomic, readonly) NSInteger yPosition;

+ (MSSnakeFeed *)randomSnakeFeedWithMaxX:(NSInteger)maxX maxY:(NSInteger)maxY;

@end
