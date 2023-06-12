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
const SETTINGS: String = "SETTINGS"
const CONTROLS: String = "CONTROLS"
const MUSIC: String = "MUSIC"
const EFFECTS: String = "EFFECTS"
const LANGUAGE: String = "LANGUAGE"
