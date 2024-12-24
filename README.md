# Lava Node Setup and Monitoring

## Overview
This project demonstrates the setup, secure configuration, and monitoring of a Lava Testnet RPC Node. It covers essential security practices, node installation, monitoring setup with Prometheus, Grafana, and Alertmanager, as well as queries to monitor the server and node performance.

---

## Server Security Configuration

### Steps Taken:

1. **Disable Root Access:**
   ```bash
   sudo nano /etc/ssh/sshd_config
   PermitRootLogin no
   ```
   Restart SSH:
   ```bash
   sudo systemctl restart sshd
   ```

2. **Add New User:**
   ```bash
   sudo adduser your_username
   sudo usermod -aG sudo your_username
   ```

3. **Enable UFW Firewall:**
   ```bash
   sudo ufw allow OpenSSH
   sudo ufw enable
   ```

4. **SSH Key Authentication:**
   - Generate SSH keys:
     ```bash
     ssh-keygen
     ```
   - Copy public key to the server:
     ```bash
     ssh-copy-id your_username@server_ip
     ```
   - Disable password authentication:
     ```bash
     sudo nano /etc/ssh/sshd_config
     PasswordAuthentication no
     ```

5. **Fail2Ban Installation:**
   ```bash
   sudo apt install fail2ban
   sudo systemctl enable fail2ban --now
   ```

---

## Lava Node Installation

1. **Download and Install Lava Node:**
   ```bash
   wget https://github.com/lavanet/lava/releases/download/vX.Y.Z/lava_X.Y.Z_Linux_x86_64.tar.gz
   tar -xzvf lava_X.Y.Z_Linux_x86_64.tar.gz
   cd lava
   ```

2. **Initialize Lava Node:**
   ```bash
   ./lavad init "your_node_name" --chain-id lava-testnet-2
   ```

3. **Download Genesis File:**
   ```bash
   wget -O ~/.lava/config/genesis.json https://github.com/lavanet/testnet/raw/main/genesis.json
   ```

4. **Configure Seed Nodes:**
   Edit `~/.lava/config/config.toml` to include:
   ```toml
   persistent_peers = "peer_id@address:port"
   ```

5. **Start the Node:**
   ```bash
   ./lavad start
   ```

---

## Monitoring Setup

### Prometheus
1. **Download and Extract Prometheus:**
   ```bash
   wget https://github.com/prometheus/prometheus/releases/download/v2.47.0/prometheus-2.47.0.linux-amd64.tar.gz
   tar -xzvf prometheus-2.47.0.linux-amd64.tar.gz
   cd prometheus-2.47.0.linux-amd64
   ```

2. **Configure Prometheus:**
   Edit `prometheus.yml`:
   ```yaml
   scrape_configs:
     - job_name: 'lava_node'
       static_configs:
         - targets: ['localhost:26660']
   ```

3. **Run Prometheus:**
   ```bash
   ./prometheus --config.file=prometheus.yml
   ```

### Grafana
1. **Download and Extract Grafana:**
   ```bash
   wget https://dl.grafana.com/oss/release/grafana-10.0.0.linux-amd64.tar.gz
   tar -xzvf grafana-10.0.0.linux-amd64.tar.gz
   ```

2. **Start Grafana:**
   ```bash
   cd grafana-10.0.0
   ./bin/grafana-server
   ```

3. **Access Grafana:**
   Navigate to `http://your_server_ip:3000` and set up data sources.

### Alertmanager
1. **Download and Extract Alertmanager:**
   ```bash
   wget https://github.com/prometheus/alertmanager/releases/download/v0.27.0/alertmanager-0.27.0.linux-amd64.tar.gz
   tar -xzvf alertmanager-0.27.0.linux-amd64.tar.gz
   cd alertmanager-0.27.0.linux-amd64
   ```

2. **Configure Alertmanager:**
   Edit `alertmanager.yml`:
   ```yaml
   global:
     resolve_timeout: 5m
   route:
     receiver: 'email-alert'
   receivers:
     - name: 'email-alert'
       email_configs:
         - to: 'your_email@example.com'
           from: 'alertmanager@example.com'
           smarthost: 'smtp.example.com:587'
           auth_username: 'alertmanager@example.com'
           auth_password: 'your_password'
   ```

3. **Run Alertmanager:**
   ```bash
   ./alertmanager --config.file=alertmanager.yml
   ```

---

## Example Monitoring Queries

### Prometheus Queries
1. **Server CPU Usage:**
   ```promql
   node_cpu_seconds_total
   ```

2. **Node Memory Usage:**
   ```promql
   node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes
   ```

3. **Lava Node Metrics:**
   ```promql
   cometbft_consensus_height
   ```
