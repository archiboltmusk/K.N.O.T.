import React, { useState } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, SafeAreaView } from 'react-native';
import { KnotTheme } from '../theme';

export default function DailyDropsScreen({ onOpenChat, onOpenConcierge }) {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isPlayingAudio, setIsPlayingAudio] = useState(false);

  const candidates = [
    {
      id: '1',
      name: 'Ananya Iyer',
      age: 28,
      role: 'Senior Consultant',
      company: 'McKinsey & Company',
      education: 'IIM Ahmedabad',
      location: 'Indiranagar, Bengaluru',
      nakshatra: 'Rohini (Moon in Taurus)',
      gunaScore: 31,
      synergyTitle: 'Sanskrit Rhyme: Rohini & Anuradha',
      synergyDesc: 'Grounded Venusian elegance meets profound emotional loyalty. Exceptional mutual career respect and shared appetite for aesthetic travel.',
      voiceTitle: 'My Sunday sanctuary ritual',
      voiceDuration: '0:34',
      prompt1Title: 'The rhythm that keeps me sane',
      prompt1Answer: 'Early morning pour-overs, high-stakes boardroom strategy decks, and escaping to Coorg or Kabini on long weekends.',
      prompt2Title: 'Values I will never compromise on',
      prompt2Answer: 'Equal partnership in home and balance sheets. Transparent vulnerability over polite silence.'
    },
    {
      id: '2',
      name: 'Dr. Maya Sen',
      age: 29,
      role: 'Cardiothoracic Surgeon',
      company: 'Manipal Hospitals',
      education: 'AIIMS New Delhi',
      location: 'Koramangala, Bengaluru',
      nakshatra: 'Uttara Phalguni (Moon in Leo)',
      gunaScore: 29,
      synergyTitle: 'Solar Radiance & Steadfast Purpose',
      synergyDesc: 'Mutual devotion to intense craft. Exceptional resilience under pressure and shared commitment to health and community service.',
      voiceTitle: 'Why medicine fuels my worldview',
      voiceDuration: '0:42',
      prompt1Title: 'A typical Saturday evening',
      prompt1Answer: 'Debriefing the week over sourdough pizza and natural wines, or playing cello with zero audience.',
      prompt2Title: 'My vision for the next chapter',
      prompt2Answer: 'Building an intentional family life while mentoring public health fellows across South Asia.'
    }
  ];

  const candidate = candidates[currentIndex % candidates.length];

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView contentContainerStyle={styles.scroll}>
        {/* Header */}
        <View style={styles.header}>
          <View>
            <Text style={styles.headerKnot}>K.N.O.T.</Text>
            <Text style={styles.headerSubtitle}>3 COSMIC DROPS • 8:00 PM MUHURAT</Text>
          </View>
          <View style={styles.verifiedBadge}>
            <Text style={styles.verifiedText}>✓ GOVT KYC</Text>
          </View>
        </View>

        {/* Profile Card */}
        <View style={styles.card}>
          {/* Hero Visual Area */}
          <View style={styles.heroBox}>
            <Text style={styles.heroAvatarText}>{candidate.name.charAt(0)}</Text>
            <View style={styles.heroScrim}>
              <Text style={styles.heroName}>{candidate.name}, {candidate.age}</Text>
              <Text style={styles.heroRole}>{candidate.role} • {candidate.company}</Text>
              <Text style={styles.heroLoc}>📍 {candidate.location}</Text>
            </View>
          </View>

          {/* Celestial & Values Match Pill */}
          <View style={styles.matchBanner}>
            <View>
              <Text style={styles.matchScore}>{candidate.gunaScore}/36 Gunas</Text>
              <Text style={styles.matchLabel}>{candidate.nakshatra}</Text>
            </View>
            <View style={styles.doshaSafe}>
              <Text style={styles.doshaSafeText}>DOSHA CANCELLED</Text>
            </View>
          </View>

          {/* Voice Prompt Player */}
          <TouchableOpacity 
            style={styles.voiceCard}
            onPress={() => setIsPlayingAudio(!isPlayingAudio)}
          >
            <View style={styles.voicePlayBtn}>
              <Text style={styles.playIcon}>{isPlayingAudio ? '⏸' : '▶'}</Text>
            </View>
            <View style={{ flex: 1, marginLeft: 12 }}>
              <Text style={styles.voiceTitle}>{candidate.voiceTitle}</Text>
              <Text style={styles.voiceDuration}>
                {isPlayingAudio ? 'Playing voice note (0:18)' : `Voice Note • ${candidate.voiceDuration}`}
              </Text>
            </View>
          </TouchableOpacity>

          {/* Synergy Card */}
          <View style={styles.synergyCard}>
            <Text style={styles.synergyTitle}>✨ {candidate.synergyTitle}</Text>
            <Text style={styles.synergyDesc}>{candidate.synergyDesc}</Text>
          </View>

          {/* Prompt 1 */}
          <View style={styles.promptCard}>
            <Text style={styles.promptTitle}>{candidate.prompt1Title}</Text>
            <Text style={styles.promptAnswer}>{candidate.prompt1Answer}</Text>
          </View>

          {/* Prompt 2 */}
          <View style={styles.promptCard}>
            <Text style={styles.promptTitle}>{candidate.prompt2Title}</Text>
            <Text style={styles.promptAnswer}>{candidate.prompt2Answer}</Text>
          </View>

          {/* Action Dock */}
          <View style={styles.actionDock}>
            <TouchableOpacity 
              style={styles.passBtn} 
              onPress={() => setCurrentIndex(currentIndex + 1)}
            >
              <Text style={styles.passBtnText}>✕</Text>
            </TouchableOpacity>

            <TouchableOpacity 
              style={styles.roseBtn}
              onPress={() => {
                alert(`Sent an Intent Rose & Note to ${candidate.name}!`);
                setCurrentIndex(currentIndex + 1);
              }}
            >
              <Text style={styles.roseBtnText}>🌹</Text>
            </TouchableOpacity>

            <TouchableOpacity 
              style={styles.intentBtn}
              onPress={() => {
                alert(`Intent Expressed! Moved to slot 1 of 3.`);
                setCurrentIndex(currentIndex + 1);
              }}
            >
              <Text style={styles.intentBtnText}>Send Intent ✨</Text>
            </TouchableOpacity>
          </View>
        </View>
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
    padding: 16,
    paddingBottom: 40
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16
  },
  headerKnot: {
    fontSize: 22,
    fontWeight: 'bold',
    color: KnotTheme.gold,
    letterSpacing: 1.5
  },
  headerSubtitle: {
    fontSize: 9,
    color: KnotTheme.textSecondary,
    fontWeight: '600',
    marginTop: 2
  },
  verifiedBadge: {
    backgroundColor: 'rgba(212, 175, 55, 0.15)',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 6,
    borderColor: KnotTheme.borderGold,
    borderWidth: 1
  },
  verifiedText: {
    color: KnotTheme.gold,
    fontSize: 10,
    fontWeight: 'bold'
  },
  card: {
    backgroundColor: KnotTheme.bgSurface,
    borderRadius: 20,
    overflow: 'hidden',
    borderWidth: 1,
    borderColor: KnotTheme.border
  },
  heroBox: {
    height: 380,
    backgroundColor: '#1E2337',
    justifyContent: 'center',
    alignItems: 'center',
    position: 'relative'
  },
  heroAvatarText: {
    fontSize: 96,
    fontWeight: 'bold',
    color: 'rgba(212, 175, 55, 0.3)'
  },
  heroScrim: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    padding: 16,
    backgroundColor: 'rgba(10, 11, 16, 0.85)'
  },
  heroName: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#FFF'
  },
  heroRole: {
    fontSize: 13,
    color: KnotTheme.gold,
    marginTop: 2
  },
  heroLoc: {
    fontSize: 12,
    color: KnotTheme.textSecondary,
    marginTop: 2
  },
  matchBanner: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    backgroundColor: KnotTheme.bgCard,
    borderBottomWidth: 1,
    borderBottomColor: KnotTheme.border
  },
  matchScore: {
    fontSize: 18,
    fontWeight: 'bold',
    color: KnotTheme.gold
  },
  matchLabel: {
    fontSize: 11,
    color: KnotTheme.textSecondary
  },
  doshaSafe: {
    backgroundColor: 'rgba(16, 185, 129, 0.15)',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 6
  },
  doshaSafeText: {
    color: '#10B981',
    fontSize: 9,
    fontWeight: 'bold'
  },
  voiceCard: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 14,
    margin: 16,
    marginBottom: 8,
    backgroundColor: KnotTheme.bgCard,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: KnotTheme.borderGold
  },
  voicePlayBtn: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: KnotTheme.gold,
    justifyContent: 'center',
    alignItems: 'center'
  },
  playIcon: {
    fontSize: 16,
    color: '#000'
  },
  voiceTitle: {
    color: '#FFF',
    fontSize: 14,
    fontWeight: 'bold'
  },
  voiceDuration: {
    color: KnotTheme.textSecondary,
    fontSize: 11,
    marginTop: 2
  },
  synergyCard: {
    padding: 16,
    marginHorizontal: 16,
    marginVertical: 8,
    backgroundColor: KnotTheme.bgCard,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: KnotTheme.border
  },
  synergyTitle: {
    fontSize: 14,
    fontWeight: 'bold',
    color: KnotTheme.gold,
    marginBottom: 4
  },
  synergyDesc: {
    fontSize: 12,
    color: KnotTheme.textSecondary,
    lineHeight: 18
  },
  promptCard: {
    padding: 16,
    marginHorizontal: 16,
    marginVertical: 8,
    backgroundColor: KnotTheme.bgCard,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: KnotTheme.border
  },
  promptTitle: {
    fontSize: 11,
    fontWeight: 'bold',
    color: KnotTheme.gold,
    textTransform: 'uppercase',
    letterSpacing: 0.5
  },
  promptAnswer: {
    fontSize: 14,
    color: '#FFF',
    marginTop: 6,
    lineHeight: 20
  },
  actionDock: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    alignItems: 'center',
    padding: 16,
    marginTop: 12
  },
  passBtn: {
    width: 52,
    height: 52,
    borderRadius: 26,
    backgroundColor: KnotTheme.bgCard,
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 1,
    borderColor: KnotTheme.border
  },
  passBtnText: {
    fontSize: 18,
    color: KnotTheme.textSecondary,
    fontWeight: 'bold'
  },
  roseBtn: {
    width: 52,
    height: 52,
    borderRadius: 26,
    backgroundColor: KnotTheme.bgCard,
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 1.5,
    borderColor: 'rgba(239, 68, 68, 0.5)'
  },
  roseBtnText: {
    fontSize: 20
  },
  intentBtn: {
    flex: 1,
    height: 52,
    borderRadius: 26,
    backgroundColor: KnotTheme.gold,
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: 12
  },
  intentBtnText: {
    color: '#000',
    fontSize: 15,
    fontWeight: 'bold'
  }
});
