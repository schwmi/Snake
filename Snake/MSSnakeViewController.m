//
//  MSSnakeViewController.m
//  Snake
//
//  Created by Michael Schwarz on 19.04.13.
//  Copyright (c) 2013 Michael Schwarz. All rights reserved.
//

#import "MSSnakeViewController.h"
#import "MSPlayingFieldView.h"
#import "MSSnakeElement.h"
#import "MSSnakeFeed.h"

@interface MSSnakeViewController ()

@property (nonatomic, strong) MSPlayingFieldView *playingField;
@property (nonatomic, assign) MSSnakeMoveDirection currentDirection;
@property (nonatomic, strong) NSTimer *snakeTimer;

@property (nonatomic, strong) MSSnakeFeed *snakeFeed;
@property (nonatomic, strong) UIImageView *gameOverImageView;

@end

@implementation MSSnakeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
	self.playingField = [[MSPlayingFieldView alloc] initWithFrame:self.view.frame];
    self.playingField.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.playingField.gameElementWidth = 34.f;
    [self.view addSubview:self.playingField];
    
    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe)];
    swipeGestureRight.direction =  UISwipeGestureRecognizerDirectionRight;
    swipeGestureRight.numberOfTouchesRequired = 1;
    [self.playingField addGestureRecognizer:swipeGestureRight];
    
    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe)];
    swipeGestureLeft.direction =  UISwipeGestureRecognizerDirectionLeft;
    swipeGestureLeft.numberOfTouchesRequired = 1;
    [self.playingField addGestureRecognizer:swipeGestureLeft];
    
    UISwipeGestureRecognizer *swipeGestureDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downSwipe)];
    swipeGestureDown.direction =  UISwipeGestureRecognizerDirectionDown;
    swipeGestureDown.numberOfTouchesRequired = 1;
    [self.playingField addGestureRecognizer:swipeGestureDown];
    
    UISwipeGestureRecognizer *swipeGestureUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upSwipe)];
    swipeGestureUp.direction =  UISwipeGestureRecognizerDirectionUp;
    swipeGestureUp.numberOfTouchesRequired = 1;
    [self.playingField addGestureRecognizer:swipeGestureUp];
    
    [self setUpGame];
    self.snakeTimer = [NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(moveSnake) userInfo:nil repeats:YES];
}

- (void)viewWillLayoutSubviews {
    self.playingField.frame = self.view.bounds;
    self.gameOverImageView.center = self.view.center;
}

- (void)rightSwipe {
    if (self.currentDirection != MSSnakeMoveDirectionLeft) {
        self.currentDirection = MSSnakeMoveDirectionRight;
    }
}

- (void)leftSwipe {
    if (self.currentDirection != MSSnakeMoveDirectionRight) {
        self.currentDirection = MSSnakeMoveDirectionLeft;
    }
}

- (void)downSwipe {
    if (self.currentDirection != MSSnakeMoveDirectionUp) {
        self.currentDirection = MSSnakeMoveDirectionDown;
    }
}

- (void)upSwipe {
    if (self.currentDirection != MSSnakeMoveDirectionDown) {
        self.currentDirection = MSSnakeMoveDirectionUp;
    }
}

- (void)moveSnake {
    NSInteger maxX = [self.playingField maxXGameCoord];
    NSInteger maxY = [self.playingField maxYGameCoord];
    BOOL grow = [MSSnakeElement isOnFeedElement:self.snakeFeed];
    [MSSnakeElement moveSnakeInDirection:self.currentDirection grow:grow];
    self.playingField.snakeArray = [MSSnakeElement getSnake];
    
    if (grow == YES) {
        [self placeFeed];
        CGFloat newTimeInterval = self.snakeTimer.timeInterval * 0.95;
        [self.snakeTimer invalidate];
        self.snakeTimer = [NSTimer scheduledTimerWithTimeInterval:newTimeInterval target:self selector:@selector(moveSnake) userInfo:nil repeats:YES];
    }
    
    if ([MSSnakeElement snakeCrashedMaxX:maxX maxY:maxY]) {
        [self.snakeTimer invalidate];
        [self displayGameOver];
    }
}

- (void)placeFeed {
    NSInteger maxX = [self.playingField maxXGameCoord];
    NSInteger maxY = [self.playingField maxYGameCoord];
    MSSnakeFeed *feed = nil;
    while ([MSSnakeElement isOnFeedElement:(feed = [MSSnakeFeed randomSnakeFeedWithMaxX:maxX maxY:maxY])]);
    self.playingField.snakeFeed = feed;
    self.snakeFeed = feed;
}

- (void)displayGameOver {
    UIImage *gameOverImage = [UIImage imageNamed:@"GameOver"];
    self.gameOverImageView = [[UIImageView alloc] initWithImage:gameOverImage];
    [self.view addSubview:self.gameOverImageView];
    self.gameOverImageView.center = self.view.center;
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)setUpGame {
    self.currentDirection = MSSnakeMoveDirectionRight;
    [MSSnakeElement reset];
    self.playingField.snakeArray = [MSSnakeElement getSnake];
    [self placeFeed];
}


@end
