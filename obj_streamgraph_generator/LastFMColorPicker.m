//
//  LastFMColorPicker.m
//
//  Created by Dominikus Baur on 2/6/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import "LastFMColorPicker.h"
#import "Layer.h"
#import "stream_util.h"

@implementation LastFMColorPicker

UIImage* colorScheme;

-(id)initWithImage:(NSString*)imgName{
    self = [super init];
    
    colorScheme = [UIImage imageNamed:imgName];
    
    return self;
}

-(NSString*)getName{
    return @"Listening History Color Scheme";
}

-(void)colorize:(NSArray *)layers{
    // find the largest layer to use as a normalizer
    float maxSum = 0;
    for (int i=0; i<layers.count; i++) {
        maxSum = (float) maxf(maxSum, ((Layer*)[layers objectAtIndex:i]).sum);
    }
    
    // find the color for each layer
    for (int i = 0; i < layers.count; i++) {
        float normalizedOnset = (float)((Layer*)[layers objectAtIndex:i]).onset / ((Layer*)[layers objectAtIndex:i]).size.count;
        float normalizedSum = ((Layer*)[layers objectAtIndex:i]).sum / maxSum;
        float shapedSum = (float)(1.0f - sqrtf(normalizedSum));
        
        ((Layer*)[layers objectAtIndex:i]).rgb = [self get:(float)normalizedOnset And:(float)shapedSum];
    }
}


/**
 * uiimage pixel code 
 * taken from here: http://stackoverflow.com/questions/3284185/get-pixel-color-of-uiimage
 */
- (UIColor*)getPixelColor: (UIImage *)image: (int) x :(int) y {
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    int pixelInfo = ((image.size.width  * y) + x ) * 4; // The image is png
    
    UInt8 red = data[pixelInfo];         // If you need this info, enable it
    UInt8 green = data[(pixelInfo + 1)]; // If you need this info, enable it
    UInt8 blue = data[pixelInfo + 2];    // If you need this info, enable it
    UInt8 alpha = data[pixelInfo + 3];
    CFRelease(pixelData);
    
    UIColor* color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f]; // The pixel color info
    
    return color;
}

-(UIColor*)get:(float)g1 And:(float)g2{
    // get pixel coordinate based on provided parameters
    int x = floorf(g1 * colorScheme.size.width);
    int y = floorf(g2 * colorScheme.size.height);

    // ensure that the pixel is within bounds.
    x = (x<0)?0:x;
    x = (x>colorScheme.size.width - 1)?colorScheme.size.width - 1:x;
    y = (y<0)?0:y;
    y = (y>colorScheme.size.height - 1)?colorScheme.size.height - 1:y;
    
    // return the color at the requested pixel
    return [self getPixelColor:colorScheme :x :y];
}

@end
