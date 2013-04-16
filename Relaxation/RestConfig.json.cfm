{
	"RequestPatterns": {
		"/sessions": {
			"GET": {
				"Bean": "sessions"
				,"Method": "getAllSessionsWithSpeakers"
				,"DefaultArguments": {
					"api_base_path": "/presentations/getting_rest/Relaxation/index.cfm"
				}
			},
			"POST": {
				"Bean": "sessions"
				,"Method": "create"
			}
		}
		,"/sessions/{sessionSlug}": {
			"GET": {
				"Bean": "sessions"
				,"Method": "getSession"
				,"DefaultArguments": {
					"api_base_path": "/presentations/getting_rest/Relaxation/index.cfm"
				}
			}
		}
		,"/speakers": {
			"GET": {
				"Bean": "speakers"
				,"Method": "getAllSpeakersWithSessions"
				,"DefaultArguments": {
					"api_base_path": "/presentations/getting_rest/Relaxation/index.cfm"
				}
			}
		}
		,"/speakers/{speakerSlug}": {
			"GET": {
				"Bean": "speakers"
				,"Method": "getSpeaker"
				,"DefaultArguments": {
					"api_base_path": "/presentations/getting_rest/Relaxation/index.cfm"
				}
			}
		}
	}
}