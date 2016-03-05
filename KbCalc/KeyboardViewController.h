
#import <UIKit/UIKit.h>

@protocol KeyboardManagerViewControllerProtocol <NSObject>

- (void)registerClass:(Class)aClass forCellReuseIdentifier:(NSString *)identifier;
- (void)updateTrackWithLiteral:(NSString*)literal;
- (void)setTrackWithLiteral:(NSString*)literal;
- (void)setCalculationResult:(NSString*)result;
- (UIView*)keyboardButtonsContainer;

@end

@interface KeyboardViewController : UIInputViewController<KeyboardManagerViewControllerProtocol>

@end
