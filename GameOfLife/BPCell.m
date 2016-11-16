//
//  BPCell.m
//  GameOfLife
//
//  Created by Justin C. Beck on 9/7/13. (and he made it awesome)
//  Copyright (c) 2013 BeckProduct. All rights reserved.
//

#import "BPCell.h"

@interface BPCell()
{
    Boolean _alive;
}

@end

@implementation BPCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor blackColor]];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleLife)];
        [self addGestureRecognizer:tapGesture];
        [self setBeAlive:NO];
    }
    
    return self;
}

- (void)toggleLife
{
    if ([self isAlive])
        [self deactivate];
    else
        [self activate];
}

- (void)updateDisplay
{
    if ([self willBeAlive])
    {
        [self activate];
    }
    else
    {
        [self deactivate];
    }
    _beAlive = NO;
}

- (void)activate
{
    [self setBackgroundColor:[UIColor whiteColor]];
    _alive = YES;
    _beAlive = NO;
}

- (void)deactivate
{
    [self setBackgroundColor:[UIColor blackColor]];
    _alive = NO;
    _beAlive = NO;
}

- (Boolean)isAlive
{
    return _alive;
}

- (Boolean)willBeAlive
{
    return _beAlive;
}

@end
