//
//  DetailView.swift
//  StockWatcher
//
//  Created by Matousek, David on 9/15/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import SwiftUI

struct DataPoint {
    let value: Double
}

struct LineChartShape: Shape {
    let dataPoints: [DataPoint]
    let pointSize: CGFloat
    let maxValue: Double
    let drawingLines: Bool

    init(dataPoints: [DataPoint], pointSize: CGFloat, drawingLines: Bool) {
        self.dataPoints = dataPoints
        self.pointSize = pointSize
        self.drawingLines = drawingLines

        let highestPoint = dataPoints.max { $0.value < $1.value }
        maxValue = highestPoint?.value ?? 1
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let drawRect = rect.insetBy(dx: pointSize, dy: pointSize)

        let xMultiplier = drawRect.width / CGFloat(dataPoints.count - 1)
        let yMultiplier = drawRect.height / CGFloat(maxValue)

        for (index, dataPoint) in dataPoints.enumerated() {
            var x = xMultiplier * CGFloat(index)
            var y = yMultiplier * CGFloat(dataPoint.value)

            y = drawRect.height - y

            x += drawRect.minX
            y += drawRect.minY

            if drawingLines {
                if index == 0 {
                    path.move(to: CGPoint(x: x, y: y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            } else {
                x -= pointSize / 2
                y -= pointSize / 2

                path.addEllipse(in: CGRect(x: x, y: y, width: pointSize, height: pointSize))
            }
        }

        return path
    }
}

struct LineChart: View {
    let dataPoints: [DataPoint]
    var lineColor = Color.primary
    var lineWidth: CGFloat = 2

    var pointColor = Color.primary
    var pointSize: CGFloat = 5

    var body: some View {
        ZStack {
            if lineColor != .clear {
                LineChartShape(dataPoints: dataPoints, pointSize: pointSize, drawingLines: true)
                    .stroke(lineColor, lineWidth: lineWidth)
            }

            if pointColor != .clear {
                LineChartShape(dataPoints: dataPoints, pointSize: pointSize, drawingLines: false)
                    .fill(pointColor)
            }
        }
    }
}
struct DetailView: View {
    public var item: Stock
    @State private var data = makeDataPoints(item: Stock.default)
    
    init(item: Stock) {
        self.item = item
    }
    var body: some View {
        Form {
            Section {
                LineChart(dataPoints: data, lineColor: .blue, lineWidth: 2, pointColor: .red, pointSize: 1)
                    .frame(width: 300, height: 200)
                    .onAppear(perform: {
                        data = DetailView.makeDataPoints(item: item)
                    })
            }
            Section(header: Text("Stock Information")) {
                Text(item.quote.companyName)
                Text("Previous Close:  \(item.quote.previousClose)")
                Text("Current Price:  $\(item.quote.latestPrice ?? 0.0, specifier: "%.2f")")
                Text("Change: $\(item.quote.changeValue ?? 0.0, specifier: "%.2f") (\(item.quote.changePercentValue ?? 0.0, specifier: "%.2f")%)")
                Text(item.quote.symbol)
            }
            // News section removed - not available in simplified Stock model
        }
    }
    static func makeDataPoints(item: Stock) -> [DataPoint] {
        // Generate mock chart data based on current price
        let basePrice = item.quote.latestPrice ?? 100.0
        var isGoingUp = true
        var currentValue = basePrice
        
        return (1...10).map { _ in
            if isGoingUp {
                currentValue += Double.random(in: 0.5...3.0)
            } else {
                currentValue -= Double.random(in: 0.5...3.0)
            }
            
            if isGoingUp {
                if Int.random(in: 0..<10) == 0 {
                    isGoingUp.toggle()
                }
            } else {
                if Int.random(in: 0..<7) == 0 {
                    isGoingUp.toggle()
                }
            }
            
            return DataPoint(value: abs(currentValue))
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(item: Stock.default)
    }
}
