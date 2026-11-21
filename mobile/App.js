import React, { useState } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, SafeAreaView } from 'react-native';
import { StatusBar } from 'expo-status-bar';
import { KnotTheme } from './src/theme';
import DailyDropsScreen from './src/screens/DailyDropsScreen';
import ChatScreen from './src/screens/ChatScreen';
import RegistryScreen from './src/screens/RegistryScreen';

export default function App() {
  const [activeTab, setActiveTab] = useState('drops');

  return (
    <View style={styles.container}>
      <StatusBar style="light" />
      
      {/* Screen Body */}
      <View style={styles.content}>
        {activeTab === 'drops' && <DailyDropsScreen onOpenChat={() => setActiveTab('chat')} />}
        {activeTab === 'chat' && <ChatScreen />}
        {activeTab === 'registry' && <RegistryScreen />}
      </View>

      {/* Luxury Bottom Tab Bar */}
      <SafeAreaView style={styles.tabBar}>
        <TouchableOpacity 
          style={styles.tabItem} 
          onPress={() => setActiveTab('drops')}
        >
          <Text style={[styles.tabIcon, activeTab === 'drops' && styles.tabActiveText]}>✨</Text>
          <Text style={[styles.tabLabel, activeTab === 'drops' && styles.tabActiveText]}>Drops</Text>
        </TouchableOpacity>

        <TouchableOpacity 
          style={styles.tabItem} 
          onPress={() => setActiveTab('chat')}
        >
          <Text style={[styles.tabIcon, activeTab === 'chat' && styles.tabActiveText]}>💬</Text>
          <Text style={[styles.tabLabel, activeTab === 'chat' && styles.tabActiveText]}>Matches</Text>
        </TouchableOpacity>

        <TouchableOpacity 
          style={styles.tabItem} 
          onPress={() => setActiveTab('registry')}
        >
          <Text style={[styles.tabIcon, activeTab === 'registry' && styles.tabActiveText]}>🏛️</Text>
          <Text style={[styles.tabLabel, activeTab === 'registry' && styles.tabActiveText]}>Registry</Text>
        </TouchableOpacity>
      </SafeAreaView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: KnotTheme.bgDeep
  },
  content: {
    flex: 1
  },
  tabBar: {
    flexDirection: 'row',
    backgroundColor: KnotTheme.bgSurface,
    borderTopWidth: 1,
    borderTopColor: KnotTheme.border,
    paddingTop: 8,
    paddingBottom: 4
  },
  tabItem: {
    flex: 1,
    alignItems: 'center',
    paddingVertical: 6
  },
  tabIcon: {
    fontSize: 20,
    color: KnotTheme.textSecondary
  },
  tabLabel: {
    fontSize: 10,
    color: KnotTheme.textSecondary,
    marginTop: 4,
    fontWeight: '600'
  },
  tabActiveText: {
    color: KnotTheme.gold
  }
});
