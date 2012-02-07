//
//  LayerSort.h
//
//  Created by Dominikus Baur on 2/3/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import <Foundation/Foundation.h>

@interface LayerSort : NSObject

-(NSString*) getName;
-(NSArray*) sort:(NSArray*) layers;

-(NSArray*) orderToOutside:(NSArray*) layers;

@end
