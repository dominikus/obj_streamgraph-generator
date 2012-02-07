//
//  stream_util.h
//
//  various utility functions, some processing replacements.
//
//  Created by Dominikus Baur on 2/6/12.
//

static inline float minf(float v1, float v2) { return (v1 > v2 ? v2 : v1);}
static inline int maxi(int v1, int v2) { return (v1 > v2 ? v1 : v2);}
static inline float maxf(float v1, float v2) { return (v1 > v2 ? v1 : v2); }
static inline float absf(float v1) { return (v1 >= 0 ? v1 : -v1); }

static inline float lerp(float a, float b, float amt){ return (b - a) * amt + a; }
static inline float mapf(float val, float l1, float r1, float l2, float r2){ return ((val - l1) / (r1 - l1)) * (r2 - l2) + l2; }
