# Minesweeper_Qt

[![en](https://img.shields.io/badge/lang-en-blue.svg)](https://github.com/Dariarty/Minesweeper_Qt/blob/main/README.md)
[![ru](https://img.shields.io/badge/lang-ru-red.svg)](https://github.com/Dariarty/Minesweeper_Qt/blob/main/README.ru.md)

<a href="https://dariarty.github.io/Minesweeper_Qt/" title="GitHub Pages link">Play in browser - WebAssembly version hosted on GitHub Pages</a>

Minesweeper game with improved classic GUI.</br>
Cross-platform application made with C++/Qt/QML for Windows, Linux and WebAssembly.</br>

## Features

* Classic minesweeper gameplay with clean GUI</br>
* Customizable difficulty options (field height and width, number of mines)</br>
* Resizable scale of field</br>
* Desktop and WebAssembly versions</br>

## Screenshots

<h3 align="center">Beginner</h3>
<p align="center">
  <img src="assets/en_US/beginner.png" />
</p>

<h3 align="center">Intermediate</h3>
<p align="center">
  <img src="assets/en_US/intermediate.png" />
</p>

<h3 align="center">Expert</h3>
<p align="center">
  <img src="assets/en_US/expert.png" />
</p>

<h3 align="center">Dialog for choosing custom game rules</h3>
<p align="center">
  <img src="assets/en_US/rules.png" />
</p>

<h3 align="center">Settings to change field zoom</h3>
<p align="center">
  <img src="assets/en_US/scale.png" />
</p>

## Building Source Code
App supports Windows, Linux and WebAssembly (using Qt for WebAssembly). </br>
Prerequisites: Qt 6.5+, GCC (or other) C++ compiler, Qt Creator, Qt Linguist </br>
1.  Download and install Qt6 and Qt Creator.</br>
2.  Configure Qt Creator Kit for Desktop or WebAssembly using Emscripten. </br>
3.  Clone the repo.
     ```sh
     git clone https://github.com/Dariarty/Minesweeper_Qt.git
     ```
4.  Open src/minesweeper.pro in Qt Creator.</br>
5.  Run lrelease tool to read the TS files and produce the QM translation files. </br>
    Qt Creator > Tools > External > Linguist > Release Translations (lrelease) </br>
7.  Run qmake.</br>
8.  Build the project in Qt Creator.</br>

## Attributions
<a href="https://www.flaticon.com/free-icons/mine" title="mine icons">Mine icons created by Creaticca Creative Agency - Flaticon</a> </br>

<a href="https://www.flaticon.com/free-icon/close_1828666?term=cross&page=1&position=9&origin=search&related_id=1828666" title="cross icon">Cross icon created by Pixel Perfect - Flaticon</a> </br>

<a href="https://www.flaticon.com/packs/emojis-221" title="emoji icons">Emoji icons for reset button created by NajmunNahar - Flaticon</a> </br>

<a href="https://www.freepik.com/icon/flag_16771882#fromView=keyword&page=1&position=91&uuid=a58f54fa-5ea7-4ac9-9fae-a7f2fb24842f" title="flag icon">Flag icon created by sonnycandra - Freepik</a>

## License

Distributed under the MIT License. See [LICENSE](LICENSE) for more information.

