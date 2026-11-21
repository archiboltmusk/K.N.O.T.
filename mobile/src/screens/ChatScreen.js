import React, { useState } from 'react';
import { View, Text, StyleSheet, FlatList, TextInput, TouchableOpacity, SafeAreaView } from 'react-native';
import { KnotTheme } from '../theme';

export default function ChatScreen() {
  const [messages, setMessages] = useState([
    {
      id: '1',
      sender: 'Concierge',
      text: '✨ KMVA Match formed at 8:00 PM Shubh Muhurat. Synastry highlights: Earth & Water harmony with shared high-drive career pace.',
      isMe: false,
      timestamp: 'Yesterday'
    },
    {
      id: '2',
      sender: 'Ananya',
      text: 'Hey! Loved your note on balancing venture building with quiet weekend hikes.',
      isMe: false,
      timestamp: 'Yesterday 9:15 PM'
    },
    {
      id: '3',
      sender: 'You',
      text: 'Hi Ananya! Thanks. Kabini and Coorg have been my go-to resets lately. Also noticed we both have Kyoto on our 3-year bucket list!',
      isMe: true,
      timestamp: 'Today 10:20 AM'
    },
    {
      id: '4',
      sender: 'Ananya',
      text: 'I completely agree about the sabbatical in Kyoto! Have you stayed in Gion?',
      isMe: false,
      timestamp: 'Today 2:45 PM'
    }
  ]);
  const [inputText, setInputText] = useState('');

  const sendMessage = () => {
    if (!inputText.trim()) return;
    setMessages([
      ...messages,
      {
        id: Date.now().toString(),
        sender: 'You',
        text: inputText,
        isMe: true,
        timestamp: 'Just now'
      }
    ]);
    setInputText('');
  };

  return (
    <SafeAreaView style={styles.container}>
      {/* Top Banner */}
      <View style={styles.header}>
        <View>
          <Text style={styles.headerName}>Ananya Iyer, 28</Text>
          <Text style={styles.headerSub}>Rohini Nakshatra • McKinsey</Text>
        </View>
        <View style={styles.graceBadge}>
          <Text style={styles.graceText}>⏳ 38h Grace</Text>
        </View>
      </View>

      {/* Zero Ghosting Notice */}
      <View style={styles.ghostingNotice}>
        <Text style={styles.ghostingNoticeText}>
          Strict 3-concurrency active slots. Zero-ghosting policy active.
        </Text>
      </View>

      {/* Messages List */}
      <FlatList
        data={messages}
        keyExtractor={(item) => item.id}
        contentContainerStyle={styles.list}
        renderItem={({ item }) => (
          <View style={[styles.bubbleWrap, item.isMe ? styles.bubbleMeWrap : styles.bubbleThemWrap]}>
            <View style={[styles.bubble, item.isMe ? styles.bubbleMe : styles.bubbleThem]}>
              <Text style={[styles.bubbleText, item.isMe ? styles.bubbleMeText : styles.bubbleThemText]}>
                {item.text}
              </Text>
              <Text style={styles.timestamp}>{item.timestamp}</Text>
            </View>
          </View>
        )}
      />

      {/* Input */}
      <View style={styles.inputContainer}>
        <TextInput
          style={styles.input}
          placeholder="Send an intentional message..."
          placeholderTextColor={KnotTheme.textSecondary}
          value={inputText}
          onChangeText={setInputText}
        />
        <TouchableOpacity style={styles.sendBtn} onPress={sendMessage}>
          <Text style={styles.sendBtnText}>↑</Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: KnotTheme.bgDeep
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    backgroundColor: KnotTheme.bgSurface,
    borderBottomWidth: 1,
    borderBottomColor: KnotTheme.border
  },
  headerName: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#FFF'
  },
  headerSub: {
    fontSize: 12,
    color: KnotTheme.gold,
    marginTop: 2
  },
  graceBadge: {
    backgroundColor: 'rgba(212, 175, 55, 0.15)',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 6
  },
  graceText: {
    color: KnotTheme.gold,
    fontSize: 11,
    fontWeight: 'bold'
  },
  ghostingNotice: {
    padding: 8,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    alignItems: 'center'
  },
  ghostingNoticeText: {
    color: KnotTheme.textSecondary,
    fontSize: 11
  },
  list: {
    padding: 16
  },
  bubbleWrap: {
    marginBottom: 12,
    maxWidth: '80%'
  },
  bubbleMeWrap: {
    alignSelf: 'flex-end'
  },
  bubbleThemWrap: {
    alignSelf: 'flex-start'
  },
  bubble: {
    padding: 12,
    borderRadius: 14
  },
  bubbleMe: {
    backgroundColor: KnotTheme.gold
  },
  bubbleThem: {
    backgroundColor: KnotTheme.bgCard,
    borderWidth: 1,
    borderColor: KnotTheme.border
  },
  bubbleText: {
    fontSize: 14,
    lineHeight: 20
  },
  bubbleMeText: {
    color: '#000'
  },
  bubbleThemText: {
    color: '#FFF'
  },
  timestamp: {
    fontSize: 9,
    color: KnotTheme.textSecondary,
    marginTop: 4,
    alignSelf: 'flex-end'
  },
  inputContainer: {
    flexDirection: 'row',
    padding: 12,
    backgroundColor: KnotTheme.bgSurface,
    borderTopWidth: 1,
    borderTopColor: KnotTheme.border
  },
  input: {
    flex: 1,
    backgroundColor: KnotTheme.bgCard,
    borderRadius: 20,
    paddingHorizontal: 16,
    paddingVertical: 10,
    color: '#FFF',
    borderWidth: 1,
    borderColor: KnotTheme.border
  },
  sendBtn: {
    width: 42,
    height: 42,
    borderRadius: 21,
    backgroundColor: KnotTheme.gold,
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: 8
  },
  sendBtnText: {
    color: '#000',
    fontSize: 20,
    fontWeight: 'bold'
  }
});
