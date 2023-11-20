cd ..
git clone https://github.com/brendangregg/FlameGraph.git

VERSION=6.5.6-76060506

sudo apt install linux-tools-common
sudo apt install linux-tools-${VERSION} linux-tools-${VERSION}-generic
