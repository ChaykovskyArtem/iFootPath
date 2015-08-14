//
//  ACFullScreenImageController.h
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 13.07.15.
//
//

#import <UIKit/UIKit.h>
#import "ACWalk.h"

@interface ACFullScreenImageController : UIViewController

@property IBOutlet UIImageView* imageView;
@property NSString* imageString;
@property ACWalk* walk;

@end
