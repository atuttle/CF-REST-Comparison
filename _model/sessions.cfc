component{

	function getAllSessionsWithSpeakers(api_base_path = ""){
		local.q = new Query();

		local.q.setSql("
			select
				sessionId, sessionTitle, sessionDesc, startDate, sessionSlug
			from
				session
			order by
				startDate, sessionTitle
		");
		local.qSessions = q.execute().getResult();
		local.sessions = [];
		for (local.i = 1; local.i <= local.qSessions.recordCount; local.i++){
			local.s = {
				"title": local.qSessions.sessionTitle[local.i],
				"desc": local.qSessions.sessionDesc[local.i],
				"startDate": local.qSessions.startDate[local.i],
				"slug": local.qSessions.sessionSlug[local.i],
				"speakers": []
			};

			//SUBQUERY: get speakers for each session
			local.qSpk = new Query();
			local.qSpk.setSql("
				select
					speakerName, speakerBio, speakerSlug
				from
					speaker s
					inner join session_speaker j on j.speakerId = s.speakerId
				where
					j.sessionId = :sessionId
				order by
					speakerName
			");
			local.qSpk.addParam(name="sessionId",cfsqltype="cf_sql_numeric",value=local.qSessions.sessionId[local.i]);

			local.spkResult = local.qSpk.execute().getResult();

			for (local.j = 1; local.j <= local.spkResult.recordCount; local.j++){
				arrayAppend(local.s.speakers, {
					"name": local.spkResult.speakerName[local.j],
					"bio": local.spkResult.speakerBio[local.j],
					"slug": local.spkResult.speakerSlug[local.j]
				});
			}

			arrayAppend( local.sessions, duplicate( local.s ) );
		}

		/*
			NORMALLY YOUR MODEL WOULDN'T HAVE THIS NEXT SECTION, BUT I'VE ADDED IT
			TO MAKE NAVIGATING THE API EASIER IN THE BROWSER
		*/
		if (arguments.api_base_path neq "") {
			//inject api-framework-specific url elements
			arrayEach(local.sessions, function(session){

				//add url for current session
				session["url"] = api_base_path & "/sessions/" & session.slug;

				//also link each speaker for each session
				arrayEach(session.speakers, function(speaker){

					speaker["url"] = api_base_path & "/speakers/" & speaker.slug;

				});

			});
		}

		return local.sessions;
	}

	function getSession(sessionSlug, api_base_path = "", boolean speakers = true){
		local.q = new Query();
		q.setSql("
			select
				ses.sessionId, sessionTitle, sessionDesc, startDate, sessionSlug,
				spk.speakerId, speakerName, speakerBio, speakerSlug
			from
				session ses
				inner join session_speaker ss on ses.sessionId = ss.sessionId
				inner join speaker spk on spk.speakerId = ss.speakerId
			where
				ses.sessionSlug = :sessionSlug
			order by
				startDate, sessionTitle
		");
		q.addParam(name="sessionSlug", cfsqltype="cf_sql_varchar", value=arguments.sessionSlug);

		local.qResult = q.execute().getResult();

		if (local.qResult.recordCount gt 0){

			//massage return data into a nice format
			local.result = {
				'title': local.qResult.sessionTitle,
				'desc': local.qResult.sessionDesc,
				'startDate': local.qResult.startDate,
				'slug': local.qResult.sessionSlug
			};

			if (arguments.speakers){
				local.result['speakers'] = [];
				for (local.i = 1; local.i <= local.qResult.recordCount; local.i++){
					arrayAppend(local.result.speakers, {
						'name': local.qResult.speakerName[local.i],
						'bio': local.qResult.speakerBio[local.i],
						'slug': local.qResult.speakerSlug[local.i]
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
				local.result["url"] = api_base_path & "/sessions/" & local.result.slug;

				//also link each speaker for each session
				arrayEach(local.result.speakers, function(speaker){

					speaker["url"] = api_base_path & "/speakers/" & speaker.slug;

				});
			}

			return local.result;

		} else {
			return false;
		}
	}

	function create(title,desc,startDate,slug,speakerSlugs){
		local.q = new Query();
		local.qSpk = new Query();
		local.q.setSql("
			insert into session (
				sessionTitle,
				sessionDesc,
				startDate,
				sessionSlug
			)
			values (
				:title,
				:desc,
				:startDate,
				:sessionSlug
			)
		");
		local.q.addParam(name="title",cfsqltype="cf_sql_varchar",value="#arguments.title#");
		local.q.addParam(name="desc",cfsqltype="cf_sql_varchar",value="#arguments.desc#");
		local.q.addParam(name="startDate",cfsqltype="cf_sql_varchar",value="#arguments.startDate#");
		local.q.addParam(name="sessionSlug",cfsqltype="cf_sql_varchar",value="#arguments.slug#");

		local.insertedId = local.q.execute().getPrefix().generatedkey;

		//associate new session with specified speakers
		for (local.i = 1; local.i <= arrayLen(arguments.speakerSlugs); local.i++){
			local.qSpk.setSql("
				insert into session_speaker (
					sessionId,
					speakerId
				)
				values (
					:sessionId,
					( select speakerId from speaker where speakerSlug = :speakerSlug )
				)
			");
			local.qSpk.addParam(name="sessionId",cfsqltype="cf_sql_numeric",value="#local.insertedId#");
			local.qSpk.addParam(name="speakerSlug",cfsqltype="cf_sql_varchar",value="#arguments.speakerSlugs[local.i]#");
			local.qSpkResult = local.qSpk.execute().getResult();

		}

		return true;
	}

}
