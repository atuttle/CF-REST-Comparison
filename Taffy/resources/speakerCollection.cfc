// http://localhost/presentations/getting_rest/Taffy/index.cfm/speakers

component
extends="taffy.core.resource"
taffy_uri="/speakers"
{

	function get()
	{
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
				"name": local.qSpeakers.speakerName[local.i],
				"bio": local.qSpeakers.speakerBio[local.i],
				"url": "http://localhost/presentations/getting_rest/taffy/index.cfm/speakers/" & local.qSpeakers.speakerSlug[local.i],
				"sessions": []
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
					"title": local.sesResult.sessionTitle[local.j],
					"desc": local.sesResult.sessionDesc[local.j],
					"startDate": local.sesResult.startDate[local.j],
					"url": "http://localhost/presentations/getting_rest/taffy/index.cfm/sessions/" & local.sesResult.sessionSlug[local.j]
				});
			}

			arrayAppend( local.speakers, duplicate( local.s ) );
		}
		return representationOf( local.speakers );
	}

}
