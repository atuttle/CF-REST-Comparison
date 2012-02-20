component
rest="true"
restPath="repeater"
{

	remote array function letters(
		string letter restargsource="path"
	)
	httpmethod="GET"
	produces="application/json,application/xml"
	restpath="{letter : [a-zA-Z]}"
	{
		return [repeatString(letter,10)];
	}

	remote array function chars(
		string bob restargsource="path"
	)
	httpmethod="GET"
	produces="application/json,application/xml"
	restpath="{char}"
	{
		return [repeatString(bob, 100)];
	}

	remote array function names(
		string first restArgSource="path",
		string last restArgSource="path"
	)
	httpmethod="GET"
	produces="application/json,application/xml"
	restpath="{first}-{last}"
	{
		return [first, first, first, last, last, last ];
	}

}
