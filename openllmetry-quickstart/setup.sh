git clone https://github.com/traceloop/openllmetry.git
cd openllmetry/packages/sample-app

curl -sSf https://rye.astral.sh/get | RYE_INSTALL_OPTION="--yes" bash
echo 'source "$HOME/.rye/env"' >> ~/.bashrc
source "$HOME/.rye/env"

# `.python-version` in the sample repository is not following `pyproject.toml`
echo "3.11.10" > .python-version

rye sync
python --version

python -m ensurepip --upgrade
python -m pip install --upgrade pip
python -m pip --version

python -m pip install poetry
python -m poetry --version

python -m poetry install
echo done > /tmp/background0
