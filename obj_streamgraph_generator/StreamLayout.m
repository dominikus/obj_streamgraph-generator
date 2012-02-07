//
//  StreamLayout.m
//
//  Created by Dominikus Baur on 2/6/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import "StreamLayout.h"
#import "Layer.h"

@implementation StreamLayout

-(NSString*)getName{
    return @"Original Streamgraph Layout";
}

-(void)layout:(NSArray *)layers{
    int n             = ((Layer*)[layers objectAtIndex:0]).size.count;
    int m             = layers.count;
    NSMutableArray* baseline = [[NSMutableArray alloc] initWithCapacity:n];
    for(int i = 0; i < n; i++){
        [baseline addObject:[NSNumber numberWithFloat:0]];
    }
    NSMutableArray* center = [[NSMutableArray alloc] initWithCapacity:n];
    for(int i = 0; i < n; i++){
        [center addObject:[NSNumber numberWithFloat:0]];
    }
    float totalSize;
    float moveUp;
    float increase;
    float belowSize;
    
    // Set shape of baseline values.
    for (int i = 0; i < n; i++) {
        // the 'center' is a rolling point. It is initialized as the previous
        // iteration's center value
        float nucvalue = (i == 0)? 0 : [[center objectAtIndex:(i - 1)] floatValue];
        [center replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:nucvalue]];
        
        // find the total size of all layers at this point
        totalSize = 0;
        for (int j = 0; j < m; j++) {
            totalSize += [[((Layer*)[layers objectAtIndex:j]).size objectAtIndex:i] floatValue];
        }
        
        // account for the change of every layer to offset the center point
        for (int j = 0; j < m; j++) {
            if (i == 0) {
                increase = [[((Layer*)[layers objectAtIndex:j]).size objectAtIndex:i] floatValue];
                moveUp = 0.5f;
            } else {
                belowSize = 0.5f * [[((Layer*)[layers objectAtIndex:j]).size objectAtIndex:i] floatValue];
                for (int k = j + 1; k < m; k++) {
                    belowSize += [[((Layer*)[layers objectAtIndex:k]).size objectAtIndex:i] floatValue];
                }
                increase = [[((Layer*)[layers objectAtIndex:j]).size objectAtIndex:i] floatValue] - 
                    [[((Layer*)[layers objectAtIndex:j]).size objectAtIndex:(i - 1)] floatValue];
                moveUp = totalSize == 0 ? 0 : (belowSize / totalSize);
            }
            float nuvalue = [[center objectAtIndex:i] floatValue] + ((moveUp - 0.5f) * increase);
            [center replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:nuvalue]];
        }
        
        // set baseline to the bottom edge according to the center line
        float nuvalue = [[center objectAtIndex:i] floatValue] + 0.5f * totalSize;
        [baseline replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:nuvalue]];
    }
    
    // Put layers on top of the baseline.
    [self stackOnBaseline:layers AndBaseline:baseline];
}

@end
