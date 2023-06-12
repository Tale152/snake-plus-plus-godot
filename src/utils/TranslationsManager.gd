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

const ADVENTURE: String = "ADVENTURE"
const ARCADE: String = "ARCADE"
const CUSTOMIZATION: String = "CUSTOMIZATION"
const WIKI: String = "WIKI"
const SETTINGS: String = "SETTINGS"
const CONTROLS: String = "CONTROLS"
const MUSIC: String = "MUSIC"
const EFFECTS: String = "EFFECTS"
const LANGUAGE: String = "LANGUAGE"
const TROPHIES: String = "TROPHIES"
const NOOB: String = "NOOB"
const REGULAR: String = "REGULAR"
const PRO: String = "PRO"
const SNAKE: String = "SNAKE"
const FIELD: String = "FIELD"
const PERKS: String = "PERKS"
