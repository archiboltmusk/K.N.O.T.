import React, { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, SafeAreaView } from 'react-native';
import { KnotTheme } from '../theme';

export default function RegistryScreen() {
  const goals = [
    { title: 'First Home Down Payment (Bangalore / Mumbai)', current: 850000, target: 2500000, category: 'Real Estate' },
    { title: 'Zero-Waste Intimate Wedding Fund', current: 550000, target: 1200000, category: 'Life Milestone' },
    { title: 'Kyoto Sabbatical & Reset Fund', current: 200000, target: 600000, category: 'Travel & Growth' }
  ];

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView contentContainerStyle={styles.scroll}>
        <View style={styles.header}>
          <Text style={styles.headerTitle}>Milestone Registry</Text>
          <Text style={styles.headerSub}>50/50 Transparent Joint Life Planning</Text>
        </View>

        {/* Anti-Dowry Badge */}
        <View style={styles.antiDowryCard}>
          <Text style={styles.charterTitle}>⚖️ Anti-Dowry Dignity Charter</Text>
          <Text style={styles.charterDesc}>
            Both partners verify independent financials. Zero dowry pressure, 100% equal milestone partnerships.
          </Text>
        </View>

        {/* Goals List */}
        {goals.map((g, idx) => {
          const pct = Math.round((g.current / g.target) * 100);
          return (
            <View key={idx} style={styles.goalCard}>
              <View style={styles.goalRow}>
                <Text style={styles.goalCategory}>{g.category.toUpperCase()}</Text>
                <Text style={styles.goalPct}>{pct}%</Text>
              </View>
              <Text style={styles.goalTitle}>{g.title}</Text>
              
              {/* Progress Bar */}
              <View style={styles.progressTrack}>
                <View style={[styles.progressFill, { width: `${pct}%` }]} />
              </View>

              <View style={styles.goalRowBottom}>
                <Text style={styles.goalCurrent}>₹{(g.current / 100000).toFixed(1)}L saved</Text>
                <Text style={styles.goalTarget}>Target: ₹{(g.target / 100000).toFixed(1)}L</Text>
              </View>
            </View>
          );
        })}
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: KnotTheme.bgDeep
  },
  scroll: {
    padding: 16
  },
  header: {
    marginBottom: 20
  },
  headerTitle: {
    fontSize: 22,
    fontWeight: 'bold',
    color: KnotTheme.gold
  },
  headerSub: {
    fontSize: 12,
    color: KnotTheme.textSecondary,
    marginTop: 4
  },
  antiDowryCard: {
    padding: 16,
    backgroundColor: KnotTheme.bgCard,
    borderRadius: 14,
    borderWidth: 1,
    borderColor: KnotTheme.borderGold,
    marginBottom: 20
  },
  charterTitle: {
    fontSize: 14,
    fontWeight: 'bold',
    color: '#FFF',
    marginBottom: 6
  },
  charterDesc: {
    fontSize: 12,
    color: KnotTheme.textSecondary,
    lineHeight: 18
  },
  goalCard: {
    padding: 16,
    backgroundColor: KnotTheme.bgSurface,
    borderRadius: 14,
    borderWidth: 1,
    borderColor: KnotTheme.border,
    marginBottom: 16
  },
  goalRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 6
  },
  goalCategory: {
    fontSize: 10,
    fontWeight: 'bold',
    color: KnotTheme.gold,
    letterSpacing: 0.5
  },
  goalPct: {
    fontSize: 12,
    fontWeight: 'bold',
    color: KnotTheme.gold
  },
  goalTitle: {
    fontSize: 15,
    fontWeight: '600',
    color: '#FFF',
    marginBottom: 12
  },
  progressTrack: {
    height: 8,
    backgroundColor: 'rgba(255, 255, 255, 0.08)',
    borderRadius: 4,
    overflow: 'hidden',
    marginBottom: 10
  },
  progressFill: {
    height: '100%',
    backgroundColor: KnotTheme.gold,
    borderRadius: 4
  },
  goalRowBottom: {
    flexDirection: 'row',
    justifyContent: 'space-between'
  },
  goalCurrent: {
    fontSize: 11,
    color: KnotTheme.textSecondary
  },
  goalTarget: {
    fontSize: 11,
    color: KnotTheme.textSecondary
  }
});
