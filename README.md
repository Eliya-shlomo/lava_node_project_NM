# Lava Testnet RPC Node Setup and Monitoring

This README documents the process of setting up a secure server, installing and running a Lava Testnet RPC node, configuring monitoring tools, and managing queries for effective monitoring.

---

## **Securing the Server**

Before setting up the Lava node, the server was secured to ensure minimal exposure to external threats.

### **Key Steps**

1. **Creating a Dedicated User**:
   ```bash
   adduser secure_user
   usermod -aG sudo secure_user
   ```
2. **Disabling Root Login**:
   Edited the `/etc/ssh/sshd_config` file:
   ```bash
   PermitRootLogin no
   ```
   Restarted SSH:
   ```bash
   systemctl restart ssh
   ```
3. **Enabling Firewall**:
   ```bash
   ufw allow OpenSSH
   ufw enable
   ```
4. **Restricting Access to Specific Ports**:
   Allowed only necessary ports such as `26657`, `26660`, and `9090`.
   ```bash
   ufw allow 26657
   ufw allow 26660
   ufw allow 9090
   ```

---

## **Installing and Running Lava Node**

The Lava Testnet RPC node was installed following the official guidelines.

### **Installation Steps**

1. **Installing Dependencies**:
   ```bash
   sudo apt update && sudo apt upgrade -y
   sudo apt install build-essential git curl -y
   ```

2. **Cloning Lava Repository**:
   ```bash
   git clone https://github.com/lavanet/lava
   cd lava
   make install
   ```

3. **Setting Up the Node**:
   - Initialized the node:
     ```bash
     lavad init "node_name" --chain-id lava-testnet-2
     ```
   - Downloaded the genesis file:
     ```bash
     curl -O <GENESIS_FILE_URL>
     mv genesis.json ~/.lava/config/genesis.json
     ```
   - Configured peers and seeds in `~/.lava/config/config.toml`.

4. **Starting the Node**:
   ```bash
   lavad start
   ```

---

## **Installing Monitoring Tools**

Prometheus, Grafana, and Node Exporter were installed to monitor node and server metrics.

### **Installation Commands**

1. **Prometheus**:
   ```bash
   wget https://github.com/prometheus/prometheus/releases/download/v2.47.0/prometheus-2.47.0.linux-amd64.tar.gz
   tar -xvzf prometheus-2.47.0.linux-amd64.tar.gz
   mv prometheus-2.47.0.linux-amd64 /usr/local/prometheus
   ```

2. **Node Exporter**:
   ```bash
   wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz
   tar -xvzf node_exporter-1.8.2.linux-amd64.tar.gz
   mv node_exporter-1.8.2.linux-amd64 /usr/local/node_exporter
   ```

3. **Grafana**:
   ```bash
   wget https://dl.grafana.com/oss/release/grafana-10.0.0.linux-amd64.tar.gz
   tar -xvzf grafana-10.0.0.linux-amd64.tar.gz
   mv grafana-10.0.0 /usr/local/grafana
   ```

---

## **Monitoring Queries**

### **Server Monitoring**

Prometheus collects server metrics such as CPU usage, memory consumption, and disk I/O.

#### **Example Queries**:

1. **CPU Usage**:
   ```promQL
   100 - (avg by (instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
   ```

2. **Memory Usage**:
   ```promQL
   node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes * 100
   ```

### **Node Monitoring**

The Lava RPC node metrics were exposed via the `26660/metrics` endpoint.

#### **Example Queries**:

1. **Block Height**:
   ```promQL
   cometbft_consensus_latest_block_height{job="lava_node"}
   ```

2. **Number of Peers**:
   ```promQL
   cometbft_p2p_peers{job="lava_node"}
   ```

---

## **General Guidelines**

1. **Use Firewalls**:
   Restrict access to the server and node to trusted IPs only.

2. **Regular Updates**:
   Keep the node, server software, and monitoring tools up-to-date.

3. **Secure Data**:
   Use `.gitignore` to prevent sensitive files like `.ssh` and `.config` from being uploaded to repositories.

---

For more details, refer to the official Lava documentation or the Prometheus/Grafana user guides.
