import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  final theme1 = ThemeData(
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 96.sp, // Used for the largest display text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 60.sp, // Used for medium-large display text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 48.sp, // Used for small-large display text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineLarge: TextStyle(
        fontSize: 34.sp, // Used for large headline text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.sp, // Used for medium headline text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 20.sp, // Used for small headline text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleLarge: TextStyle(
        fontSize: 18.sp, // Used for large title text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp, // Used for medium title text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp, // Used for small title text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp, // Used for large body text
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp, // Used for medium body text
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp, // Used for small body text
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp, // Used for large label text, such as buttons
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp, // Used for medium label text
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp, // Used for small label text
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4279323944),
      surfaceTint: Color(4281428546),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4282941526),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281681720),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284905832),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4279978322),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283464581),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294376435),
      onSurface: Color(4279770392),
      onSurfaceVariant: Color(4282205501),
      outline: Color(4284047705),
      outlineVariant: Color(4285889908),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281152045),
      inversePrimary: Color(4288205988),
      primaryFixed: Color(4282941526),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4281231167),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284905832),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283261264),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283464581),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281819756),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292336596),
      surfaceBright: Color(4294376435),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293981677),
      surfaceContainer: Color(4293652455),
      surfaceContainerHigh: Color(4293257954),
      surfaceContainerHighest: Color(4292863196),
    ),
  );

  final theme2 = ThemeData(
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 96.sp, // Used for the largest display text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 60.sp, // Used for medium-large display text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 48.sp, // Used for small-large display text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineLarge: TextStyle(
        fontSize: 34.sp, // Used for large headline text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.sp, // Used for medium headline text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 20.sp, // Used for small headline text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleLarge: TextStyle(
        fontSize: 18.sp, // Used for large title text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp, // Used for medium title text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp, // Used for small title text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp, // Used for large body text
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp, // Used for medium body text
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp, // Used for small body text
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp, // Used for large label text, such as buttons
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp, // Used for medium label text
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp, // Used for small label text
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4288469416),
      surfaceTint: Color(4288205988),
      onPrimary: Color(4278197001),
      primaryContainer: Color(4284783985),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290498748),
      onSecondary: Color(4278721037),
      secondaryContainer: Color(4286682755),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4289123037),
      onTertiary: Color(4278196511),
      tertiaryContainer: Color(4285372578),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279244048),
      onSurface: Color(4294507764),
      onSurfaceVariant: Color(4291153347),
      outline: Color(4288521628),
      outlineVariant: Color(4286416252),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292863196),
      inversePrimary: Color(4279783981),
      primaryFixed: Color(4289982910),
      onPrimaryFixed: Color(4278195462),
      primaryFixedDim: Color(4288205988),
      onPrimaryFixedVariant: Color(4278206237),
      secondaryFixed: Color(4292077779),
      onSecondaryFixed: Color(4278457608),
      secondaryFixedDim: Color(4290235575),
      onSecondaryFixedVariant: Color(4280826411),
      tertiaryFixed: Color(4290636533),
      onTertiaryFixed: Color(4278195224),
      tertiaryFixedDim: Color(4288859865),
      onTertiaryFixedVariant: Color(4278860869),
      surfaceDim: Color(4279244048),
      surfaceBright: Color(4281678389),
      surfaceContainerLowest: Color(4278914827),
      surfaceContainerLow: Color(4279770392),
      surfaceContainer: Color(4280033564),
      surfaceContainerHigh: Color(4280691494),
      surfaceContainerHighest: Color(4281415217),
    ),
  );

  final theme3 = ThemeData(
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 96.sp, // Used for the largest display text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 60.sp, // Used for medium-large display text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 48.sp, // Used for small-large display text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineLarge: TextStyle(
        fontSize: 34.sp, // Used for large headline text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.sp, // Used for medium headline text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 20.sp, // Used for small headline text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleLarge: TextStyle(
        fontSize: 18.sp, // Used for large title text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp, // Used for medium title text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp, // Used for small title text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp, // Used for large body text
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp, // Used for medium body text
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp, // Used for small body text
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp, // Used for large label text, such as buttons
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp, // Used for medium label text
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp, // Used for small label text
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4280501107),
      surfaceTint: Color(4282474385),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283987368),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282008404),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285298056),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4283578968),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4287064972),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294572543),
      onSurface: Color(4279835680),
      onSurfaceVariant: Color(4282401610),
      outline: Color(4284243815),
      outlineVariant: Color(4286085763),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217078),
      inversePrimary: Color(4289382399),
      primaryFixed: Color(4283987368),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4282277006),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285298056),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283653231),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4287064972),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4285354866),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292467168),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177786),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4293059305),
    ),
  );

  final theme4 = ThemeData(
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 96.sp, // Used for the largest display text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 60.sp, // Used for medium-large display text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 48.sp, // Used for small-large display text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineLarge: TextStyle(
        fontSize: 34.sp, // Used for large headline text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.sp, // Used for medium headline text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 20.sp, // Used for small headline text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleLarge: TextStyle(
        fontSize: 18.sp, // Used for large title text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp, // Used for medium title text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp, // Used for small title text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp, // Used for large body text
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp, // Used for medium body text
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp, // Used for small body text
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp, // Used for large label text, such as buttons
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp, // Used for medium label text
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp, // Used for small label text
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294769407),
      surfaceTint: Color(4289971711),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4290365951),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294769407),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4291152609),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294965754),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4293312480),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279374616),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294769407),
      outline: Color(4291480276),
      outlineVariant: Color(4291480276),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293124841),
      inversePrimary: Color(4279379802),
      primaryFixed: Color(4292994815),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4290365951),
      onPrimaryFixedVariant: Color(4278195007),
      secondaryFixed: Color(4292994814),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4291152609),
      onSecondaryFixedVariant: Color(4279244326),
      tertiaryFixed: Color(4294958584),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4293312480),
      onTertiaryFixedVariant: Color(4280618277),
      surfaceDim: Color(4279374616),
      surfaceBright: Color(4281874751),
      surfaceContainerLowest: Color(4279045651),
      surfaceContainerLow: Color(4279900961),
      surfaceContainer: Color(4280164133),
      surfaceContainerHigh: Color(4280887855),
      surfaceContainerHighest: Color(4281545786),
    ),
  );

  final theme5 = ThemeData(
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 96.sp, // Used for the largest display text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 60.sp, // Used for medium-large display text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 48.sp, // Used for small-large display text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineLarge: TextStyle(
        fontSize: 34.sp, // Used for large headline text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.sp, // Used for medium headline text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 20.sp, // Used for small headline text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleLarge: TextStyle(
        fontSize: 18.sp, // Used for large title text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp, // Used for medium title text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp, // Used for small title text
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp, // Used for large body text
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp, // Used for medium body text
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp, // Used for small body text
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp, // Used for large label text, such as buttons
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp, // Used for medium label text
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp, // Used for small label text
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294966005),
      surfaceTint: Color(4292593262),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4292921970),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294966005),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4292266661),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293918704),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4289582263),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279571211),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294966005),
      outline: Color(4291939000),
      outlineVariant: Color(4291939000),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293452500),
      inversePrimary: Color(4281477632),
      primaryFixed: Color(4294829963),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4292921970),
      onPrimaryFixedVariant: Color(4280030720),
      secondaryFixed: Color(4294109120),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4292266661),
      onSecondaryFixedVariant: Color(4279965186),
      tertiaryFixed: Color(4291424466),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4289582263),
      onTertiaryFixedVariant: Color(4278197004),
      surfaceDim: Color(4279571211),
      surfaceBright: Color(4282136880),
      surfaceContainerLowest: Color(4279242247),
      surfaceContainerLow: Color(4280163091),
      surfaceContainer: Color(4280426519),
      surfaceContainerHigh: Color(4281149985),
      surfaceContainerHighest: Color(4281873707),
    ),
  );
}
