//
//  BPCell.h
//  GameOfLife
//
//  Created by Justin C. Beck on 9/7/13.
//  Copyright (c) 2013 BeckProduct. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPCell;

@interface BPCell : UIView

@property (nonatomic, assign) CGPoint location;
@property (nonatomic, assign, getter = isAlive) Boolean alive;
@property (nonatomic, assign, getter = willBeAlive, setter = setBeAlive:) Boolean beAlive;

- (void)updateDisplay;

@end
