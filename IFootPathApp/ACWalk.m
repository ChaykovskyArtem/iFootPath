//
//  ACWalk.m
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 05.07.15.
//
//

#import "ACWalk.h"

@implementation ACWalk
static NSString* thumbsImageURL = @"http://www.ifootpath.com/upload/thumbs/";
static NSString* fullImageURL = @"http://www.ifootpath.com/upload/";



- (ACWalk*) initWithResponse:(id) response {
    self = [super init];
    if (self) {
        self.walkCountry = [response objectForKey:@"walkCounty"];
        self.walkDescription = [response objectForKey:@"walkDescription"];
        self.walkDistrict = [response objectForKey:@"walkDistrict"];
        self.walkGrade = [response objectForKey:@"walkGrade"];
        self.walkIcon = [self iconImageFromURL:[response objectForKey:@"walkIcon"]];
        self.walkID = [response objectForKey:@"walkID"];
        self.walkIllustration = [self photoImageFromURL:[response objectForKey:@"walkIllustration"]];
        self.walkLength = [response objectForKey:@"walkLength"];
        self.walkPhoto = [self photoImageFromURL:[response objectForKey:@"walkPhoto"]];
        self.walkPublished = [response objectForKey:@"walkPublished"];
        self.walkRating = [response objectForKey:@"walkRating"];
        self.walkSegments = [response objectForKey:@"walkSegments"];
        self.walkStartCoordLat = [response objectForKey:@"walkStartCoordLat"];
        self.walkStartCoordLong = [response objectForKey:@"walkStartCoordLong"];
        self.walkTitle = [response objectForKey:@"walkTitle"];
        self.walkType = [response objectForKey:@"walkType"];
        self.walkVersion = [response objectForKey:@"walkVersion"];
        self.numsegs = [response objectForKey:@"numsegs"];
    }
    return self;
}


-(NSString*) photoImageFromURL:(NSString*)URL {
     NSString* imageString = [fullImageURL stringByAppendingString:URL];
    return imageString;
}
-(NSString*) iconImageFromURL:(NSString*)URL {
 NSString* imageString = [thumbsImageURL stringByAppendingString:URL];
    return imageString;
}

@end
