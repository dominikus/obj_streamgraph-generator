//
//  BelievableDataSource.m
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import "BelievableDataSource.h"
#import <stdlib.h>
#import "Layer.h"

@implementation BelievableDataSource

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

-(NSMutableArray*) addRandomBump:(NSMutableArray*)x{
    float height = 1.0f / ((float)random()/RAND_MAX);
    float cx = (float)(2.0f * ((float)random()/RAND_MAX) - 0.5f);
    float r = ((float)random()/RAND_MAX) / 10.0f;
    
    for(int i = 0; i < x.count; i++){
        float a = ((float)i / (float)x.count - cx) / r;
        float nuvalue = [[x objectAtIndex:i] floatValue] + (height * exp(-a * a));
        [x replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:nuvalue]];
    }
 
    return x;
}

-(NSMutableArray*) makeRandomArray:(int)n{
    NSMutableArray* x = [[NSMutableArray alloc] initWithCapacity:n];
    for(int i = 0; i < n; i++){
        [x addObject:[NSNumber numberWithFloat:0]];
    }
    
    // add a handful of random bumps
    for(int i = 0; i < 5; i++){
        x = [self addRandomBump:x];
    }
    
    return x;
}

-(NSArray*) makeWithLayerNum:(int)numLayers AndSizeArrayLength:(int)sizeArrayLength{
    NSMutableArray* layers = [[NSMutableArray alloc] initWithCapacity:numLayers];
    for(int i = 0; i < numLayers; i++){
        [layers addObject:[NSNumber numberWithInt:0]];
    }    
    
    for (int i = 0; i < numLayers; i++) {
        NSString* name = [NSString stringWithFormat:@"Layer #%i", i];
        NSMutableArray* size = [[NSMutableArray alloc] initWithCapacity:sizeArrayLength];
        size = [self makeRandomArray:sizeArrayLength];
        [layers replaceObjectAtIndex:i withObject:[[Layer alloc] initWithName:name AndArray:size]];
    }
    
    return layers;
}


@end
