FROM mcr.microsoft.com/powershell:lts-7.2.2-nanoserver-ltsc2022

ENV chocolateyUseWindowsCompression false
ENV LLVM_INSTALL_DIR='C:\libclang'

SHELL ["powershell"]

RUN Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

RUN choco feature enable -n allowGlobalConfirmation; choco feature disable -n showDownloadProgress

RUN choco install 7zip
RUN choco install python3 --version 3.10.4

# Download pre-built clang from qt.io
RUN iwr -useb https://download.qt.io/development_releases/prebuilt/libclang/libclang-release_14.0.0-based-windows-vs2019_64.7z -outfile 'C:\libclang.7z'

# Extract clang
RUN 7z x 'C:\libclang.7z'

# Install poetry
RUN (Invoke-WebRequest -Uri https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py -UseBasicParsing).Content | python -

WORKDIR /code

COPY . .

# Install poetry dependencies
RUN poetry install