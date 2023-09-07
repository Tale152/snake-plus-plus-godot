extends Node

const FALLBACK_LANGUAGE_ID: String = "en"

func get_supported_languages() -> Dictionary:
	return {
		"English" : "en",
		"Italiano" : "it"
	}

func get_os_language() -> String:
	return OS.get_locale_language()

func get_localized_string(key: String) -> String:
	return tr(key)

const PLAY: String = "PLAY"
const CHALLENGE: String = "CHALLENGE"
const ARCADE: String = "ARCADE"
const CUSTOMIZATION: String = "CUSTOMIZATION"
const WIKI: String = "WIKI"
const SETTINGS: String = "SETTINGS"
const CONTROLS: String = "CONTROLS"
const MUSIC: String = "MUSIC"
const EFFECTS: String = "EFFECTS"
const LANGUAGE: String = "LANGUAGE"
const TROPHIES: String = "TROPHIES"
const REGULAR: String = "REGULAR"
const PRO: String = "PRO"
const SNAKE: String = "SNAKE"
const FIELD: String = "FIELD"
const PERKS: String = "PERKS"
const LONGEST_SNAKE_GAME: String = "LONGEST_SNAKE_GAME"
const HIGHEST_SCORE_GAME: String = "HIGHEST_SCORE_GAME"
const LENGTH: String = "LENGTH"
const SCORE: String = "SCORE"
const TIME: String = "TIME"
const NO_RECORD: String = "NO_RECORD"
const STARS_OBTAINED: String = "STARS_OBTAINED"
const GAME_MODE: String = "GAME_MODE"
const DIFFICULTY: String = "DIFFICULTY"
const LOCKED: String = "LOCKED"
