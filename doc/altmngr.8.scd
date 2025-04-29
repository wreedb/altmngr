ALTMNGR(8)

# NAME

*altmngr* maintain a selection of generic commands and libraries

# SYNOPSIS

*altmngr* [_options_] *MODE* _link_ _name_ _path_ _priority_

# DESCRIPTION
*altmngr* provides an interface to manage symbolic links for use++
in determining default/generic commands and libraries. However++
it is not limited to that alone, as it can manage anything that++
can be used as a symbolic link.

It is common to have multiple pieces of software that provide similar++
functionality, *altmngr* allows you to do something like the following:

/usr/bin/editor -> /usr/bin/emacs: priority *50*++
/usr/bin/editor -> /usr/bin/vim: priority *40*++
/usr/bin/editor -> /usr/bin/nano: priority *30*

In this example we have the *editor* command, which points to one++
of emacs, vim, or nano; with the highest priority being the active++
link to /usr/bin/editor when in _auto_ mode (the default). In the++
event you want to override the automatic default, you would be able++
to set the link to _manual_ mode, with *altmngr --config editor*++
and then choosing from the given menu.

It is also common to have (or need) multiple versions of the same++
program or library installed at the same time. This can lead to many++
nightmare-ish issues, *altmngr* can be used to alleviate this problem.

/usr/lib/libfoo.so -> /usr/lib/libfoo.so.1.2++
/usr/lib/libfoo.so -> /usr/lib/libfoo.so.1.1++
/usr/lib/foo -> /usr/lib/foo-1.2++
/usr/lib/foo -> /usr/lib/foo-1.1

As you can see, the worries of having multiple versions of a++
library can be completely dealt with through a few symbolic++
links. Not only that, additional related files can be grouped++
into a family of links, such that changing a link to /usr/bin/foo++
could also change links to /usr/lib/libfoo.so, /usr/lib/foo,++
/usr/share/doc/foo, /usr/share/man/man1/foo.1 and any other++
files you may wish to associate with it.

# COPYRIGHT
	
	Copyright (C) 2025 Will Reed, License GPLv3+ ++
GNU GPL version 3 or later ++
This is free software: you are free to change and ++
redistribute it. Ther is NO WARRANTY, to the extent ++
permitted by law.

# AUTHOR

	Written by Will Reed <_https://github.com/wreedb_>