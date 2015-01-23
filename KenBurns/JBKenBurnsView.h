//
//  KenBurnsView.h
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


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class JBKenBurnsView;
@protocol KenBurnsViewDelegate <NSObject>

@optional
- (void)kenBurns:(JBKenBurnsView *)kenBurns didShowImage:(UIImage *)image atIndex:(NSUInteger)index;
- (void)kenBurns:(JBKenBurnsView *)kenBurns didFinishAllImages:(NSArray *)images;

@end


NS_ENUM(NSInteger, JBZoomMode) {
    JBZoomModeIn,
    JBZoomModeOut,
    JBZoomModeRandom
};


@interface JBKenBurnsView : UIView

@property (nonatomic,weak) id<KenBurnsViewDelegate> delegate;
@property (nonatomic,assign,readonly) NSInteger currentImageIndex;
@property (nonatomic,assign) enum JBZoomMode zoomMode;

///----------------------------------
/// @name Initialization
///----------------------------------

/**
 Start the animation with a NSArray of paths to images.
 @param imagePaths  A NSArray of paths to images.
 @param time        The number of second of each image.
 @param isLoop      YES if you want to play the animation in loop.
 @param isLandscape YES if the view is in landscape mode.
 @since 0.3
 */
- (void)animateWithImagePaths:(NSArray *)imagePaths
           transitionDuration:(float)time
                 initialDelay:(float)delay
                         loop:(BOOL)isLoop
                  isLandscape:(BOOL)isLandscape;

/**
 Start the animation with a NSArray of UIImages.
 @param imagePaths  A NSArray of images.
 @param time        The number of second of each image.
 @param isLoop      YES if you want to play the animation in loop.
 @param isLandscape YES if the view is in landscape mode.
 @since 0.3
 */
- (void)animateWithImages:(NSArray *)images
       transitionDuration:(float)time
             initialDelay:(float)delay
                     loop:(BOOL)isLoop
              isLandscape:(BOOL)isLandscape;


///----------------------------------
/// @name Manage animation
///----------------------------------

/**
 Stop the current animation.
 @since 0.3
 */
- (void)stopAnimation;

/**
 Add an image to the current animation.
 @param image A UIImage to add to the animation playback.
 @since 0.3
 */
- (void)addImage:(UIImage *)image;


///----------------------------------
/// @name Animation getters
///----------------------------------

/**
 Returns the NSArray of current images on the animation.
 @return A NSArray with the images in the animation.
 @since 0.3
 */
- (NSArray *)images;

/**
 Return the current image on the animation.
 @return A UIImage with the image on top of the animation.
 @since 0.3
 */
- (UIImage *)currentImage;

@end