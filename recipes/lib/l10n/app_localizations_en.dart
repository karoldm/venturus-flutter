// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'I Love Cooking';

  @override
  String get signInSubtitle => 'Sign in to your account';

  @override
  String get signUpSubtitle => 'Create a new account';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Enter your password again';

  @override
  String get usernameLabel => 'Username';

  @override
  String get usernameHint => 'Enter your username';

  @override
  String get avatarUrlLabel => 'Avatar URL';

  @override
  String get avatarUrlHint => 'Enter your avatar URL';

  @override
  String get signInButton => 'SIGN IN';

  @override
  String get signUpButton => 'SIGN UP';

  @override
  String get noAccountQuestion => 'Don\'t have an account? ';

  @override
  String get hasAccountQuestion => 'Already have an account? ';

  @override
  String get signUpLink => 'Sign up';

  @override
  String get signInLink => 'Sign in here';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get recipes => 'recipe(s)';

  @override
  String get addFavoriteRecipes => 'Add your favorite recipes!';

  @override
  String get errorEmailRequired => 'Enter your email';

  @override
  String get errorEmailInvalid => 'Invalid email';

  @override
  String get errorPasswordRequired => 'Enter your password';

  @override
  String get errorPasswordTooShort => 'Minimum 8 characters';

  @override
  String get errorPasswordNeedsLowercase => 'Needs a lowercase letter';

  @override
  String get errorPasswordNeedsUppercase => 'Needs an uppercase letter';

  @override
  String get errorPasswordNeedsNumber => 'Needs a number';

  @override
  String get errorPasswordNeedsSpecialChar => 'Needs a special character';

  @override
  String get errorConfirmPasswordRequired => 'Confirm your password';

  @override
  String get errorPasswordsDoNotMatch => 'Passwords do not match';

  @override
  String get errorUsernameRequired => 'Enter your username';

  @override
  String get errorUsernameTooShort => 'Minimum 3 characters';

  @override
  String get errorAvatarUrlRequired => 'Enter avatar URL';

  @override
  String get errorAvatarUrlInvalid => 'Invalid URL';

  @override
  String get messageEmailConfirmationSent => 'Confirmation email sent. Check your inbox.';

  @override
  String get favorites => 'Favorites';

  @override
  String get errorListingRecipes => 'Error while listing recipes';

  @override
  String get logout => 'Logout';

  @override
  String get back => 'Back';

  @override
  String get ingredients => 'Ingredients';

  @override
  String get noIngredients => 'No ingredients found';

  @override
  String get instructions => 'Instructions';

  @override
  String get noInstructions => 'No instructions found';

  @override
  String get errorToFoundFavoriteRecipe => 'Error to find favorite recipe';

  @override
  String get errorToFondRecipe => 'Error to find recipe';

  @override
  String get errorToAddFavorite => 'Error to add recipe to favorites';

  @override
  String get errorToRemoveFavorite => 'Error to remove recipe from favotires';

  @override
  String get errorToUpdateFavorite => 'Error to update favorites';

  @override
  String get undo => 'Undo';

  @override
  String get addedToFavorites => 'Added to favorites!';

  @override
  String get removedFromFavorites => 'Removed from favorites!';

  @override
  String get search => 'Search';

  @override
  String get changeTheme => 'Change theme';
}
