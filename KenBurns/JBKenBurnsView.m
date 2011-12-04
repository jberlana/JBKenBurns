//
//  KenBurnsView.m
//  KenBurns
//
//  Created by Javier Berlana on 9/23/11.
//  Copyright (c) 2011, Javier Berlana
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this 
//  software and associated documentation files (the "Software"), to deal in the Software 
//  without restriction, including without limitation the rights to use, copy, modify, merge, 
//  publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons 
//  to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies 
//  or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
//  PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
//  FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
//  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
//  IN THE SOFTWARE.
//

#import "JBKenBurnsView.h"
#include <stdlib.h>

#define enlargeRatio 1.2

// Private interface
@interface KenBurnsView ()

  @property (nonatomic) int currentImage;
  @property (nonatomic) BOOL animationInCurse;

  - (void) _animate:(NSNumber*)num;
  - (void) _startAnimations:(NSArray*)images;
@end


@implementation KenBurnsView

@synthesize imagesArray, timeTransition, isLoop, isLandscape;
@synthesize animationInCurse, currentImage;


-(id)init
{
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void) animateWithImages:(NSArray *)images transitionDuration:(float)duration loop:(BOOL)shouldLoop isLandscape:(BOOL)inLandscape;
{
    self.imagesArray      = images;
    self.timeTransition   = duration;
    self.isLoop           = shouldLoop;
    self.isLandscape      = inLandscape;
    self.animationInCurse = NO;
    
    self.layer.masksToBounds = YES;
    
    [NSThread detachNewThreadSelector:@selector(_startAnimations:) toTarget:self withObject:images];

}

- (void) _startAnimations:(NSArray *)images
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    for (uint i = 0; i < [images count]; i++) {
        
        [self performSelectorOnMainThread:@selector(_animate:)
                               withObject:[NSNumber numberWithInt:i]
                            waitUntilDone:YES];
        
        sleep(self.timeTransition);
        i = (i == [images count]-1) && isLoop ? -1 : i; 
    }

    [pool release];
}

- (void) _animate:(NSNumber*)num
{
    UIImage* image = [self.imagesArray objectAtIndex:[num intValue]];
    UIImageView *imageView;
    
    float resizeRatio   = -1;
    float widthDiff     = -1;
    float heightDiff    = -1;
    float originX       = -1;
    float originY       = -1;
    float zoomInX       = -1;
    float zoomInY       = -1;
    float moveX         = -1;
    float moveY         = -1;
    float frameWidth    = isLandscape? self.frame.size.width : self.frame.size.height;
    float frameHeight   = isLandscape? self.frame.size.height : self.frame.size.width;
    
    // Widder than screen 
    if (image.size.width > frameWidth)
    {
        widthDiff  = image.size.width - frameWidth;
        
        // Higher than screen
        if (image.size.height > frameHeight)
        {
            heightDiff = image.size.height - frameHeight;
            
            if (widthDiff > heightDiff) 
                resizeRatio = frameHeight / image.size.height;
            else
                resizeRatio = frameWidth / image.size.width;
            
        // No higher than screen
        }
        else
        {
            heightDiff = frameHeight - image.size.height;
            
            if (widthDiff > heightDiff) 
                resizeRatio = frameWidth / image.size.width;
            else
                resizeRatio = self.bounds.size.height / image.size.height;
        }
        
    // No widder than screen
    }
    else
    {
        widthDiff  = frameWidth - image.size.width;
        
        // Higher than screen
        if (image.size.height > frameHeight)
        {
            heightDiff = image.size.height - frameHeight;
            
            if (widthDiff > heightDiff) 
                resizeRatio = image.size.height / frameHeight;
            else
                resizeRatio = frameWidth / image.size.width;
            
        // No higher than screen
        }
        else
        {
            heightDiff = frameHeight - image.size.height;
            
            if (widthDiff > heightDiff) 
                resizeRatio = frameWidth / image.size.width;
            else
                resizeRatio = frameHeight / image.size.height;
        }
    }
    
    // Resize the image.
    float optimusWidth  = (image.size.width * resizeRatio) * enlargeRatio;
    float optimusHeight = (image.size.height * resizeRatio) * enlargeRatio;
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, optimusWidth, optimusHeight)];
    
    // Calcule the maximum move allowed.
    float maxMoveX = optimusWidth - frameWidth;
    float maxMoveY = optimusHeight - frameHeight;
    
    float rotation = (arc4random() % 9) / 100;

    switch (arc4random() % 4) {
        case 0:
            originX = 0;
            originY = 0;
            zoomInX = 1.25;
            zoomInY = 1.25;
            moveX   = -maxMoveX;
            moveY   = -maxMoveY;
            break;
            
        case 1:
            originX = 0;
            originY = frameHeight - optimusHeight;
            zoomInX = 1.10;
            zoomInY = 1.10;
            moveX   = -maxMoveX;
            moveY   = maxMoveY;
            break;

            
        case 2:
            originX = frameWidth - optimusWidth;
            originY = 0;
            zoomInX = 1.30;
            zoomInY = 1.30;
            moveX   = maxMoveX;
            moveY   = -maxMoveY;
            break;
            
        case 3:
            originX = frameWidth - optimusWidth;
            originY = frameHeight - optimusHeight;
            zoomInX = 1.20;
            zoomInY = 1.20;
            moveX   = maxMoveX;
            moveY   = maxMoveY;
            break;
            
        default:
            NSLog(@"def");
            break;
    }
    
    CALayer *picLayer    = [CALayer layer];
    picLayer.contents    = (id)image.CGImage;
    picLayer.anchorPoint = CGPointMake(0, 0); 
    picLayer.bounds      = CGRectMake(0, 0, optimusWidth, optimusHeight);
    picLayer.position    = CGPointMake(originX, originY);
    
    [imageView.layer addSublayer:picLayer];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:1];
    [animation setType:kCATransitionFade];
    [[self layer] addAnimation:animation forKey:nil];
    
    // Remove the previous view
    if ([[self subviews] count] > 0){
        [[[self subviews] objectAtIndex:0] removeFromSuperview];
    }
    
    [self addSubview:imageView];
    
    // Generates the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:self.timeTransition+1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    CGAffineTransform rotate    = CGAffineTransformMakeRotation(rotation);
    CGAffineTransform moveRight = CGAffineTransformMakeTranslation(moveX, moveY);
    CGAffineTransform combo1    = CGAffineTransformConcat(rotate, moveRight);
    CGAffineTransform zoomIn    = CGAffineTransformMakeScale(zoomInX, zoomInY);
    CGAffineTransform transform = CGAffineTransformConcat(zoomIn, combo1);
    imageView.transform = transform;
    [UIView commitAnimations];
    
    [imageView release];
    
}

@end
