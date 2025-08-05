# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

StockWatcher is a SwiftUI-based iOS application for tracking stock prices using the Alpha Vantage API. The app demonstrates modern iOS development patterns including Combine framework for reactive programming, SwiftUI for UI, and Core Data for persistence. The codebase has been recently refactored to follow iOS security best practices and eliminate common SwiftUI anti-patterns.

## Build Commands

This is an Xcode project that uses standard iOS build processes:
- **Build**: Use Xcode to build the project or `xcodebuild -project StockWatcher.xcodeproj -scheme StockWatcher -destination 'platform=iOS Simulator,name=iPhone 16' build`
- **Test**: Run tests through Xcode Test Navigator or `xcodebuild test -project StockWatcher.xcodeproj -scheme StockWatcher -destination 'platform=iOS Simulator,name=iPhone 16'`
- **Clean Build**: `xcodebuild clean -project StockWatcher.xcodeproj -scheme StockWatcher`

## Architecture

### Core Components
- **Models**: Located in `/StockWatcher/Models/`
  - `Quote.swift`: Alpha Vantage stock quote data model with proper identity handling
  - `Stock.swift`: Simplified stock model for SwiftUI views
  - `StockList.swift`: Observable list management with error handling and secure API configuration
  - `Response.swift`: API response wrapper
  - `WatchList.swift`: Watch list management
  - `StockError.swift`: Comprehensive error handling types (embedded in StockList.swift)

### Data Layer
- **RESTManager**: `/StockWatcher/Managers/RestManager.swift` - Generic REST client using Combine publishers
  - Implements retry logic and error handling
  - Uses snake_case to camelCase key decoding strategy
  - Returns AnyPublisher for reactive data flow
- **Configuration**: Secure API key management with environment variable support (embedded in StockList.swift)
  - Environment variable support: `ALPHA_VANTAGE_API_KEY`
  - Fallback to Keys.plist for local development
  - Proper error messages for missing configuration

### UI Layer
- **SwiftUI Views**: `/StockWatcher/Screens/`
  - `HomeView.swift`: Main stock list with proper error handling and iOS 14+ compatible alerts
  - `DetailView.swift`: Individual stock detail page with mock chart data and stock information
  - `AboutView.swift`: App information
  - `HomeViewRow.swift`: Optimized list row component with computed color properties and no unnecessary state

### Extensions
- **Codable Extensions**: `/StockWatcher/Exrensions/` (note: typo in folder name)
  - `CodableExtension.swift`: Custom Codable implementations
  - `DecodedArray.swift`: Array decoding utilities

## Key Patterns

### API Integration
- Uses Alpha Vantage API for stock data (free tier: 25 requests/day, 5/minute)
- Secure API key management with environment variable support
- API key template in `Keys.plist` (excluded from version control via .gitignore)
- Comprehensive error handling with user-friendly messages
- Production/development mode toggle in HomeView (`prod` variable)

### Reactive Programming
- Extensive use of Combine framework
- ObservableObject pattern for view models
- @Published properties for UI updates
- Proper error state management with @Published error properties

### SwiftUI Patterns
- NavigationView for master-detail flow
- List with ForEach for dynamic content (no nested List anti-patterns)
- Proper SwiftUI identity using stable identifiers (symbol-based, not UUID)
- Computed properties for derived state instead of unnecessary @State variables
- iOS 14+ compatible alert handling

## Development Notes

- Core Data model defined in `StockWatcher.xcdatamodeld`
- Assets and app icons in `Assets.xcassets`
- Launch screen defined in `LaunchScreen.storyboard`
- Export options configured in `exportOptions.plist`
- **Target**: iOS 14.0+ (uses iOS 14 compatible APIs)
- **Security**: No force unwrapping or unsafe casts in production code
- **Performance**: Optimized SwiftUI views with minimal state and proper identity management
- **Error Handling**: Graceful fallbacks instead of `fatalError()` for recoverable errors

## API Requirements

- **Alpha Vantage API**: App uses Alpha Vantage API (free tier)
- Get a free API key from https://www.alphavantage.co/support/#api-key
- **IMPORTANT**: API key is securely managed and NOT committed to version control

### API Key Setup Options:

**Option 1: Environment Variable (Recommended for CI/CD)**
```bash
export ALPHA_VANTAGE_API_KEY="your_api_key_here"
```

**Option 2: Local Keys.plist (Development)**
Add your API key to `StockWatcher/Property Files/Keys.plist`:
```xml
<key>AlphaVantageAPIKey</key>
<string>your_actual_api_key_here</string>
```

### API Limitations:
- Free tier: 25 requests per day, 5 per minute
- Comprehensive error handling with user-friendly messages
- Graceful fallbacks when API calls fail
- Rate limiting awareness built into the app

## Setup Instructions

1. **Install Xcode** from Mac App Store (Version 15.0+ recommended)
2. **Get Alpha Vantage API Key** (free at https://www.alphavantage.co/support/#api-key)
3. **Configure API Key** using one of the methods above
4. **Open project**: `open StockWatcher.xcodeproj` (or use Xcode)
5. **Build and run** in iOS Simulator

### First-time Setup:
```bash
# Clone the repository
git clone <repository-url>
cd StockWatcher

# Set up API key (choose one method)
export ALPHA_VANTAGE_API_KEY="your_api_key_here"
# OR edit Keys.plist with your key

# Build and run
xcodebuild -project StockWatcher.xcodeproj -scheme StockWatcher -destination 'platform=iOS Simulator,name=iPhone 16' build
```

## Code Quality & Security

This codebase follows iOS development best practices:

- ✅ **Security**: No exposed API keys, secure configuration management
- ✅ **Stability**: No force unwrapping, safe optional handling
- ✅ **Performance**: Optimized SwiftUI patterns, minimal unnecessary state
- ✅ **Error Handling**: Comprehensive error management with user feedback
- ✅ **Architecture**: Clean separation of concerns, proper MVVM patterns
- ✅ **Maintainability**: Clear code structure, no debug artifacts in production

## CI/CD & Testing

### GitHub Actions Workflow
- **Workflow File**: `.github/workflows/Testing.yml`
- **Triggers**: Pull requests to master branch
- **Environment**: macOS-latest with latest-stable Xcode
- **Test Target**: iPhone 16 Simulator with latest iOS
- **Status**: ✅ All checks passing

### Test Environment
- **Unit Tests**: `StockWatcherTests/` - Basic unit test structure
- **UI Tests**: `StockWatcherUITests/` - Launch performance and UI validation tests
- **Test Configuration**: Automatic placeholder API key injection for test environments
- **Performance Testing**: Launch metrics using `XCTApplicationLaunchMetric`

### Build & Test Commands
```bash
# Local testing
xcodebuild -project StockWatcher.xcodeproj \
           -scheme StockWatcher \
           -destination 'platform=iOS Simulator,name=iPhone 16,OS=latest' \
           clean build test

# CI/CD testing (matches GitHub Actions)
export ALPHA_VANTAGE_API_KEY="test_key"
xcodebuild test -project StockWatcher.xcodeproj -scheme StockWatcher
```

## Recent Improvements (2025)

- ✅ **API Migration**: Complete migration from IEX Cloud to Alpha Vantage API
- ✅ **Security Enhancements**: Implemented secure API key management with environment variable support
- ✅ **Code Quality**: Eliminated SwiftUI anti-patterns and force unwrapping throughout codebase
- ✅ **Error Handling**: Added comprehensive error handling with user-friendly messages
- ✅ **Performance**: Optimized view performance and memory usage patterns
- ✅ **Testing Infrastructure**: Fixed all UI test compilation errors and performance test compatibility
- ✅ **CI/CD Pipeline**: Updated GitHub Actions workflow for modern Xcode and iOS deployment targets
- ✅ **Deployment Targets**: Unified iOS deployment target to 14.0 across all test targets
- ✅ **Test Environment**: Added automatic test environment detection and safe API key handling
- ✅ **Compatibility**: Updated for iOS 14+ while maintaining modern SwiftUI patterns