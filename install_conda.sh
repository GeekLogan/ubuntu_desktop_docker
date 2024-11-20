wget https://repo.anaconda.com/archive/Anaconda3-2023.03-1-Linux-x86_64.sh
chmod +x Anaconda*.sh

whoami
echo "Installing from: $(ls -1 / | fgrep Anaconda)"
/bin/bash /$(ls -1 / | fgrep Anaconda) -b -p $HOME/conda
eval "$($HOME/conda/bin/conda shell.bash hook)"
conda init
