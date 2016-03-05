
#import "KeyboardViewController.h"
#import "KeyboardButtonsCollectionDelegate.h"

@interface KeyboardViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *operationLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *buttonsCollectionView;
@property (weak, nonatomic) IBOutlet UIView *keyboardButtonsContainer;

@property (nonatomic, strong) KeyboardButtonsCollectionDelegate* collectionViewDelegate;
@property (strong, nonatomic) NSLayoutConstraint* keyboardHeightConstraint;


@end

@implementation KeyboardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view = [[NSBundle mainBundle] loadNibNamed:@"KeyboardViewController" owner:self options:nil][0];
    self.collectionViewDelegate = [KeyboardButtonsCollectionDelegate buttonCollectionDelegateWithCollectionViewDelegate:self];

    self.buttonsCollectionView.delegate = self.collectionViewDelegate;
    self.buttonsCollectionView.dataSource = self.collectionViewDelegate;
    
    self.keyboardHeightConstraint = [NSLayoutConstraint constraintWithItem: self.view
                                                                 attribute: NSLayoutAttributeHeight
                                                                 relatedBy: NSLayoutRelationEqual
                                                                    toItem: nil
                                                                 attribute: NSLayoutAttributeNotAnAttribute
                                                                multiplier: 1.0
                                                                  constant: self.view.frame.size.height* 0.75 ];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    [self.view setNeedsUpdateConstraints];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view removeConstraint:self.keyboardHeightConstraint];
    [self.view addConstraint:self.keyboardHeightConstraint];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    [self.view setNeedsUpdateConstraints];
}


#pragma mark - KeyboardManagerViewControllerProtocol

- (void)registerClass:(Class)aClass forCellReuseIdentifier:(NSString *)identifier
{
    [self.buttonsCollectionView registerClass:aClass forCellWithReuseIdentifier:identifier];
}

- (void)updateTrackWithLiteral:(NSString*)literal
{
    NSString* operationValue = self.operationLabel.text;
    self.operationLabel.text = [operationValue stringByAppendingString:literal];
}

- (void)setTrackWithLiteral:(NSString *)literal
{
    self.operationLabel.text = literal;
}

- (void)setCalculationResult:(NSString*)result
{
    self.resultLabel.text = result;
}

- (UIView*)keyboardButtonsContainer
{
    return _keyboardButtonsContainer;
}

- (void)textWillChange:(id<UITextInput>)textInput
{
}

- (void)textDidChange:(id<UITextInput>)textInput
{
}

@end
