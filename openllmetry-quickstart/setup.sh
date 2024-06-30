git clone https://github.com/traceloop/openllmetry.git
cd openllmetry/packages/sample-app

curl -sSf https://rye.astral.sh/get | RYE_INSTALL_OPTION="--yes" bash
source "$HOME/.rye/env"
rye sync
python --version | echo > /tmp/background0

python -m ensurepip --upgrade
python -m pip install --upgrade pip
pyhton -m pip --version | echo > /tmp/background0

python -m pip install poetry
pyhton -m poetry --version | echo > /tmp/background0

python -m poetry install
echo done > /tmp/background0
