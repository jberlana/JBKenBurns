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

#define enlargeRatio 1.1
#define imageBufer 3

enum JBSourceMode {
    JBSourceModeImages,
    JBSourceModePaths
};

// Private interface
@interface JBKenBurnsView ()

@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) NSTimer *nextImageTimer;

@property (nonatomic, assign) CGFloat showImageDuration;
@property (nonatomic, assign) BOOL shouldLoop;
@property (nonatomic, assign) BOOL isLandscape;
@property (nonatomic, assign) enum JBSourceMode sourceMode;

@end


@implementation JBKenBurnsView

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
}

- (void)animateWithImagePaths:(NSArray *)imagePaths transitionDuration:(float)duration initialDelay:(float)delay loop:(BOOL)shouldLoop isLandscape:(BOOL)isLandscape
{
    _sourceMode = JBSourceModePaths;
    [self startAnimationsWithData:imagePaths transitionDuration:duration initialDelay:delay loop:shouldLoop isLandscape:isLandscape];
}

- (void)animateWithImages:(NSArray *)images transitionDuration:(float)duration initialDelay:(float)delay loop:(BOOL)shouldLoop isLandscape:(BOOL)isLandscape {
    _sourceMode = JBSourceModeImages;
    [self startAnimationsWithData:images transitionDuration:duration initialDelay:delay loop:shouldLoop isLandscape:isLandscape];
}

- (void)startAnimationsWithData:(NSArray *)data transitionDuration:(float)duration initialDelay:(float)delay loop:(BOOL)shouldLoop isLandscape:(BOOL)isLandscape
{
    _imagesArray        = [data mutableCopy];
    _showImageDuration  = duration;
    _shouldLoop         = shouldLoop;
    _isLandscape        = isLandscape;
    
    // start at 0
    _currentImageIndex = -1;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _nextImageTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
        [_nextImageTimer fire];
    });
}


#pragma mark - Animation control

- (void)stopAnimation
{
    [self.layer removeAllAnimations];
    
    if (_nextImageTimer && [_nextImageTimer isValid]) {
        [_nextImageTimer invalidate];
        _nextImageTimer = nil;
    }
}

- (void)addImage:(UIImage *)image
{
    [_imagesArray addObject:image];
}

#pragma mark - Image management

- (NSArray *)images
{
    return _imagesArray;
}

- (UIImage *)currentImage
{
    UIImage * image = nil;
    id imageInfo = [_imagesArray count] > 0 ? _imagesArray[MIN([_imagesArray count] - 1, MAX(self.currentImageIndex, 0))] : nil;
    switch (_sourceMode)
    {
        case JBSourceModeImages:
            image = imageInfo;
            break;
            
        case JBSourceModePaths:
            image = [UIImage imageWithContentsOfFile:imageInfo];
            break;
    }
    
    return image;
}

- (void)nextImage
{
    _currentImageIndex++;

    UIImage *image = self.currentImage;
    UIImageView *imageView = nil;
    
    float originX       = -1;
    float originY       = -1;
    float zoomInX       = -1;
    float zoomInY       = -1;
    float moveX         = -1;
    float moveY         = -1;
    
    float frameWidth    = _isLandscape ? self.bounds.size.width: self.bounds.size.height;
    float frameHeight   = _isLandscape ? self.bounds.size.height: self.bounds.size.width;
    
    float resizeRatio = [self getResizeRatioFromImage:image width:frameWidth height:frameHeight];
    
    // Resize the image.
    float optimusWidth  = (image.size.width * resizeRatio) * enlargeRatio;
    float optimusHeight = (image.size.height * resizeRatio) * enlargeRatio;
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, optimusWidth, optimusHeight)];
    imageView.backgroundColor = [UIColor blackColor];
    
    // Calcule the maximum move allowed.
    float maxMoveX = optimusWidth - frameWidth;
    float maxMoveY = optimusHeight - frameHeight;
    
    float rotation = (arc4random() % 9) / 100;
    int moveType = arc4random() % 4;
    
    switch (moveType) {
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
            NSLog(@"Unknown random number found in JBKenBurnsView _animate");
            originX = 0;
            originY = 0;
            zoomInX = 1;
            zoomInY = 1;
            moveX   = -maxMoveX;
            moveY   = -maxMoveY;
            break;
    }
    
//    NSLog(@"W: IW:%f OW:%f FW:%f MX:%f",image.size.width, optimusWidth, frameWidth, maxMoveX);
//    NSLog(@"H: IH:%f OH:%f FH:%f MY:%f\n",image.size.height, optimusHeight, frameHeight, maxMoveY);
    
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
    if ([[self subviews] count] > 0) {
        UIView *oldImageView = [[self subviews] objectAtIndex:0];
        [oldImageView removeFromSuperview];
        oldImageView = nil;
    }
    
    [self addSubview:imageView];
    
    // Generates the animation
    [UIView animateWithDuration:_showImageDuration + 2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^
     {
         CGAffineTransform rotate    = CGAffineTransformMakeRotation(rotation);
         CGAffineTransform moveRight = CGAffineTransformMakeTranslation(moveX, moveY);
         CGAffineTransform combo1    = CGAffineTransformConcat(rotate, moveRight);
         CGAffineTransform zoomIn    = CGAffineTransformMakeScale(zoomInX, zoomInY);
         CGAffineTransform transform = CGAffineTransformConcat(zoomIn, combo1);
         imageView.transform = transform;
         
     } completion:^(BOOL finished) {}];

    [self notifyDelegate];

    // Restart or stop
    if (_currentImageIndex == _imagesArray.count - 1) {
        if (_shouldLoop) { _currentImageIndex = -1; }
        else { [_nextImageTimer invalidate]; }
    }
}

- (float)getResizeRatioFromImage:(UIImage *)image width:(float)frameWidth height:(float)frameHeight
{
    float resizeRatio   = -1;
    float widthDiff     = -1;
    float heightDiff    = -1;
    
    // Wider than screen
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
        }
        // No higher than screen
        else
        {
            heightDiff = frameHeight - image.size.height;
            
            if (widthDiff > heightDiff)
                resizeRatio = frameWidth / image.size.width;
            else
                resizeRatio = self.bounds.size.height / image.size.height;
        }
    }
    // No wider than screen
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
        }
        // No higher than screen
        else
        {
            heightDiff = frameHeight - image.size.height;
            
            if (widthDiff > heightDiff)
                resizeRatio = frameWidth / image.size.width;
            else
                resizeRatio = frameHeight / image.size.height;
        }
    }
    
    return resizeRatio;
}


- (void)notifyDelegate
{
    if([_delegate respondsToSelector:@selector(kenBurns:didShowImage:atIndex:)]) {
        [_delegate kenBurns:self didShowImage:[self currentImage] atIndex:_currentImageIndex];
    }
    
    if (_currentImageIndex == ([_imagesArray count] - 1) &&
        !_shouldLoop &&
        [_delegate respondsToSelector:@selector(kenBurns:didFinishAllImages:)])
    {
        [_delegate kenBurns:self didFinishAllImages:[_imagesArray copy]];
    }
}

@end
