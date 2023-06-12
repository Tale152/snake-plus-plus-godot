# Snake++  
![GitHub last commit](https://img.shields.io/github/last-commit/Tale152/snake-plus-plus-godot)
![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/Tale152/snake-plus-plus-godot?include_prereleases)  
This repository contains the source code for the mobile game Snake++.

## Table of contents
- [About the game](#about-the-game)
- [Technologies used](#technologies-used)
- [Target platforms](#target-platforms)
- [How to run](#how-to-run)
- [How to build](#how-to-build)
- [Get latest release](#get-latest-release)

## About the game

Snake++ is an exciting and modern take on the classic snake game, offering a fresh twist to the addictive gameplay that captivated players for years.

While Snake++ stays true to its roots, it introduces new and exciting elements to enhance the gaming experience. One notable addition is the inclusion of new perks that go beyond the traditional apple. As players progress through the game, they can encounter a wide array of perks that provide various advantages and disadvantages. These perks might include speed boosts, temporary invincibility, teleportation abilities, and more, allowing players to strategize and adapt their gameplay accordingly.

The game also offers two distinct game modes: Adventure and Arcade. In the Adventure mode, players embark on a thrilling journey through multiple stages, each with its own unique challenges and obstacles. On the other hand, the Arcade mode offers a fast-paced, score-driven experience, where players strive to achieve the highest score possible. Progressing in the Adventure mode unlocks new Arcade stages.

One of the standout features of Snake++ is its extensive skin customization. Players can personalize their snake's appearance by selecting from a wide range of vibrant and eye-catching skins. From classic patterns to futuristic designs, the options are endless.

What truly sets Snake++ apart is its scalability and ease of stage creation. With a simple JSON file format, stage design becomes accessible to players and allows for the easy creation of new stages. The JSON file describes the layout, obstacles, and challenges, providing a platform for both developers and the community to expand the game's content. This scalability ensures that players will always have fresh and exciting stages to explore, extending the replay value of Snake++.

Get ready to embark on a nostalgic journey with Snake++, where the classic snake game meets new perks, engaging game modes, and extensive customization options. Whether you're a seasoned snake enthusiast or a newcomer to the genre, Snake++ promises a captivating and endlessly entertaining experience.

## Technologies used
Snake++ was created using the Godot engine, specifically Godot 3.5.X, and developed using the GDScript language; while the language's limitations sometime makes hard to apply good design principles, its extreme versatility extends to its ability to compile games for all major existing platforms, making it appealing for future distribution.

## Target platforms
The game is thought to be run on mobile platform (Android and iOS), but future customizations can adapt the game to be optimized also for desktop platforms.

## How to run
First download and install the [Godot engine v3.5.X](https://godotengine.org/download/3.x/windows/) for your platform; then, simply import the project and run it from the Godot engine (keep in mind that the game is optimized for mobile environments, so changing window size is not actually responsive and the size of certain things only change after changing scene).

While running it on desktop. you can use the arrow keys or the WASD keys to move the snake.

## How to build
Follow any tutorial for compiling for the desired target platform.  

**IMPORTANT**: You need to include the JSON files in the build process, otherwise no game stages will be included.  
On the export project page, once you have selected your target platform, select the *"Resources"* tab and add this line
```
*.json
```
to the *"Filters to export non-resources in the project"* textbox.

## Get latest mobile release
At the moment, just Android's APKs are available, but in the future iOS support will be added.

Get the latest builds in the *[Releases](https://github.com/Tale152/snake-plus-plus-godot/releases)* section of this repository downloading the desired asset.