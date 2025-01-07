# Lava Node Setup and Monitoring

## Overview
This project demonstrates the setup, secure configuration, and monitoring of a Lava Testnet RPC Node. It covers essential security practices, node installation, monitoring setup with Prometheus, Grafana, and Alertmanager, as well as queries to monitor the server and node performance.

---

## Server Organization and Permissions

### User Roles and Responsibilities

1. **`eyal` (Admin):**
   - Full system administration privileges.
   - Can manage users, permissions, and system-wide services.
   - **Home directory:** `/home/eyal`

2. **`eliya` (Cloud Engineer):**
   - Responsible for Lava Node setup, configuration, and testing.
   - Has access to Lava Node-related directories and Docker setup.
   - **Home directory:** `/home/eliya`

3. **`lava-node` (Service User):**
   - Dedicated user for running Docker containers and managing the Lava Node containerized environment.
   - Restricted to container operations and logs.
   - **Home directory:** `/home/lava-node`

### Directory Permissions

| Path                          | Owner       | Permissions |
|-------------------------------|-------------|-------------|
| `/usr/local/bin/lavad`        | `root`      | `755`       |
| `/home/eliya/.lava/`          | `eliya`     | `700`       |
| `/home/lava-node/.lava/`      | `lava-node` | `700`       |
| `/var/lib/docker`             | `root`      | `755`       |

### File Permissions

| File                          | Owner       | Permissions |
|-------------------------------|-------------|-------------|
| `config.toml` (in `.lava/`)   | `eliya`     | `644`       |
| `app.toml` (in `.lava/`)      | `eliya`     | `644`       |
| `genesis.json` (in `.lava/`)  | `eliya`     | `644`       |
| `addrbook.json` (in `.lava/`) | `eliya`     | `644`       |
| `prometheus.yml`              | `lava-node` | `644`       |

---

## Server Security Configuration

### Firewall Setup

1. **Enable and Configure UFW Firewall:**
   ```bash
   sudo apt install ufw -y
   sudo ufw allow OpenSSH
   sudo ufw allow 14457/tcp  # Lava RPC Port
   sudo ufw allow 14566/tcp  # Prometheus Monitoring Port
   sudo ufw enable
   ```

2. **Verify Firewall Rules:**
   ```bash
   sudo ufw status
   ```

### Secure SSH Configuration

1. **Disable Root SSH Login:**
   Edit the SSH configuration file:
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```
   Update or add the following lines:
   ```
   PermitRootLogin no
   PasswordAuthentication no
   ```
   Restart the SSH service:
   ```bash
   sudo systemctl restart sshd
   ```

2. **Add and Configure Users:**
   - Add users `eliya` and `eyal`:
     ```bash
     sudo adduser eliya
     sudo adduser eyal
     ```
   - Grant `eyal` admin privileges:
     ```bash
     sudo usermod -aG sudo eyal
     ```

3. **Set Up SSH Key Authentication:**
   - Generate SSH keys on your local machine:
     ```bash
     ssh-keygen -t rsa -b 4096
     ```
   - Copy the public key to the server:
     ```bash
     ssh-copy-id eliya@<server_ip>
     ssh-copy-id eyal@<server_ip>
     ```
   - Verify SSH login works without a password.

4. **Install and Configure Fail2Ban:**
   - Install Fail2Ban:
     ```bash
     sudo apt install fail2ban -y
     ```
   - Enable Fail2Ban:
     ```bash
     sudo systemctl enable fail2ban --now
     ```
   - Optionally customize `/etc/fail2ban/jail.local` to suit your security policies.

---

## Lava Node Installation

1. **Download and Install Lava Node:**
   ```bash
   wget https://github.com/lavanet/lava/releases/download/v4.2.0/lava_4.2.0_Linux_x86_64.tar.gz
   tar -xzvf lava_4.2.0_Linux_x86_64.tar.gz
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
   prometheus = true
   prometheus_listen_addr = "0.0.0.0:14566"
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
         - targets: ['localhost:14566']
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

---

