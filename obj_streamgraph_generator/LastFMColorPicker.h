//
//  LastFMColorPicker.h
//
//  Created by Dominikus Baur on 2/6/12.
//  Based on Lee Byron and Martin Wattenberg's Processing Streamgraph code
//  Available here: https://github.com/leebyron/streamgraph_generator
//

#import <Foundation/Foundation.h>
#import "ColorPicker.h"

@interface LastFMColorPicker : NSObject <ColorPicker>

-(id)initWithImage:(NSString*)imgName;

-(UIColor*)get:(float)g1 And:(float)g2;

@end
