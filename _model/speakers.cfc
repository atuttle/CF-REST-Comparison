component {

	function getAllSpeakersWithSessions(api_base_path = ""){
		local.q = new Query();

		local.q.setSql("
			select
				speakerId, speakerName, speakerBio, speakerSlug
			from
				speaker
			order by
				speakerName
		");
		local.qSpeakers = q.execute().getResult();
		local.speakers = [];
		for (local.i = 1; local.i <= local.qSpeakers.recordCount; local.i++){
			local.s = {
				"name" = local.qSpeakers.speakerName[local.i],
				"bio" = local.qSpeakers.speakerBio[local.i],
				"slug" = local.qSpeakers.speakerSlug[local.i],
				"sessions" = []
			};

			//SUBQUERY: get speakers for each session
			local.qSes = new Query();
			local.qSes.setSql("
				select
					sessionTitle, sessionDesc, startDate, sessionSlug
				from
					session s
					inner join session_speaker j on j.sessionId = s.sessionId
				where
					j.speakerId = :speakerId 
				order by
					startDate
			");
			local.qSes.addParam(name="speakerId",cfsqltype="cf_sql_numeric",value=local.qSpeakers.speakerId[local.i]);

			local.sesResult = local.qSes.execute().getResult();

			for (local.j = 1; local.j <= local.sesResult.recordCount; local.j++){
				arrayAppend(local.s.sessions, {
					"title" = local.sesResult.sessionTitle[local.j],
					"desc" = local.sesResult.sessionDesc[local.j],
					"startDate" = local.sesResult.startDate[local.j],
					"slug" = local.sesResult.sessionSlug[local.j]
				});
			}

			arrayAppend( local.speakers, duplicate( local.s ) );
		}

		/*
			NORMALLY YOUR MODEL WOULDN'T HAVE THIS NEXT SECTION, BUT I'VE ADDED IT
			TO MAKE NAVIGATING THE API EASIER IN THE BROWSER
		*/
		if (arguments.api_base_path neq "") {
			//inject api-framework-specific url elements
			for ( var speaker in local.speakers ) {

				//add url for current session
				speaker["url"] = api_base_path & "/speakers/" & speaker.slug;

				//also link each speaker for each session
				for ( var session in speaker.sessions ) {

					session["url"] = api_base_path & "/sessions/" & session.slug;

				}

			}
		}

		return local.speakers;
	}

	function getSpeaker(speakerSlug, api_base_path = "", boolean includeSessions = true){
		local.q = new Query();
		q.setSql("
			select
				spk.speakerId, speakerName, speakerBio, speakerSlug,
				ses.sessionId, sessionTitle, sessionDesc, startDate, sessionSlug
			from
				speaker spk
				inner join session_speaker ss on spk.speakerId = ss.speakerId
				inner join session ses on ses.sessionId = ss.sessionId
			where
				spk.speakerSlug = :speakerSlug 
			order by
				startDate
		");
		q.addParam(name="speakerSlug", cfsqltype="cf_sql_varchar", value=arguments.speakerSlug);

		local.qResult = q.execute().getResult();

		if (local.qResult.recordCount gt 0){

			//massage the result into an intelligent format
			local.result = {
				'name' = local.qResult.speakerName,
				'bio' = local.qResult.speakerBio,
				'slug' = local.qResult.speakerSlug
			};

			if (arguments.includeSessions){
				local.result['sessions'] = [];
				for (local.i = 1; local.i <= local.qResult.recordCount; local.i++){
					arrayAppend(local.result.sessions, {
						'title' = local.qResult.sessionTitle[local.i],
						'desc' = local.qResult.sessionDesc[local.i],
						'startDate' = local.qResult.startDate[local.i],
						'slug' = local.qResult.sessionSlug[local.i]
					});
				}
			}

			/*
				NORMALLY YOUR MODEL WOULDN'T HAVE THIS NEXT SECTION, BUT I'VE ADDED IT
				TO MAKE NAVIGATING THE API EASIER IN THE BROWSER
			*/
			if (arguments.api_base_path neq "") {
				//inject api-framework-specific url elements
				//add url for current session
				local.result["url"] = api_base_path & "/speakers/" & local.result.slug;

				//also link each speaker for each session
				for ( var session in local.result.sessions ) {

					session["url"] = api_base_path & "/sessions/" & session.slug;

				}
			}

			return local.result;
		} else {
			return false;
		}
	}

}
