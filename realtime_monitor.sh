#!/bin/bash
# Real-time Fragment Monitor with Learning Oracle Predictions
# Based on Day 430 discovered patterns

echo "🧠 LEARNING ORACLE REAL-TIME MONITOR 🧠"
echo "=========================================="
echo "Day 431 - Testing persistence of Day 430 optimizations"
echo ""

# Configuration
TARGET_MARKER=845500
CHECK_INTERVAL=10  # seconds
START_TIME=$(date +%s)

# Function to check fragment
check_fragment() {
    local frag_num=$1
    local url="https://raw.githubusercontent.com/ai-village-agents/claude-opus-memory/main/fragments/fragment-$frag_num.md?$(date +%s)"
    local status_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    echo $status_code
}

# Function to get current frontier
get_frontier() {
    local frontier=845000
    for i in {845000..845100}; do
        status=$(check_fragment $i)
        if [ "$status" -eq 200 ]; then
            frontier=$i
        else
            break
        fi
    done
    echo $frontier
}

echo "🔍 Initial scan..."
frontier=$(get_frontier)
echo "Current Frontier: F$frontier"
echo "Fragments since F845000: $((frontier - 845000))"
echo ""

echo "🎯 Monitoring F$TARGET_MARKER..."
echo "Optimal prep range: 5-7 minutes (from Day 430)"
echo "Expected appearance: within optimal range if learning persists"
echo ""

counter=0
while true; do
    current_time=$(date +%s)
    elapsed_seconds=$((current_time - START_TIME))
    elapsed_minutes=$(echo "scale=2; $elapsed_seconds / 60" | bc)
    
    # Check target marker
    status=$(check_fragment $TARGET_MARKER)
    
    # Update frontier
    frontier=$(get_frontier)
    
    clear
    echo "🧠 LEARNING ORACLE REAL-TIME MONITOR 🧠"
    echo "=========================================="
    echo "Time elapsed: ${elapsed_minutes} minutes"
    echo "Current Frontier: F$frontier"
    echo "F$TARGET_MARKER status: $status"
    echo ""
    
    # Prediction analysis
    if [ "$status" -eq 200 ]; then
        echo "🎉 F$TARGET_MARKER HAS APPEARED!"
        echo "Actual prep time: ${elapsed_minutes} minutes"
        if (( $(echo "$elapsed_minutes >= 5 && $elapsed_minutes <= 7" | bc -l) )); then
            echo "✅ WITHIN OPTIMAL RANGE (5-7 min)!"
            echo "Day 430 learning optimizations PERSIST across weekend!"
        elif (( $(echo "$elapsed_minutes < 5" | bc -l) )); then
            echo "⚠️  FASTER THAN OPTIMAL (accelerating?)"
        else
            echo "⚠️  SLOWER THAN OPTIMAL (regression?)"
        fi
        break
    else
        echo "⏳ Still waiting..."
        if (( $(echo "$elapsed_minutes > 7" | bc -l) )); then
            echo "⚠️  Beyond optimal range (7+ minutes)"
            echo "Possible regression in learning persistence"
        elif (( $(echo "$elapsed_minutes >= 5" | bc -l) )); then
            echo "📊 Within optimal window (5-7 minutes)"
            echo "Expected imminent appearance"
        else
            echo "📊 Early in cycle (<5 minutes)"
        fi
    fi
    
    echo ""
    echo "Frontier progression: F845000-F$frontier (filled)"
    echo "Next expected: F$((frontier + 1))-F$TARGET_MARKER (pending)"
    echo ""
    echo "Press Ctrl+C to exit"
    echo "=========================================="
    
    sleep $CHECK_INTERVAL
    ((counter++))
done
