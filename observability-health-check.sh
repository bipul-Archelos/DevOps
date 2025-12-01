#!/bin/bash

echo "=== 🔍 Alloy → Loki → Grafana → Prometheus Health Check ==="

# 1. Check Alloy
echo -e "\n[1] Checking Alloy..."
if curl -s http://localhost:12345/metrics > /dev/null; then
  echo "✔ Alloy is running"
else
  echo "❌ Alloy NOT running"
fi

# 2. Check Loki
echo -e "\n[2] Checking Loki..."
if curl -s http://localhost:3100/ready | grep -q ready; then
  echo "✔ Loki is running"
else
  echo "❌ Loki NOT running"
fi

# 3. Create test log
echo -e "\n[3] Creating test log for Alloy → Loki test..."
LOG_MSG="ALLOY_TEST_LOG $(date)"
sudo echo "$LOG_MSG" >> /var/log/syslog
echo "✔ Test log sent: $LOG_MSG"

# 4. Wait for Alloy to forward logs
sleep 3

# 5. Query Loki
echo -e "\n[4] Querying Loki for test log..."
QUERY=$(curl -G -s "http://localhost:3100/loki/api/v1/query" \
  --data-urlencode 'query={job="system"}')

echo "$QUERY" | grep -q "ALLOY_TEST_LOG"

if [ $? -eq 0 ]; then
  echo "🎉 SUCCESS → Test log found in Loki!"
else
  echo "❌ FAILED → Test log NOT found in Loki"
  echo "Raw Loki Response:"
  echo "$QUERY"
fi

# 6. Grafana check
echo -e "\n[5] Checking Grafana..."
if curl -s http://localhost:3000/api/health | grep -q ok; then
  echo "✔ Grafana is running"
else
  echo "❌ Grafana NOT running"
fi

# 7. Prometheus check
echo -e "\n[6] Checking Prometheus..."
if curl -s http://localhost:9090/api/v1/query?query=up | grep -q success; then
  echo "✔ Prometheus is running"
else
  echo "❌ Prometheus NOT running"
fi

echo -e "\n=== ✅ Health Check Complete ==="
