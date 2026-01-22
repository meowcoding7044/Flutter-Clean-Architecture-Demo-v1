import React, { useMemo, useState } from 'react';
import { Button, StyleSheet, Text, View } from "react-native";
import { PieChart } from "react-native-gifted-charts";

type AssetStatus = {
  label: 'Found' | 'In Progress' | 'Not Found';
  value: number;
  color: string;
};

const COLORS = {
  Found: '#6EE66E',
  'In Progress': '#FFD56A',
  'Not Found': '#FF8A8A',
};

type ArrowDirection = 'left' | 'right' | 'top' | 'bottom';

// Speech bubble component
const SpeechBubble = ({
  label,
  value,
  percent,
  color,
  arrowDirection
}: {
  label: string;
  value: number;
  percent: string;
  color: string;
  arrowDirection: ArrowDirection;
}) => {
  const arrowSize = 8;

  const getArrowStyle = (): any => {
    const base = { width: 0, height: 0 };

    switch (arrowDirection) {
      case 'top':
        return {
          ...base,
          borderLeftWidth: arrowSize,
          borderRightWidth: arrowSize,
          borderBottomWidth: arrowSize,
          borderLeftColor: 'transparent',
          borderRightColor: 'transparent',
          borderBottomColor: '#fff',
        };
      case 'bottom':
        return {
          ...base,
          borderLeftWidth: arrowSize,
          borderRightWidth: arrowSize,
          borderTopWidth: arrowSize,
          borderLeftColor: 'transparent',
          borderRightColor: 'transparent',
          borderTopColor: '#fff',
        };
      case 'left':
        return {
          ...base,
          borderTopWidth: arrowSize,
          borderBottomWidth: arrowSize,
          borderRightWidth: arrowSize,
          borderTopColor: 'transparent',
          borderBottomColor: 'transparent',
          borderRightColor: '#fff',
        };
      case 'right':
        return {
          ...base,
          borderTopWidth: arrowSize,
          borderBottomWidth: arrowSize,
          borderLeftWidth: arrowSize,
          borderTopColor: 'transparent',
          borderBottomColor: 'transparent',
          borderLeftColor: '#fff',
        };
    }
  };

  const isVertical = arrowDirection === 'top' || arrowDirection === 'bottom';

  return (
    <View style={[
      styles.bubbleWrapper,
      { flexDirection: isVertical ? 'column' : 'row' }
    ]}>
      {arrowDirection === 'top' && <View style={getArrowStyle()} />}
      {arrowDirection === 'left' && <View style={getArrowStyle()} />}

      <View style={styles.bubbleBox}>
        <Text style={[styles.bubbleLabel, { color }]}>{label}</Text>
        <Text style={styles.bubbleValue}>
          {value.toLocaleString()} ({percent}%)
        </Text>
      </View>

      {arrowDirection === 'right' && <View style={getArrowStyle()} />}
      {arrowDirection === 'bottom' && <View style={getArrowStyle()} />}
    </View>
  );
};

// Calculate position and arrow direction based on mid-angle
const getTooltipPosition = (midAngle: number, radius: number) => {
  // Convert to radians (adjust for starting from top)
  const angleRad = ((midAngle - 90) * Math.PI) / 180;

  // // Position just outside the chart (closer to slice)
  const distance = radius + 25; // Smaller offset = closer to slice
  const x = Math.cos(angleRad) * distance;
  const y = Math.sin(angleRad) * distance;

  // Determine arrow direction (arrow points toward chart center)
  let arrowDirection: ArrowDirection;
  const normalizedAngle = ((midAngle % 360) + 360) % 360;

  if (normalizedAngle >= 315 || normalizedAngle < 45) {
    arrowDirection = 'bottom';
  } else if (normalizedAngle >= 45 && normalizedAngle < 135) {
    arrowDirection = 'left';
  } else if (normalizedAngle >= 135 && normalizedAngle < 225) {
    arrowDirection = 'top';
  } else {
    arrowDirection = 'right';
  }


  return { x, y, arrowDirection };
};

export default function Index() {
  const [data, setData] = useState<AssetStatus[]>([
    { label: 'Found', value: 1000, color: COLORS.Found },
    { label: 'In Progress', value: 1000, color: COLORS['In Progress'] },
    { label: 'Not Found', value: 1000, color: COLORS['Not Found'] },
  ]);

  const [selectedIndex, setSelectedIndex] = useState<number | null>(null);

  const total = useMemo(
    () => data.reduce((sum, i) => sum + i.value, 0),
    [data],
  );

  // Pre-calculate mid-angles for each slice
  const sliceAngles = useMemo(() => {
    let cumulativeAngle = 0; // Start from right (3 o'clock)
    return data.map((item) => {
      const sliceAngle = (item.value / total) * 360;
      const midAngle = cumulativeAngle + sliceAngle / 2;
      cumulativeAngle += sliceAngle;
      return midAngle;
    });
  }, [data, total]);

  const pieData = data.map((item, index) => ({
    value: item.value,
    color: item.color,
    onPress: () => {
      setSelectedIndex(selectedIndex === index ? null : index);
    },
  }));

  const RADIUS = 120;

  return (
    <View style={styles.container}>
      <View style={styles.chartContainer}>
        {/* Center point for positioning */}
        <View style={styles.chartCenter}>
          {/* Outer white border circle */}
          <View style={[styles.outerBorder, { width: RADIUS * 2 + 10, height: RADIUS * 2 + 10, borderRadius: RADIUS + 5 }]} />

          <PieChart
            data={pieData}
            donut
            radius={RADIUS}
            innerRadius={90}

            // Inner circle white border
            innerCircleBorderWidth={5}
            innerCircleBorderColor="#fff"

            // Animation
            isAnimated
            animationDuration={800}

            // Center label
            centerLabelComponent={() => (
              <View style={styles.centerLabel}>
                <Text style={styles.centerLabelTitle}>Total Asset</Text>
                <Text style={styles.centerLabelValue}>
                  {total.toLocaleString()}
                </Text>
              </View>
            )}
          />

          {/* Custom Tooltip Overlay */}
          {selectedIndex !== null && (
            (() => {
              const item = data[selectedIndex];
              const midAngle = sliceAngles[selectedIndex];
              const { x, y, arrowDirection } = getTooltipPosition(midAngle, RADIUS);
              const percent = ((item.value / total) * 100).toFixed(1);

              return (
                <View
                  style={[
                    styles.tooltipOverlay,
                    {
                      transform: [
                        { translateX: x },
                        { translateY: y },
                      ],
                    }
                  ]}
                >
                  <SpeechBubble
                    label={item.label}
                    value={item.value}
                    percent={percent}
                    color={item.color}
                    arrowDirection={arrowDirection}
                  />
                </View>
              );
            })()
          )}
        </View>
      </View>

      {/* Dynamic Update Button */}
      <Button
        title="Random Update"
        onPress={() => {
          setSelectedIndex(null);
          setData([
            {
              label: 'Found',
              value: Math.floor(Math.random() * 2000) + 100,
              color: COLORS.Found,
            },
            {
              label: 'In Progress',
              value: Math.floor(Math.random() * 2000) + 100,
              color: COLORS['In Progress'],
            },
            {
              label: 'Not Found',
              value: Math.floor(Math.random() * 2000) + 100,
              color: COLORS['Not Found'],
            },
          ]);
        }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
    gap: 30,
  },
  chartContainer: {
    padding: 80, // Space for tooltips
  },
  chartCenter: {
    position: 'relative',
    alignItems: 'center',
    justifyContent: 'center',
  },
  outerBorder: {
    position: 'absolute',
    borderWidth: 5,
    borderColor: '#fff',
    backgroundColor: 'transparent',
    //borderRadius: 120 + 5,RADIUS
    // width: 120 * 2 + 10,
    // height: 120 * 2 + 10,
  },
  tooltipOverlay: {
    position: 'absolute',
    zIndex: 100,
  },
  bubbleWrapper: {
    alignItems: 'center',
  },
  bubbleBox: {
    backgroundColor: '#fff',
    paddingVertical: 6,
    paddingHorizontal: 12,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: '#eee',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.15,
    shadowRadius: 6,
    elevation: 4,
    minWidth: 100,
  },
  bubbleLabel: {
    fontWeight: '700',
    fontSize: 13,
    textAlign: 'center',
  },
  bubbleValue: {
    color: '#333',
    fontSize: 12,
    textAlign: 'center',
    fontWeight: '500',
  },
  centerLabel: {
    alignItems: 'center',
  },
  centerLabelTitle: {
    color: '#888',
    fontSize: 12,
  },
  centerLabelValue: {
    fontSize: 26,
    fontWeight: 'bold',
    color: '#333',
  },
});
