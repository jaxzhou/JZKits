//
//  NSDate_Stringify.m
//  Pods
//
//  Created by Zhou Jinxiu on 16/4/19.
//
//

#import "NSDate_Stringify.h"

@interface NSDateFormatterCache : NSObject {
    NSMutableDictionary *_cacheDictionary;
}

+(id)sharedCache;

-(NSDateFormatter*)getFormatter:(NSString*)format;

@end

static NSDateFormatterCache *_sharedCache = nil;
@implementation NSDateFormatterCache

+(id)sharedCache{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _sharedCache = [[NSDateFormatterCache alloc] init];
    });
    return _sharedCache;
}

-(id)init{
    self = [super init];
    if (self) {
        _cacheDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(NSDateFormatter*)getFormatter:(NSString*)format{
    NSDateFormatter *dateFormatter = [_cacheDictionary objectForKey:format];
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:format];
        [_cacheDictionary setObject:dateFormatter forKey:format];
    }
    return dateFormatter;
}

@end

@implementation NSDate (Stringify)

+(NSDate*)dateFromString:(NSString*)dateString withFormat:(NSString*)format{
    NSDateFormatter *formatter = [[NSDateFormatterCache sharedCache] getFormatter:format];
    return [formatter dateFromString:dateString];
}

-(NSString*)stringWithFormat:(NSString*)format{
    NSDateFormatter *formatter = [[NSDateFormatterCache sharedCache] getFormatter:format];
    return [formatter stringFromDate:self];
}

@end
