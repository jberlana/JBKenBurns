//
//  ExampleViewController.h
//  KeyBurns
//
//  Created by Javier Berlana on 9/23/11.
//  Copyright 2011 SweetBits.es All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBurnsView.h"

@interface ExampleViewController : UIViewController {
    KeyBurnsView *keyView;
}

@property (nonatomic, retain) IBOutlet KeyBurnsView *keyView;

@end
