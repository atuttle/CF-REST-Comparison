{
	"RequestPatterns": {
		"/sessions": {
			"GET": {
				"Bean": "model.sessions"
				,"Method": "getAllSessionsWithSpeakers"
				,"DefaultArguments": {
					"api_base_path": "/presentations/getting_rest/Relaxation/index.cfm"
				}
			},
			"POST": {
				"Bean": "model.sessions"
				,"Method": "create"
			}
		}
		,"/sessions/{sessionSlug}": {
			"GET": {
				"Bean": "model.sessions"
				,"Method": "getSession"
				,"DefaultArguments": {
					"api_base_path": "/presentations/getting_rest/Relaxation/index.cfm"
				}
			}
		}
		,"/speakers": {
			"GET": {
				"Bean": "model.speakers"
				,"Method": "getAllSpeakersWithSessions"
				,"DefaultArguments": {
					"api_base_path": "/presentations/getting_rest/Relaxation/index.cfm"
				}
			}
		}
		,"/speakers/{speakerSlug}": {
			"GET": {
				"Bean": "model.speakers"
				,"Method": "getSpeaker"
				,"DefaultArguments": {
					"api_base_path": "/presentations/getting_rest/Relaxation/index.cfm"
				}
			}
		}
	}
}