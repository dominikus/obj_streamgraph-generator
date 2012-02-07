//
//  LateOnsetDataSource.m
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import "LateOnsetDataSource.h"
#import <stdlib.h>
#import "Layer.h"
#import "stream_util.h"

@implementation LateOnsetDataSource

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

-(NSMutableArray*)addRandomBump:(NSMutableArray*)x Onset:(int)onset Duration:(int)duration{
    float height  = ((float)random()/RAND_MAX);
    int start     = maxi(0, onset);
    
    for (int i = start; i < x.count && i < onset + duration; i++) {
        float xx = (float)(i - onset) / duration;
        float yy = (float)(xx * exp(-10 * xx));
        float nuvalue = [[x objectAtIndex:i] floatValue] + (height * yy);
        [x replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:nuvalue]];
    }
    
    return x;
}

-(NSMutableArray*) makeRandomArrayWithN:(int)n Onset:(int)onset Duration:(int)duration{
    NSMutableArray* x = [[NSMutableArray alloc] initWithCapacity:n];
    for(int i = 0; i < n; i++){
        [x addObject:[NSNumber numberWithInt:0]];
    }
    
    // add a single random bump
    x = [self addRandomBump:x Onset:onset Duration:duration];
    
    return x;
}

-(NSMutableArray *)makeWithLayerNum:(int)numLayers AndSizeArrayLength:(int)sizeArrayLength{
    NSMutableArray* layers = [[NSMutableArray alloc] initWithCapacity:numLayers];
    for(int i = 0; i < numLayers; i++){
        [layers addObject:[NSNumber numberWithInt:0]];
    }

    for (int i = 0; i < numLayers; i++) {
        NSString* name = [NSString stringWithFormat:@"Layer #%i", i];
        int onset = (int)(sizeArrayLength * (((float)random()/RAND_MAX) * 1.25f - 0.25f));
        int duration = (int)(((float)random()/RAND_MAX) * 0.75f * sizeArrayLength);
        NSMutableArray* size = [self makeRandomArrayWithN:sizeArrayLength Onset:onset Duration:duration];
        Layer* lala = [[Layer alloc] initWithName:name AndArray:size];
        [layers replaceObjectAtIndex:i withObject:lala];
    }
    
    return layers;
}

@end
