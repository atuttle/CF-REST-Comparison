// http://localhost/presentations/getting_rest/Taffy/index.cfm/sessions

component
extends="taffy.core.resource"
taffy_uri="/sessions"
{

	function get()
	{
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
				"url": "http://localhost/presentations/getting_rest/taffy/index.cfm/sessions/" & local.qSessions.sessionSlug[local.i],
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
					"url": "http://localhost/presentations/getting_rest/taffy/index.cfm/speakers/" & local.spkResult.speakerSlug[local.j]
				});
			}

			arrayAppend( local.sessions, duplicate( local.s ) );
		}
		return representationOf( local.sessions );
	}

	//speakers must exist before their sessions can be inserted
	function post(title,desc,startDate,slug,speakerSlugs)
	{
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
		local.q.addParams(name="title",cfsqltype="cf_sql_varchar",value="#arguments.title#");
		local.q.addParams(name="desc",cfsqltype="cf_sql_varchar",value="#arguments.desc#");
		local.q.addParams(name="startDate",cfsqltype="cf_sql_varchar",value="#arguments.startDate#");
		local.q.addParams(name="sessionSlug",cfsqltype="cf_sql_varchar",value="#arguments.sessionSlug#");

		local.result = local.q.execute().getResult();
		local.insertedId = local.result.generated_key;

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
			local.qSpk.addParams(name="sessionId",cfsqltype="cf_sql_numeric",value="#local.insertedId#");
			local.qSpk.addParams(name="speakerSlug",cfsqltype="cf_sql_varchar",value="#arguments.speakerSlugs[local.i]#");
			local.qSpkResult = local.qSpk.execute().getResult();

		}

		return representationOf( {"uri": "/sessions/" & arguments.sessionSlug } ).withStatus(201, "Session Created");
	}

}
