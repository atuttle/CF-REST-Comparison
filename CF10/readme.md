# Creating REST API's in ColdFusion 10

## Requirements / Quirks

* All remote methods must have `returnType="..."` specified (where `...` is the type that will be returned).
* Don't forget `restArgSource` for `<cfargument/>` tags for URI-token arguments. The default value for `restArgSource` is `body`, which will not work if you're trying to get a value from the URI.
* Application-specific mappings are not supported. Use server-mappings or the fully-qualified cfc path instead.
* Whenever refreshing services, I _always_ follow this workflow:
   1. Delete "exception.log" from the log files screen
   1. Refresh REST services
   1. Check to see if "exception.log" is back. (If so, read it and address the problem.)

## Common Errors:

* **500 Object is not an instance of declaring class**: One of your REST CFC's changed and you need to refresh the service.
* **415 Unsupported Media Type**: you probably need a (different) `restArgSource` attribute on your CFArgument tags.
* Nothing but **404** with Apache? [Read this][1].

## On Leading Slashes...

The leading slash for both the `restPath` attribute of the `<cfcomponent/>` tag _and_ the `restPath` attribute of the `<cffunction/>` tag are **OPTIONAL**. That means that both of these component tags behave identically:

	<cfcomponent restPath="/sessions">
	<cfcomponent restPath="sessions">

And just the same way, both of these function tags behave identically:

	<cffunction name="getFoo" restPath="/{sessionSlug}" ...>
	<cffunction name="getFoo" restPath="{sessionSlug}" ...>

## Debugging

The first thing I do is look at the log. It's unfortunate, but this seems to be the only window into the black-box that is CF10 REST Services Refreshing.

CF10 logs REST service refresh errors to the exception log. Find it in the CF Administrator, **Debugging & Logging** section, **Log Files** Screen; as **exception.log**. Unless you're a superhero coder, yours probably has thousands and thousands of lines (exceptions from all applications on this CF instance, not just REST), and oh happy day, newest entries go at the end. My advice is not to even bother trying to page/jump to the end, just delete it (the X icon) and refresh your service again so that your REST error is the only thing in the file. Then go back to logging and look at the stack trace.

If the stack trace's first line or two doesn't seem very helpful, make sure you read the whole thing. Often times the useful details are buried down in later lines -- even on the second page, even when there's only 1 error logged.

### Getting more debug information

Since we're interacting with an API and not a webpage, CFDump loses its utility. We can't use it here. _Or can we?!_

If it's available to you, the CFBuilder Step Debugger is a great place to start. But if it's not for some reason, then you can use CFMail to send yourself dumps of variables/errors/etc. Or send that output to a file. Get creative!


[1]:http://fusiongrokker.com/post/getting-nothing-but-404-s-for-coldfusion-10-rest-on-apache
