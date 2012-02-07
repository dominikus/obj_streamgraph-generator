//
//  RandomColorPicker.m
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import "RandomColorPicker.h"
#import <stdlib.h>
#import "Layer.h"
#import "stream_util.h"

@implementation RandomColorPicker

-(id)init{
    self = [super init];
    // seeded, so we can reproduce results
    srandom(2);
    return self;
}

-(id)initWithSeed:(int)seed{
    self = [super init];
    srandom(seed);
    return self;
}

-(NSString*)getName{
    return @"Random Colors";
}


-(void)colorize:(NSArray *)layers{
    for(int i = 0; i < layers.count; i++){
        float h = lerp(0.6f, 0.65f, ((float)random()/RAND_MAX));
        float s = lerp(0.2f, 0.25f, ((float)random()/RAND_MAX));
        float b = lerp(0.4f, 0.95f, ((float)random()/RAND_MAX));
        
        ((Layer*)[layers objectAtIndex:i]).rgb = [UIColor colorWithHue:h saturation:s brightness:b alpha:1.0f];
    }
}

@end
