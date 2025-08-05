# StockWatcher 📈

A modern iOS stock tracking application built with SwiftUI, demonstrating best practices in iOS development, API integration, and CI/CD workflows.

[![iOS](https://img.shields.io/badge/iOS-14.0+-blue.svg)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)](https://swift.org/)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-2.0+-green.svg)](https://developer.apple.com/xcode/swiftui/)
[![GitHub Actions](https://github.com/davidmatousek/StockWatcher/workflows/Testing/badge.svg)](https://github.com/davidmatousek/StockWatcher/actions)

## 🎯 Project Goals

This project was built to learn and demonstrate:

1. ✅ **GitHub Actions CI/CD** - Automated build, test, and deployment workflows
2. ✅ **GitHub Projects** - Project management and issue tracking
3. ✅ **API Integration** - Real-time stock data from Alpha Vantage API
4. ✅ **SwiftUI Architecture** - Modern iOS UI development patterns
5. 🔄 **iOS Widgets** - Live stock data on the home screen *(planned)*
6. ✅ **App Preview** - Clean, minimal interface for stock tracking
7. ✅ **Modern iOS Features** - iOS 14+ APIs and SwiftUI 2.0+ patterns

## ✨ Features

- **Real-time Stock Data** - Live quotes from Alpha Vantage API
- **Clean SwiftUI Interface** - Modern iOS design patterns
- **Secure Configuration** - Environment-based API key management
- **Error Handling** - Comprehensive error states and user feedback
- **Performance Optimized** - Efficient data loading and UI updates
- **Testing Suite** - Unit and UI tests with CI/CD integration

## 🚀 Quick Start

### Prerequisites
- Xcode 15.0+ 
- iOS 14.0+ target device/simulator
- Alpha Vantage API key (free at [alphavantage.co](https://www.alphavantage.co/support/#api-key))

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/davidmatousek/StockWatcher.git
   cd StockWatcher
   ```

2. **Configure API Key** (choose one method):
   
   **Option A: Environment Variable (Recommended)**
   ```bash
   export ALPHA_VANTAGE_API_KEY="your_api_key_here"
   ```
   
   **Option B: Local Configuration**
   ```bash
   # Edit StockWatcher/Property Files/Keys.plist
   # Add your API key under the "AlphaVantageAPIKey" key
   ```

3. **Build and Run**
   ```bash
   open StockWatcher.xcodeproj
   # Or use command line:
   xcodebuild -project StockWatcher.xcodeproj -scheme StockWatcher -destination 'platform=iOS Simulator,name=iPhone 16' build
   ```

## 🏗️ Architecture

### Tech Stack
- **UI Framework**: SwiftUI 2.0+
- **Reactive Programming**: Combine Framework
- **Data Persistence**: Core Data
- **Networking**: URLSession with custom REST manager
- **API Provider**: Alpha Vantage (migrated from IEX Cloud)

### Project Structure
```
StockWatcher/
├── Models/           # Data models and business logic
├── Screens/          # SwiftUI views and screens
├── Managers/         # Network and data managers
├── Configuration/    # API keys and app configuration
└── Extensions/       # Swift extensions and utilities
```

### Key Components
- **StockList.swift** - Observable stock data management
- **RESTManager.swift** - Generic networking layer with Combine
- **HomeView.swift** - Main stock list interface
- **DetailView.swift** - Individual stock details and charts

## 🧪 Testing

### Run Tests Locally
```bash
# All tests
xcodebuild test -project StockWatcher.xcodeproj -scheme StockWatcher -destination 'platform=iOS Simulator,name=iPhone 16'

# UI Tests only
xcodebuild test -project StockWatcher.xcodeproj -scheme StockWatcher -only-testing:StockWatcherUITests
```

### CI/CD Pipeline
- **GitHub Actions** workflow runs on all pull requests
- **Automated testing** on macOS-latest with latest Xcode
- **Test environment** automatically provides placeholder API keys
- **Performance testing** included for app launch metrics

## 🔒 Security & Best Practices

- ✅ **No hardcoded API keys** - Environment variable configuration
- ✅ **Safe optional handling** - No force unwrapping in production code
- ✅ **Comprehensive error handling** - User-friendly error messages
- ✅ **Modern SwiftUI patterns** - Optimized performance and state management
- ✅ **Git security** - Keys.plist excluded from version control

## 🛠️ Development

### Current Status: Production Ready ✅
- All tests passing
- CI/CD pipeline functional
- Error handling comprehensive
- API migration complete (IEX Cloud → Alpha Vantage)

### Recent Improvements (2025)
- Migrated from IEX Cloud to Alpha Vantage API
- Implemented secure API key management
- Fixed all SwiftUI anti-patterns and performance issues
- Updated GitHub Actions for modern Xcode versions
- Added comprehensive test environment support

## 📝 API Information

**Alpha Vantage API**
- **Free Tier**: 25 requests/day, 5 requests/minute
- **Documentation**: [Alpha Vantage Docs](https://www.alphavantage.co/documentation/)
- **Get API Key**: [Free Registration](https://www.alphavantage.co/support/#api-key)

## 📄 License

This project is available under the MIT License. See the [LICENSE](LICENSE) file for more info.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

---

**Built with ❤️ using SwiftUI and modern iOS development practices**
