# Creating REST API's in ColdFusion 10

## Requirements for CF10 REST

* All remote methods must have `returnType="..."` specified (where `...` is the type that will be returned).
* Application-specific mappings are not supported. Use server-mappings or the fully-qualified cfc path instead.
* Getting nothing but 404s when CF is hooked up to Apache? [Read this][1]

## When a REST service starts returning 404 out of the blue...

The first thing I do is look at the log. It's unfortunate, but this seems to be the only window into the black-box that is CF10 REST Services Refreshing.

CF10 logs REST service refresh errors to the exception log. Find it in the CF Administrator, **Debugging & Logging** section, **Log Files** Screen; as **exception.log**. Unless you're a superhero coder, yours probably has thousands and thousands of lines (exceptions from all applications on this CF instance, not just REST), and oh happy day, newest entries go at the end. My advice is not to even bother trying to page/jump to the end, just delete it (the X icon) and refresh your service again so that your REST error is the only thing in the file. Then go back to logging and look at the stack trace.

If the stack trace's first line or two doesn't seem very helpful, make sure you read the whole thing. Often times the useful details are buried down in later lines -- even on the second page, even when there's only 1 error logged.


[1]:http://fusiongrokker.com/post/getting-nothing-but-404-s-for-coldfusion-10-rest-on-apache
