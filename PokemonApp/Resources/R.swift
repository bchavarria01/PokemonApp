// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum R {
  internal enum Base {
    internal static let _4 = ImageAsset(name: "4")
    internal static let first = ImageAsset(name: "first")
    internal static let logo = ImageAsset(name: "logo")
    internal static let map = ImageAsset(name: "map")
    internal static let player = ImageAsset(name: "player")
    internal static let pokeball = ImageAsset(name: "pokeball")
    internal static let pokeball2 = ImageAsset(name: "pokeball2")
    internal static let pokeballs = ImageAsset(name: "pokeballs")
    internal static let pokemonIcon = ImageAsset(name: "pokemon_icon")
    internal static let second = ImageAsset(name: "second")
    internal static let vector1 = ImageAsset(name: "vector (1)")
    internal static let vector10 = ImageAsset(name: "vector (10)")
    internal static let vector11 = ImageAsset(name: "vector (11)")
    internal static let vector12 = ImageAsset(name: "vector (12)")
    internal static let vector13 = ImageAsset(name: "vector (13)")
    internal static let vector14 = ImageAsset(name: "vector (14)")
    internal static let vector2 = ImageAsset(name: "vector (2)")
    internal static let vector3 = ImageAsset(name: "vector (3)")
    internal static let vector4 = ImageAsset(name: "vector (4)")
    internal static let vector5 = ImageAsset(name: "vector (5)")
    internal static let vector6 = ImageAsset(name: "vector (6)")
    internal static let vector7 = ImageAsset(name: "vector (7)")
    internal static let vector8 = ImageAsset(name: "vector (8)")
    internal static let vector9 = ImageAsset(name: "vector (9)")
    internal static let vector = ImageAsset(name: "vector")
  }
  internal enum Colors {
  }
  internal enum Icons {
    internal static let map = ImageAsset(name: "map")
    internal static let pokemonIcon = ImageAsset(name: "pokemon_icon")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct DataAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  internal var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
internal extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
