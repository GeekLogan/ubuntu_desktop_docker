whoami
echo "Installing from: $(ls -1 / | fgrep Anaconda)"
/bin/bash /$(ls -1 / | fgrep Anaconda) -b -p $HOME/conda
eval "$($HOME/conda/bin/conda shell.bash hook)"
conda init
