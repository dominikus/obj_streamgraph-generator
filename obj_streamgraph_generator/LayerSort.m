//
//  LayerSort.m
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import "LayerSort.h"
#import "Layer.h"

@implementation LayerSort


-(NSString*) getName{
    return @"";
}

-(NSArray*) sort:(NSArray*) layers{
    return nil;
}

/**
 * Creates a 'top' and 'bottom' collection.
 * Iterating through the previously sorted list of layers, place each layer
 * in whichever collection has less total mass, arriving at an evenly
 * weighted graph. Reassemble such that the layers that appeared earliest
 * end up in the 'center' of the graph.
 */
-(NSMutableArray*) orderToOutside:(NSArray*) layers{
    int j = 0;
    int n = layers.count;
    NSMutableArray* newLayers = [[NSMutableArray alloc] initWithCapacity:n];
    for(int i = 0; i < n; i++){
        [newLayers addObject:[NSNumber numberWithFloat:0]];
    }
    
    int topCount = 0;
    float topSum = 0;
    NSMutableArray* topList = [[NSMutableArray alloc] initWithCapacity:n];
    for(int i = 0; i < n; i++){
        [topList addObject:[NSNumber numberWithFloat:0]];
    }
    int botCount = 0;
    float botSum = 0;
    NSMutableArray* botList = [[NSMutableArray alloc] initWithCapacity:n];
    for(int i = 0; i < n; i++){
        [botList addObject:[NSNumber numberWithFloat:0]];
    }
        
    for(int i = 0; i < n; i++){
        if(topSum < botSum){
            [topList replaceObjectAtIndex:(topCount++) withObject:[NSNumber numberWithInt:i]];
            topSum = topSum + ((Layer*)[layers objectAtIndex:i]).sum;
        } else {
            [botList replaceObjectAtIndex:(botCount++) withObject:[NSNumber numberWithInt:i]];
            botSum = botSum + ((Layer*)[layers objectAtIndex:i]).sum;
        }
    }
        
    for(int i = botCount - 1; i >= 0; i--){
        [newLayers replaceObjectAtIndex:(j++) withObject:[layers objectAtIndex:[[botList objectAtIndex:i] intValue]]];
    }
    
    for (int i = 0; i < topCount; i++) {
        [newLayers replaceObjectAtIndex:(j++) withObject:[layers objectAtIndex:[[topList objectAtIndex:i] intValue]]];
    }

    return newLayers;
}

@end
