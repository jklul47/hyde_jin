#!/usr/bin/env bash

# Install additional themes
hydectl theme import --name "Abyssal-Wave" --url "https://github.com/Itz-Abhishek-Tiwari/Abyssal-Wave/tree/main"
hydectl theme import --name "Ever-Blushing" --url "https://github.com/rishav12s/Ever-Blushing/tree/main"
hydectl theme import --name "One-Dark" --url "https://github.com/RAprogramm/HyDe-Themes/tree/One-Dark"
hydectl theme import --name "Pixel-Dream" --url "https://github.com/rishav12s/Pixel-Dream/tree/main"
hydectl theme import --name "Monokai" --url "https://github.com/mahaveergurjar/Theme-Gallery/tree/Monokai"
hydectl theme import --name "Eternal-Artic" --url "https://github.com/rishav12s/Eternal-Arctic/tree/main"
hydectl theme import --name "BlueSky" --url "https://github.com/richen604/BlueSky/tree/main"
hydectl theme import --name "Code-Garden" --url "https://github.com/jacobfranco/Code-Garden/tree/main"
hydectl theme import --name "Crimson-Blue" --url "https://github.com/amit-0i/Crimson-Blue/tree/main"
hydectl theme import --name "Nightbrew" --url "https://github.com/jackpawlik1/Nightbrew/tree/main"
hydectl theme import --name "Piece-Of-Mind" --url "https://github.com/Maroc02/Piece-Of-Mind/tree/main"
hydectl theme import --name "Vanta-Black" --url "https://github.com/rishav12s/Vanta-Black/tree/main"

# Install LazyVim Starter
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

