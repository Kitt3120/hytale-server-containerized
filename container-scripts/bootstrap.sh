#!/usr/bin/env sh

apt-get update

echo "> Installing wget"
apt-get install -y wget

echo "> Installing unzip"
apt-get install -y unzip

echo "> Installing Java"
apt-get install -y openjdk-25-jre-headless

echo "> Java version:"
java -version

echo "> Downloading Hytale Downloader CLI"
wget -O hytale-downloader.zip https://downloader.hytale.com/hytale-downloader.zip

echo "> Extracting Hytale Downloader CLI"
unzip -o hytale-downloader.zip -d ./hytale-downloader
rm ./hytale-downloader/hytale-downloader-windows-amd64.exe ./hytale-downloader/QUICKSTART.md
chmod +x ./hytale-downloader/hytale-downloader-linux-amd64

echo "> Hytale Downloader CLI version:"
./hytale-downloader/hytale-downloader-linux-amd64 --version

echo "> Checking for Hytale Downloader CLI updates"
./hytale-downloader/hytale-downloader-linux-amd64 -check-update

# only do this if hytale.zip does not already exist

if [ ! -f hytale.zip ]; then
    echo "> Downloading Hytale"
    ./hytale-downloader/hytale-downloader-linux-amd64 -download-path hytale.zip

    echo "> Extracting Hytale"
    unzip -o hytale.zip -d ./hytale
fi

echo "> Starting HytaleServer.jar"
java -jar hytale/Server/HytaleServer.jar --assets ./hytale/Assets.zip
