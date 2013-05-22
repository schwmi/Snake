//
//  MSPlayingFieldView.h
//  Snake
//
//  Created by Michael Schwarz on 19.04.13.
//  Copyright (c) 2013 Michael Schwarz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MSSnakeFeed;

@interface MSPlayingFieldView : UIView

@property (nonatomic, strong) NSArray * snakeArray;
@property (nonatomic, strong) MSSnakeFeed *snakeFeed;
@property (nonatomic, assign) CGFloat gameElementWidth;

@property (nonatomic, readonly) NSInteger maxXGameCoord;
@property (nonatomic, readonly) NSInteger maxYGameCoord;

@end
