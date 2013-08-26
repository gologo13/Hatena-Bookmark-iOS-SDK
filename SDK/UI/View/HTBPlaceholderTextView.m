//  HTBPlaceholderTextView.m
//  from http://stackoverflow.com/questions/1328638/placeholder-in-uitextview
//
//  Copyright (c) 2013 Hatena Co., Ltd. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "HTBPlaceholderTextView.h"

@interface HTBPlaceholderTextView ()
@property (nonatomic, strong) UILabel *placeHolderLabel;
@end

@implementation HTBPlaceholderTextView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
        _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _placeHolderLabel.numberOfLines = 0;
        _placeHolderLabel.backgroundColor = [UIColor clearColor];
        _placeHolderLabel.alpha = 0;
        _placeHolderLabel.tag = 999;
        [self addSubview:_placeHolderLabel];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0) {
        return;
    }
    
    if([[self text] length] == 0) {
        _placeHolderLabel.alpha = 1.0;
    }
    else {
        _placeHolderLabel.alpha = 0.0;
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _placeHolderLabel.frame = CGRectMake(8,8,self.bounds.size.width - 16,0);
    _placeHolderLabel.font = self.font;
    _placeHolderLabel.textColor = self.placeholderColor;

    if( [[self placeholder] length] > 0 )
    {
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }

    if( [[self text] length] == 0 && [[self placeholder] length] > 0 ) {
        _placeHolderLabel.alpha = 1.0;
    }
}

@end
