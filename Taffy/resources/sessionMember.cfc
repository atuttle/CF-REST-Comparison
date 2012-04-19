// http://localhost/presentations/getting_rest/Taffy/index.cfm/sessions/StampingScrapping-Designs-Stamps-Dies

component
extends="taffy.core.resource"
taffy_uri="/sessions/{sessionSlug}"
{

	function get(sessionSlug)
	{
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
				'url': 'http://localhost/presentations/getting_rest/taffy/index.cfm/sessions/' & local.qResult.sessionSlug,
				'speakers':[]
			};

			for (local.i = 1; local.i <= local.qResult.recordCount; local.i++){
				arrayAppend(local.result.speakers, {
					'name': local.qResult.speakerName[local.i],
					'bio': local.qResult.speakerBio[local.i],
					'url': 'http://localhost/presentations/getting_rest/taffy/index.cfm/speakers/' & local.qResult.speakerSlug[local.i]
				});
			}

			return representationOf( local.result );
		}else{
			return noData().withStatus(404, "Not Found");
		}
	}

}
