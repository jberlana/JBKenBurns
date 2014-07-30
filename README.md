iOS Ken Burns effect
====================

**The goal of this project is to create a `UIView` that can generate a Ken Burns transition when given an array of `UIImage` objects.**

![image](<https://raw.githubusercontent.com/jberlana/JBKenBurns/master/demo.gif>)

To use it, you simply need an instance of `JBKenBurnsView` and call this method to start the action:

``` objc
[self.kenView animateWithImages:myImages
                 transitionDuration:6
                       initialDelay:0
                               loop:YES
                        isLandscape:YES];
```

## Installation

I recommend use [CocoaPods](http://cocoapods.org) to install JBKenBurnsView. Simply add the following line to your `Podfile`:

#### Podfile

```ruby
pod 'JBKenBurnsView'
```

But you can also just drop `JBKenBurnsView.m` and `JBKenBurnsView.h` in your project.

## Documentation

The project is documented using AppleDocs syntax. But this is a summary:

#### Start the slideshow
You can start an animation using an `NSArray` of `UIImage` or `NSString` with the paths to the images calling:

``` objc
- (void)animateWithImages:(NSArray *)images
       transitionDuration:(float)time
             initialDelay:(float)delay
                     loop:(BOOL)isLoop
              isLandscape:(BOOL)isLandscape;
```
or 

``` objc
- (void)animateWithImagePaths:(NSArray *)imagePaths
           transitionDuration:(float)time
                 initialDelay:(float)delay
                         loop:(BOOL)isLoop
                  isLandscape:(BOOL)isLandscape;
```

1. `images:` NSArray of UIImages.
2. `time:`  Time in seconds for the transition between images.
3. `delay:`  Time in seconds until the transition should start.
4. `isLoop:`  YES if the animation should start again when ended.
5. `isLandscape:`  If YES optimized to show in Landscape mode.

#### Stop the animation
When the transition has started you can stop the animation calling:

`- (void)stopAnimation;`

#### Add new images to the animation
Or add new images to the array of images in the slide show with:

`- (void)addImage:(UIImage *)image;`

#### KenBurnsViewDelegate
There is a protocol that notifies to the delegate when an image changes or the slideshow ended.

``` objc
@protocol KenBurnsViewDelegate <NSObject>

@optional
- (void)kenBurns:(JBKenBurnsView *)kenBurns didShowImage:(UIImage *)image atIndex:(NSUInteger)index;
- (void)kenBurns:(JBKenBurnsView *)kenBurns didFinishAllImages:(NSArray *)images;

@end
```

## TODO

* Need to allow device rotation.
* Improvements on image transition effects.

## Demo

Build and run the `KenBurnsDemo` project in Xcode to see `JBKenBurnsView` in action.


## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

Thanks a lot to all the people that have collaborated on this library:

- Peter Steinberger [@steipete](https://github.com/steipete)
- Orta [@orta](https://github.com/orta)
- Almas Adilbek [@mixdesign](https://github.com/mixdesign)
- Boska [@boska](https://github.com/boska)
- Alec Gorge [@alecgorge](https://github.com/alecgorge)
- [@scgpilot](https://github.com/scgpilot)
- [@michaelcho](https://github.com/michaelcho)
- [@mystersu](https://github.com/mystersu)

## Contact

Javier Berlana

- http://github.com/jberlana
- http://twitter.com/jberlana
- jberlana@gmail.com

## License

JBKenBurnsView is available under the MIT license. See the LICENSE file for more info.

--
###[SweetBits](http://www.sweetbits.es/ "SweetBits"), welcome to the candy factory.###
