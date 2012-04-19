// http://localhost/presentations/getting_rest/Taffy/index.cfm/speakers/ben-nadel

component
extends="taffy.core.resource"
taffy_uri="/speakers/{speakerSlug}"
{

	function get(speakerSlug)
	{
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
				'name': local.qResult.speakerName,
				'bio': local.qResult.speakerBio,
				'url': 'http://localhost/presentations/getting_rest/taffy/index.cfm/speakers/' & local.qResult.speakerSlug,
				'sessions': []
			};

			for (local.i = 1; local.i <= local.qResult.recordCount; local.i++){
				arrayAppend(local.result.sessions, {
					'title': local.qResult.sessionTitle[local.i],
					'desc': local.qResult.sessionDesc[local.i],
					'startDate': local.qResult.startDate[local.i],
					'url': 'http://localhost/presentations/getting_rest/taffy/index.cfm/sessions/' & local.qResult.sessionSlug[local.i]
				});
			}

			return representationOf( local.result );
		}else{
			return noData().withStatus(404, "Not Found");
		}
	}

}
