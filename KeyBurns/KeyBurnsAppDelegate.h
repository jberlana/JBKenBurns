//
//  KeyBurnsAppDelegate.h
//  KeyBurns
//
//  Created by Javier Berlana on 9/23/11.
//  Copyright 2011 IECISAAll rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExampleViewController.h"

@interface KeyBurnsAppDelegate : NSObject <UIApplicationDelegate> {
    ExampleViewController *_exampleViewController;
}


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ExampleViewController *exampleViewController;

@end
