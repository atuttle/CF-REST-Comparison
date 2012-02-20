component
rest="true"
restpath="hello"
{

	remote struct function hello()
	httpmethod="GET"
	produces="application/json,application/xml"
	{
		return { 'message' = 'hello world' };
	}

	remote struct function echo(string input restargsource="path")
	httpmethod="get"
	restPath="echo/{input}"
	produces="application/json,application/xml"
	{
		return { 'echo' = input };
	}

}
