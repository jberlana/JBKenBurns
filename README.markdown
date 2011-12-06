iOS Ken Burns effect
====================

The goal of this project is to create a `UIView` that can generate a Ken Burns transition when given an array of `UIImage` objects.

To use it, you simply need to an an instance of `JBKenBurnsView` and call this method to start the action:

``` objc
[self.kenBurnsView animateWithImages:slideshowImages
			 	  transitionDuration:15.0 
						   		loop:YES 
						 inLandscape:YES];
```

### Documentation

``` objc
- (void) animateWithImages:(NSArray*)images transitionDuration:(float)time loop:(BOOL)isLoop isLandscape:(BOOL)isLandscape;
```
Animate an `UIImage` array.

1. `images:` NSArray of UIImages.
2. `time:`  Time in seconds for the transition between images.
3. `isLoop:`  The animation will start again when ended.
4. `isLandscape:`  If true optimized to show in Landscape mode.



``` objc
- (void) animateWithURLs:(NSArray *)urls transitionDuration:(float)duration loop:(BOOL)shouldLoop isLandscape:(BOOL)inLandscape;
```
Animate an `NSString` array with urls to the pictures.

1. `urls:` `NSArray` of `NSString` with urls.
2. `time:`  Time in seconds for the transition between images.
3. `isLoop:`  The animation will start again when ended.
4. `isLandscape:`  If true optimized to show in Landscape mode.

### TODO

* Need to allow device rotation.
* Improvements on image transition effects.

--
###[SweetBits](http://www.sweetbits.es/ "SweetBits"), welcome to the candy factory.###