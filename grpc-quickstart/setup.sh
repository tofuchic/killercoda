sudo rm -rf /usr/local/go
latest_stable_go_version=$(curl -Lso- https://go.dev/dl/ | grep -m1 -P 'id="go\d+\.\d+\.\d+' | cut -f 4 -d '"')
wget https://dl.google.com/go/$latest_stable_go_version.linux-amd64.tar.gz
sudo tar -xvf $latest_stable_go_version.linux-amd64.tar.gz
rm -f $latest_stable_go_version.linux-amd64.tar.gz
sudo mv go /usr/local
echo done > /tmp/background0
