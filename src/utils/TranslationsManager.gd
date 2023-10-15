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
const MAX_LENGTH_REACHED: String = "MAX_LENGTH_REACHED"
const MAX_SCORE_REACHED: String = "MAX_SCORE_REACHED"
const BEST_SCORE_REACHED: String = "BEST_SCORE_REACHED"
const LENGTH: String = "LENGTH"
const SCORE: String = "SCORE"
const TIME: String = "TIME"
const NO_RECORD: String = "NO_RECORD"
const STARS_OBTAINED: String = "STARS_OBTAINED"
const GAME_MODE: String = "GAME_MODE"
const DIFFICULTY: String = "DIFFICULTY"
const LOCKED: String = "LOCKED"
const REQUIREMENTS: String = "REQUIREMENTS"
const NO_REQUIREMENT: String = "NO_REQUIREMENT"
const GAME_OVER_IF: String = "GAME_OVER_IF"
const NO_TRIGGER: String = "NO_TRIGGER"
const NO_RESULTS_YET: String = "NO_RESULTS_YET"
