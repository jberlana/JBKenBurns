//
//  KeyBurnsView.h
//  KeyBurns
//
//  Created by Javier Berlana on 9/23/11.
//  Copyright 2011 IECISAAll rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface KeyBurnsView : UIView{
    NSArray *imagesArray;
    float timeTransition;
    BOOL isLoop;
    BOOL isLandscape;
}

@property (nonatomic, assign) float timeTransition;
@property (nonatomic) BOOL isLoop;
@property (nonatomic) BOOL isLandscape;
@property (nonatomic, retain) NSArray *imagesArray;

- (void)starAnimationWithImages:(NSArray*)images TransitionTime:(float)time onLoop:(BOOL)isLoop inLandscape:(BOOL)isLandscape;

@end
