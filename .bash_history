

[Install]
WantedBy=multi-user.target
EOF

sudo -S systemctl daemon-reload
sudo -S systemctl enable lava
sudo -S systemctl start lava
sudo systemctl status lava
sudo journalctl -u lava.service -f --no-hostname -o cat
sudo nano /etc/systemd/system/lava.service
ls /home/eliya/go/bin/cosmovisor
sudo ls /home/eliya/go/bin/cosmovisor
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@latest
ls /home/eliya/go/bin/cosmovisor
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@latest
go version
cd ..
sudo rm -rf /usr/local/go
wget https://golang.org/dl/go1.21.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.21.3.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
source ~/.profile
go version
ls
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@latest
ls $HOME/go/bin/cosmovisor
sudo systemctl daemon-reload
sudo systemctl restart lava.service
sudo systemctl status lava.service
sudo journalctl -u lava.service -f
lavad version
cd ~/lava
git fetch --all
git checkout v4.2.0
make build
cd ..
ls
rm -rf lava/
ls
cd $HOME
rm -rf lava
git clone https://github.com/lavanet/lava.git
cd lava
git checkout v v4.2.0
git checkout v4.2.0
export LAVA_BINARY=lavad
make build
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@latest
ls
cd ..
ls
cd lava/
cd ..
sudo rm -rf /usr/local/go
wget https://go.dev/dl/go1.23.4.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.23.4.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
source ~/.profile
go version
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@latest
ls $HOME/go/bin/cosmovisor
cat ls $HOME/go/bin/cosmovisor
mkdir -p $HOME/.lava/cosmovisor/genesis/bin
mv build/lavad $HOME/.lava/cosmovisor/genesis/bin/
rm -rf build
cd lava/
mkdir -p $HOME/.lava/cosmovisor/genesis/bin
mv build/lavad $HOME/.lava/cosmovisor/genesis/bin/
rm -rf build
sudo ln -s $HOME/.lava/cosmovisor/genesis $HOME/.lava/cosmovisor/current -f
sudo ln -s $HOME/.lava/cosmovisor/current/bin/lavad /usr/local/bin/lavad -f
lavad config chain-id lava-testnet-2
lavad config keyring-backend test
lavad config node tcp://localhost:14457
lavad init $LAVA_MONIKER --chain-id lava-testnet-2
curl -Ls https://snapshots.kjnodes.com/lava-testnet/genesis.json > $HOME/.lava/config/genesis.json
curl -Ls https://snapshots.kjnodes.com/lava-testnet/addrbook.json > $HOME/.lava/config/addrbook.json
sed -i -e "s|^seeds *=.*|seeds = \"3f472746f46493309650e5a033076689996c8881@lava-testnet.rpc.kjnodes.com:14459\"|" $HOME/.lava/config/config.toml
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0ulava\"|" $HOME/.lava/config/app.toml
sed -i   -e 's|^pruning *=.*|pruning = "custom"|'   -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|'   -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|'   -e 's|^pruning-interval *=.*|pruning-interval = "19"|'   $HOME/.lava/config/app.toml
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:14458\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:14457\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:14460\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:14456\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":14466\"%" $HOME/.lava/config/config.toml
sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:14417\"%; s%^address = \":8080\"%address = \":14480\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:14490\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:14491\"%; s%:8545%:14445%; s%:8546%:14446%; s%:6065%:14465%" $HOME/.lava/config/app.toml
sed -i   -e 's/timeout_commit = ".*"/timeout_commit = "30s"/g'   -e 's/timeout_propose = ".*"/timeout_propose = "1s"/g'   -e 's/timeout_precommit = ".*"/timeout_precommit = "1s"/g'   -e 's/timeout_precommit_delta = ".*"/timeout_precommit_delta = "500ms"/g'   -e 's/timeout_prevote = ".*"/timeout_prevote = "1s"/g'   -e 's/timeout_prevote_delta = ".*"/timeout_prevote_delta = "500ms"/g'   -e 's/timeout_propose_delta = ".*"/timeout_propose_delta = "500ms"/g'   -e 's/skip_timeout_commit = ".*"/skip_timeout_commit = false/g'   $HOME/.lava/config/config.toml
sed -i   -e 's/timeout_commit = ".*"/timeout_commit = "30s"/g'   -e 's/timeout_propose = ".*"/timeout_propose = "1s"/g'   -e 's/timeout_precommit = ".*"/timeout_precommit = "1s"/g'   -e 's/timeout_precommit_delta = ".*"/timeout_precommit_delta = "500ms"/g'   -e 's/timeout_prevote = ".*"/timeout_prevote = "1s"/g'   -e 's/timeout_prevote_delta = ".*"/timeout_prevote_delta = "500ms"/g'   -e 's/timeout_propose_delta = ".*"/timeout_propose_delta = "500ms"/g'   -e 's/skip_timeout_commit = ".*"/skip_timeout_commit = false/g'   $HOME/.lava/config/config.toml
sudo tee /etc/systemd/system/lava.service > /dev/null << EOF
[Unit]
Description=lava node service
After=network-online.target


[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.lava"
Environment="DAEMON_NAME=lavad"
Environment="UNSAFE_SKIP_BACKUP=true"




[Install]
WantedBy=multi-user.target
EOF

sudo -S systemctl daemon-reload
sudo -S systemctl enable lava
sudo -S systemctl start lava
sudo systemctl status lava
sudo journalctl -u lava.service -f --no-hostname -o cat
sudo systemctl stop lava.service
sudo systemctl start lava.service
sudo systemctl status lava.service
sudo journalctl -u lava.service -f
wget https://github.com/prometheus/prometheus/releases/download/v2.47.0/prometheus-2.47.0.linux-amd64.tar.gz
tar xvf prometheus-2.47.0.linux-amd64.tar.gz
sudo mv prometheus-2.47.0.linux-amd64 /usr/local/prometheus
tar xvf prometheus-2.47.0.linux-amd64.tar.gz
sudo mv prometheus-2.47.0.linux-amd64 /usr/local/prometheus
sudo nano /etc/systemd/system/prometheus.service
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus
wget https://github.com/prometheus/node_exporter/releases/latest/download/node_exporter-1.6.1.linux-amd64.tar.gz
wget https://github.com/prometheus/node_exporter/releases/latest/download/node_exporter-1.6.1.linux-amd64.tar.gz
wget node_exporter-1.8.2.darwin-amd64.tar.gz
wget https://github.com/prometheus/node_exporter/releases/latest/download/node_exporter-1.6.1.linux-amd64.tar.gz
wget https://github.com/prometheus/node_exporter/releases/latest/download/node_exporter-1.8.2.linux-amd64.tar.gz
tar xvf node_exporter-1.8.2.linux-amd64.tar.gz
sudo mv node_exporter-1.8.2.linux-amd64/node_exporter /usr/local/bin/
sudo nano /etc/systemd/system/node_exporter.service
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter
sudo systemctl status node_exporter
nano /usr/local/prometheus/prometheus.yml
sudo systemctl restart prometheus
sudo systemctl status prometheus
ls
sudo apt install monit
sudo nano /etc/monit/monitrc
sudo systemctl restart monit
sudo systemctl enable monit
monit status
sudo monit status
set httpd
monit status
sudo apt install tcpdump
sudo tcpdump -i eth0 port 26657
monit status
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
sudo systemctl restart prometheus
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter
sudo systemctl status node_exporter
sudo systemctl status prometheus
sudo nano /etc/monit/monitrc
ls -l /etc/monit/monitrc
sudo chmod 700 /etc/monit/monitrc
sudo systemctl restart monit
sudo apt-get update
sudo apt-get install -y grafana
sudo systemctl enable grafana-server
sudo systemctl start grafana-server
ls /etc/systemd/system/grafana-server.service
wget https://dl.grafana.com/oss/release/grafana-10.0.0.linux-amd64.tar.gz
tar -zxvf grafana-10.0.0.linux-amd64.tar.gz
sudo mv grafana-10.0.0 /usr/local/grafana
sudo /usr/local/grafana/bin/grafana-server
sudo lsof -i :9090
sudo nano /usr/local/prometheus/prometheus.yml
sudo systemctl restart prometheus
sudo journalctl -u prometheus.service -f
hostname -I
sudo tcpdump -i eth0 port 26657
sudo ufw allow 9090
sudo ufw reload
sudo systemctl status prometheus
sudo systemctl start prometheus
sudo lsof -i :9090
nano prometheus.yml
exit
sudo nano /etc/fail2ban/jail.local
sudo fail2ban-client status
sudo nano /etc/fail2ban/jail.local
sudo ufw status
sudo ufw allow 3000
sudo systemctl start prometheus
sudo systemctl enable prometheus
sudo systemctl status prometheus
sudo nano /usr/local/prometheus/prometheus.yml
sudo nano /etc/systemd/system/prometheus.service
sudo systemctl daemon-reload
sudo systemctl restart prometheus
sudo systemctl status node_exporter
sudo systemctl status prometheus
sudo journalctl -u prometheus.service -f
sudo netstat -tuln | grep 9090
sudo nano /etc/systemd/system/prometheus.service
sudo nano /usr/local/prometheus/prometheus.yml
sudo systemctl daemon-reload
sudo systemctl restart prometheus
sudo netstat -tuln | grep 9091
sudo systemctl status prometheus
sudo lsof -i :9090
sudo nano /etc/systemd/system/prometheus.service
sudo nano /etc/systemd/system/prometheus.service
sudo systemctl daemon-reload
sudo systemctl restart prometheus
exit
sudo lsof -i :9091
sudo nano /etc/systemd/system/prometheus.service
sudo nano /usr/local/prometheus/prometheus.yml
sudo systemctl daemon-reload
sudo systemctl restart prometheus
sudo netstat -tuln | grep 9092
sudo lsof -i :9092
curl ifconfig.me
wget -qO- ifconfig.me
sudo uwf allow 9092
sudo ufw allow 9092 
sudo ufw allow 3000
sudo systemctl status prometheus
sudo systemctl status grafana-server
curl http://localhost:9090
sudo ufw allow 9090
sudo lsof -i :3000
sudo systemctl status grafana-server
sudo systemctl start grafana-server
sudo apt-get install -y software-properties-common
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt-get update
sudo apt-get install -y grafana
sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
sudo systemctl status grafana-server
sudo netstat -tuln | grep 3000
sudo lsof -i :19999
sudo lsof -i :19999
sudo apt update && sudo apt upgrade -y
bash <(curl -Ss https://my-netdata.io/kickstart.sh)
sudo systemctl status netdata
bash <(curl -Ss https://netdata.io/kickstart.sh)
ping netdata.io
ping 8.8.8.8
ping google.com
sudo nano /etc/resolv.conf
ping netdata.io
sudo apt install netdata -y
sudo systemctl start netdata
sudo systemctl enable netdata
sudo ufw status
sudo ufw allow 19999
sudo ufw allow 19999
sudo systemctl reload  netdata
sudo systemctl restart  netdata
sudo nano /etc/prometheus/prometheus.yml
sudo nano /etc/prometheus/prometheus.yml
which prometheus
ls /usr/local/prometheus
sudo mkdir -p /etc/prometheus
sudo mkdir -p /etc/prometheus/rules
sudo mkdir -p /etc/prometheus/targets
sudo touch /etc/prometheus/prometheus.yml
find / -name prometheus.yml
sudo find / -name prometheus.yml
sudo nano /usr/local/prometheus/prometheus.yml
xit
wget https://github.com/prometheus/node_exporter/releases/latest/download/node_exporter-1.6.1.linux-amd64.tar.gz
tar xvfz node_exporter-1.6.1.linux-amd64.tar.gz
sudo mv node_exporter-1.6.1.linux-amd64/node_exporter /usr/local/bin/
rm -rf node_exporter-1.6.1.linux-amd64*
sudo nano /etc/systemd/system/node_exporter.service
wget https://github.com/prometheus/node_exporter/releases/latest/download/node_exporter-1.6.1.linux-amd64.tar.gz
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.1/node_exporter-1.8.1.linux-amd64.tar.gz
tar xvfz node_exporter-1.8.1.linux-amd64.tar.gz
sudo mv node_exporter-1.8.1.linux-amd64/node_exporter /usr/local/bin/
rm -rf node_exporter-1.8.1.linux-amd64*
sudo nano /etc/systemd/system/node_exporter.service
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter
sudo systemctl status node_exporter
wget https://github.com/prometheus/prometheus/releases/latest/download/prometheus-2.47.0.linux-amd64.tar.gz
wget https://github.com/prometheus/prometheus/releases/download/v2.47.0/prometheus-2.47.0.linux-amd64.tar.gz
tar xvf prometheus-2.47.0.linux-amd64.tar.gz
sudo mv prometheus-2.47.0.linux-amd64 /usr/local/prometheus
tar xvf prometheus-2.47.0.linux-amd64.tar.gz
sudo mv prometheus-2.47.0.linux-amd64 /usr/local/prometheus
sudo rm -rf /usr/local/prometheus
sudo mv prometheus-2.47.0.linux-amd64 /usr/local/prometheus
ls /usr/local/prometheus
sudo apt-get install -y software-properties-common
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
sudo apt-get update
sudo apt-get install grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
wget https://github.com/prometheus/alertmanager/releases/latest/download/alertmanager-0.25.0.linux-amd64.tar.gz
wget https://github.com/prometheus/alertmanager/releases/download/v0.27.0/alertmanager-0.27.0.linux-amd64.tar.gz
tar xvf alertmanager-0.27.0.linux-amd64.tar.gz
sudo mv alertmanager-0.27.0.linux-amd64 /usr/local/alertmanager
/usr/local/alertmanager/alertmanager --config.file=/usr/local/alertmanager/alertmanager.yml
sudo nano /usr/local/prometheus/prometheus.yml
makdir /usr/local/prometheus/alerts.yml
mkdir /usr/local/prometheus/alerts.yml
sudo nano /usr/local/prometheus/alerts.yml
rm /usr/local/prometheus/alerts.yml
rmdir /usr/local/prometheus/alerts.yml
touch /usr/local/prometheus/alerts.yml
nano /usr/local/prometheus/alerts.yml
touch /usr/local/alertmanager/alertmanager.yml
nano /usr/local/alertmanager/alertmanager.yml
sudo systemctl restart prometheus
sudo systemctl enable prometheus
sudo /usr/local/alertmanager/alertmanager --config.file=/usr/local/alertmanager/alertmanager.yml &
sudo systemctl status 
cd lava/
sudo systemctl status 
sudo systemctl status lava.service
sudo systemctl status prometheus
sudo systemctl status prometheus
sudo systemctl status netdata
sudo ufw status
sudo ufw allow 9100
sudo journalctl -u prometheus -f
sudo nano /etc/prometheus/prometheus.yml
sudo nano /etc/prometheus/prometheus.yml
sudo nano /usr/local/prometheus/prometheus.yml
prometheus --config.file=/etc/prometheus/prometheus.yml --dry-run
cd ..
prometheus --config.file=/etc/prometheus/prometheus.yml --dry-run
cd lava/
prometheus --config.file=/usr/local/prometheus/prometheus.yml --dry-run
sudo systemctl restart prometheus
sudo systemctl status prometheus
nano ~/.lava/config/config.toml
sudo lsof -i :14457
telnet localhost 14457
sudo lsof -i :9090
sudo lsof -i :9091
sudo lsof -i :9092
Endpoint	State	Labels	Last Scrape	Scrape Duration	Error
http://localhost:14457/metrics	DOWN	
instance="localhost:14457"job="lava_node"
34.627s ago	
0.990ms
Get "http://localhost:14457/metrics": dial tcp 127.0.0.1:14457: connect: connection refused
sudo systemctl status lava.service
sudo lsof -i :14457
sudo lsof -i :14457
~/.lava/config/config.toml
sudo nano ~/.lava/config/config.toml
sudo nano /usr/local/prometheus/prometheus.yml
sudo systemctl restart prometheus
sudo systemctl status prometheus
sudo nano /usr/local/prometheus/prometheus.yml
sudo systemctl restart prometheus
sudo systemctl status prometheus
sudo lsof -i :14457
sudo systemctl start lava.service
sudo systemctl status lava.service
sudo systemctl status lava.service
sudo lsof -i :14457
sudo ufw status
curl http://localhost:14457/metrics
nano ~/.lava/config/config.toml
sudo systemctl restart lava.service
sudo systemctk status lava,service
sudo systemctk status lava.service
sudo systemctl status lava.service
sudo nano /usr/local/prometheus/prometheus.yml
sudo systemctl restart prometheus
exit
sudo lsof -i :14457
curl http://localhost:14457/metrics
nano ~/.lava/config/config.toml
sudo systemctl restart lava.service
sudo systemctl restart lava.service
nano ~/.lava/config/config.toml
sudo systemctl restart lava.service
nano ~/.lava/config/config.toml
sudo systemctl restart prometheus
curl http://localhost:14467/metrics
cd lava/
curl http://localhost:14467/metrics
CD ..
cd ..
sudo systemctl restart lava.service
sudo lsof -i :14467
cd lava/
sudo lsof -i :14467
cd ..
sudo journalctl -u lava.service -f
sudo systemctl status lava.sevice
sudo systemctl status lava.service
cd lava/
sudo systemctl status lava.service
nano ~/.lava/config/config.toml
sudo systemctl restart lava.service
sudo systemctl status lava.service
nano ~/.lava/config/config.toml
sudo systemctl restart lava.service
sudo systemctl status lava.service
sudo journalctl -u lava.service -f
sudo journalctl -u lava.service -f
sudo systemctl daemon-reload
sudo systemctl restart lava.service
sudo systemctl status lava.service
curl http://localhost:14457/status
nano ~/.lava/config/config.toml
sudo systemctl restart lava.service
curl http://localhost:14457/status
sudo systemctl status lava.service
nano ~/.lava/config/config.toml
sudo systemctl daemon-reload
sudo nano /etc/systemd/system/lava.service
sudo lsof -i :14457
sudo uwf status
sudo ufw status
sudo journalctl -u lava.service -f
tomlcheck /home/eliya/.lava/config/config.toml
sudo install tomlcheck
sudo install tomlcheck
sudo nano /etc/systemd/system/lava.service
nano ~/.lava/config/config.toml
sudo systemctl status lava.service
nano ~/.lava/config/config.toml
sudo systemctl restart lava.service
sudo systemctl restart prometheus
sudo nano /usr/local/prometheus/prometheus.yml
sudo systemctl restart prometheus
exit
nano ~/.lava/config/config.toml
sudo systemctl restart lava.service
curl http://localhost:26660/metrics
--storage.tsdb.retention.time=30d
sudo nano /etc/systemd/system/prometheus.service
sudo systemctl daemon-reload
sudo systemctl restart prometheus
sudo nano /etc/systemd/system/prometheus.service
sudo systemctl daemon-reload
sudo systemctl restart prometheus
sudo nano /etc/systemd/system/prometheus.service
sudo systemctl daemon-reload
sudo systemctl restart prometheus
sudo systemctl status prometheus
http://<your-server-ip>:9090/targets
sudo nano /etc/systemd/system/prometheus.service
sudo nano /etc/systemd/system/prometheus.service
/usr/local/prometheus/prometheus --config.file=/usr/local/prometheus/prometheus.yml --version
sudo nano /etc/systemd/system/prometheus.service
sudo systemctl daemon-reload
/usr/local/prometheus/prometheus --config.file=/usr/local/prometheus/prometheus.yml --version
sudo systemctl restart prometheus
sudo systemctl status prometheus
sudo nano /etc/systemd/system/prometheus.service
sudo systemd-analyze verify /etc/systemd/system/prometheus.service
sudo systemctl daemon-reload
sudo systemctl restart prometheus
sudo systemctl status prometheus
sudo systemctl status prometheus
sudo journalctl -u prometheus.service -f
sudo nano /etc/systemd/system/prometheus.service
sudo systemctl daemon-reload
sudo systemctl restart prometheus
sudo systemctl status prometheus
sudo mkdir -p /usr/local/prometheus/data
sudo chown root:root /usr/local/prometheus/data
sudo chmod 755 /usr/local/prometheus/data
sudo netstat -tuln
exit
sudo nano /etc/ssh/sshd_config
ss -tuln | grep LISTEN
git init
git add .
ls
git commit -m "Initial commit"
  git config --global user.name "Eliya-shlomo"
git commit -m "Initial commit"
git add .
echo ".lava/data/" >> .gitignore
echo ".lava/config/" >> .gitignore
git rm -r --cached .lava/data
git add .gitignore
git commit -m "initial commit"
git add .
ls
nano /path/to/your/service/config
nano /path/to/your/service/config
sudo netstat -tulnp | grep LISTEN
ls
sudo nano /etc/systemd/system/prometheus.service
