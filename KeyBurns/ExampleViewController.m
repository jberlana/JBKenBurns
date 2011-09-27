//
//  ExampleViewController.m
//  KeyBurns
//
//  Created by Javier Berlana on 9/23/11.
//  Copyright 2011 SweetBits.es All rights reserved.
//

#import "ExampleViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ExampleViewController
@synthesize keyView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.keyView.layer.borderWidth = 1;
    self.keyView.layer.borderColor = [UIColor blackColor].CGColor;    
    
    NSArray *myImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"image1.jpeg"],
                         [UIImage imageNamed:@"image2.jpeg"],
                         [UIImage imageNamed:@"image3.jpeg"],
                         [UIImage imageNamed:@"image4.png"],
                         [UIImage imageNamed:@"image5.png"],
                         nil];
    
    [self.keyView starAnimationWithImages:myImages TransitionTime:15  onLoop:YES inLandscape:YES];
    
}

- (void)viewDidUnload
{
    [self setKeyView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)dealloc {
    [keyView release];
    [super dealloc];
}
@end
