//
//  BPViewController.m
//  GameOfLife
//
//  Created by Justin C. Beck on 9/7/13.
//  Copyright (c) 2013 BeckProduct. All rights reserved.
//

#import "BPViewController.h"
#import "BPCell.h"

#import <QuartzCore/QuartzCore.h>

@interface BPViewController ()
{
    NSMutableArray *_rows;
}

@end

@implementation BPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _rows = [NSMutableArray arrayWithCapacity:10];
    
    for (int y = 0; y < 50; y++)
    {
        NSMutableArray *cells = [[NSMutableArray alloc] initWithCapacity:10];
        
        for (int x = 0; x < 32; x++)
        {
            float pointX = x * 10.0;
            float pointY = y * 10.0;
            
            BPCell *cell = [[BPCell alloc] initWithFrame:CGRectMake(1 + pointX, 1 + pointY, 9.0, 9.0)];
            [cell setLocation:CGPointMake(x, y)];
            
            [[self view] addSubview:cell];
            [cells addObject:cell];
        }
        
        [_rows addObject:cells];
    }
    
    [self seed:nil];
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick)];
    [displayLink setFrameInterval:4];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (IBAction)seed:(id)sender
{
    for (int y = 0; y < [_rows count]; y++)
    {
        NSArray *row = [_rows objectAtIndex:y];
        
        for (int x = 0; x < [row count]; x++)
        {
            BPCell *cell = [row objectAtIndex:x];
            [cell setBeAlive:(arc4random() % 2) == 1 ? YES : NO];
            [cell updateDisplay];
        }
    }
}

- (void)tick
{
    for (int y = 0; y < [_rows count]; y++)
    {
        NSArray *cells = [_rows objectAtIndex:y];
        
        for (int x = 0; x < [cells count]; x++)
        {
            BPCell *cell = [cells objectAtIndex:x];
            [self calculateStateForCell:cell];
        }
    }
    
    [self updateDisplay];
}

- (IBAction)clear:(id)sender
{
    for (int y = 0; y < [_rows count]; y++)
    {
        NSArray *row = [_rows objectAtIndex:y];
        
        for (int x = 0; x < [row count]; x++)
        {
            BPCell *cell = [row objectAtIndex:x];
            [cell setAlive:NO];
        }
    }
    
    [self updateDisplay];
}

- (void)calculateStateForCell:(BPCell *)cell
{
    int liveNeighborCount = 0;
    
    for (int y = [cell location].y - 1; y < [cell location].y + 2; y++)
    {
        NSArray *cells;
        
        if (y == -1)
        {
            cells = [_rows lastObject];
        }
        else if (y == [_rows count])
        {
            cells = [_rows objectAtIndex:0];
        }
        else
        {
            cells = [_rows objectAtIndex:y];
        }
        
        for (int x = [cell location].x - 1; x < [cell location].x + 2; x++)
        {
            BPCell *neighbor;
            
            if (x == -1)
            {
                neighbor = [cells lastObject];
            }
            else if (x == [cells count])
            {
                neighbor = [cells objectAtIndex:0];
            }
            else
            {
                neighbor = [cells objectAtIndex:x];
            }
            
            CGPoint nLocation = [neighbor location];
            CGPoint cLocation = [cell location];
            
            if (nLocation.x != cLocation.x || nLocation.y != cLocation.y)
            {
                if ([neighbor isAlive])
                {
                    liveNeighborCount++;
                }
            }
        }
    }
    
    if (liveNeighborCount < 2 || liveNeighborCount > 3)
    {
        [cell setBeAlive:NO];
    }
    else if (liveNeighborCount == 3 && ![cell isAlive])
    {
        [cell setBeAlive:YES];
    }
    else
    {
        [cell setBeAlive:[cell isAlive]];
    }
}

- (void)updateDisplay
{
    for (int y = 0; y < [_rows count]; y++)
    {
        NSArray *cells = [_rows objectAtIndex:y];
        
        for (int x = 0; x < [cells count]; x++)
        {
            BPCell *cell = [cells objectAtIndex:x];
            [cell updateDisplay];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
