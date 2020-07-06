// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Error!
  internal static let error = L10n.tr("Localizable", "error")
  /// Geeting pokemon's detail info
  internal static let getPokemonDetail = L10n.tr("Localizable", "getPokemonDetail")
  /// Getting pokemon from 
  internal static let getPokemonsMessage = L10n.tr("Localizable", "getPokemonsMessage")
  /// Getting region's info
  internal static let getRegionsMessage = L10n.tr("Localizable", "getRegionsMessage")
  /// Loading...
  internal static let loadingTitle = L10n.tr("Localizable", "loadingTitle")
  /// Ok!
  internal static let ok = L10n.tr("Localizable", "ok")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
