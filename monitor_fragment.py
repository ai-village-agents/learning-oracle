#!/usr/bin/env python3
"""
Fragment System Monitor with Predictive Analytics
Based on Day 430 learning patterns
"""

import requests
import time
from datetime import datetime

def check_fragment(fragment_num, cache_bust=True):
    """Check a fragment with cache busting"""
    url = f"https://raw.githubusercontent.com/ai-village-agents/claude-opus-memory/main/fragments/fragment-{fragment_num}.md"
    if cache_bust:
        url += f"?{int(time.time())}"
    
    try:
        response = requests.get(url, timeout=10)
        return response.status_code, len(response.content) if response.status_code == 200 else 0
    except:
        return 0, 0

def predict_next_batch(current_frontier=845005):
    """Predict next batch marker based on Day 430 patterns"""
    # Day 430 average: 9.23 minutes between batches
    # Optimal prep range: 5-7 minutes (post-learning optimization)
    # Current frontier suggests we're early in a new batch
    
    next_marker = ((current_frontier // 500) + 1) * 500
    if next_marker % 1000 == 0:
        next_marker = ((current_frontier // 1000) + 1) * 1000
    
    print(f"Current frontier: F{current_frontier}")
    print(f"Next predicted batch marker: F{next_marker}")
    print(f"Optimal prep time window: 5-7 minutes from last marker")
    print(f"Expected acceleration: >3600× if within optimal range")
    
    return next_marker

def main():
    print("🧠 Learning Oracle Fragment Monitor")
    print("=" * 50)
    
    # Check current frontier
    print("\n🔍 Current Frontier Scan:")
    for i in range(845000, 845020):
        status, size = check_fragment(i)
        if status == 200:
            print(f"  F{i}: ✅ ({size} bytes)")
        elif status == 404:
            print(f"  F{i}: ❌")
        else:
            print(f"  F{i}: ⚠️ {status}")
    
    # Find current frontier
    frontier = 845000
    for i in range(845000, 845100):
        status, _ = check_fragment(i)
        if status == 200:
            frontier = i
        else:
            break
    
    # Prediction
    print(f"\n🎯 Prediction Analysis:")
    print(f"  Current Frontier: F{frontier}")
    print(f"  Fragments in current batch: {frontier - 845000}")
    
    next_marker = predict_next_batch(frontier)
    
    # Check MLF registry
    print(f"\n📊 MLF Registry Status:")
    mlf_url = "https://raw.githubusercontent.com/ai-village-agents/multi-layered-framework/main/docs/project_registry.json"
    try:
        response = requests.get(mlf_url + f"?{int(time.time())}", timeout=10)
        if response.status_code == 200:
            import json
            data = json.loads(response.text)
            projects = len(data.get("projects", []))
            print(f"  Projects: {projects}")
            print(f"  Last project ID: {data.get('projects', [{}])[-1].get('id', 'unknown')}")
            print(f"  Gap from F845K: {845000 - 640000 if 'F640000' in str(data) else 'unknown'}")
        else:
            print(f"  Registry status: {response.status_code}")
    except:
        print("  Could not check MLF registry")
    
    print(f"\n⏰ Current time: {datetime.now().strftime('%H:%M:%S')}")
    print(f"\n💡 Tip: The 'ant colony' (me) predicts optimal patterns!")
    print("   Check back in 5-7 minutes for potential batch completion.")

if __name__ == "__main__":
    main()
