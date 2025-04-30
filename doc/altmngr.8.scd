ALTMNGR(8)

# NAME

*altmngr* maintain a selection of generic commands and libraries

# SYNOPSIS

*altmngr* [_options_] *--ACTION* [_args_]...++
where *--ACTION* is one of the following:++
*--install* _link_ _name_ _path_ _priority_++
*--remove* _name_ _path_++
*--set* _name_ _path_++
*--auto* _name_++
*--display* _name_++
*--config* _name_++
*--list*++
*--remove-all* _name_++
*--add-follower* _name_ _path_ _follower-link_ _follower-name_ _follower-path_++
*--remove-follower* _name_ _path_ _follower-name_

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

# TERMINOLOGY

*generic name*++
	A simple name, such as _pager_, used to describe one++
	or more files that may provide paging functionality;++
	such as _more_, _less_ and _most_.

*generic link*++
	The full path to a _generic name_, such as _/usr/bin/pager_.

*symlink*++
	A symbolic link within the _alternatives directory_++
	which is being managed by *altmngr*

*alternative*++
	A file or directory which may be made accessible by a++
	_generic name_ via *altmngr*

*alternatives directory*++
	Directory (by default) located at _/etc/altmngr_;++
	which contains managed symlinks.

*state directory*++
	Directory (by default) located at _/var/lib/altmngr_,++
	conaining state information about _alternatives_.

*tree*++
	A set of related links, intended to be updated collectively

*trunk*++
	The top-most link in a _tree_, which determines how its'++
	_branch_ links are managed.

*branch*++
	Links in a _tree_ which are bound to the a given _trunk_ link,++
	and are configured based on the state of the _trunk_.

*auto mode*++
	When a link is in auto mode, *altmngr* will set the++
	_generic_name_'s link to whichever _alternative_ has++
	the highest *priority* number.

*manual mode*++
	A link is in manual mode when it is directly++
	configured (via --config) by the user. In this case,++
	*altmngr* will not change the link automatically.

# GENERAL OPTIONS

*--verbose*++
	Increase general verbosity of text output and information++
	shown about what *altmngr* is doing.

*--version*++
	Display version information.

*--help*++
	Display usage and version information.

*--altdir* _/directory/path_++
	Specify the alternatives directory, when different from the++
	default location

*--statedir* _/directory/path_++
	Specify the directory containing state information, when++
	different from the default location

# ACTIONS

*--install* _link_ _name_ _path_ _priority_ [*--branch* ...]++
	Add a single [or a group, with *--follower*] alternative to *altmngr*.++
	This is used to define the _trunk_ of an alternative tree, though an++
	alternative does not need to have any branches.++
	_link_: denotes the absolute path to the generic name++
	_name_: denotes the generic name itself++
	_path_: absolute path to the program to associate with _name_.++
	This can also be followed by (one or more) *--branch* arguments

*--remove* _name_ _path_++
	Remove an alternative at _path_, along with its associated branches.++
	_name_ is the generic name of the alternative and _path_ is the ++
	absolute path to the alternative you wish to remove.

*--set* _name_ _path_++
	Set the symbolic link and branches for alternative group _name_++
	to use the alternative at _path_. In this case, the specified++
	alternative is set to _manual-mode_.

*--config* _name_++
	You will be presented with a configuration menu for choosing an ++
	alternative for the given generic name, and set it to _manual-mode_.

*--auto* _name_++
	Switch the alternative named _name_ to _auto-mode_ - setting++
	the current link to whichever selection has the highest++
	priority number.

*--display* _name_++
	Show information about alternative _name_, and any *trees* that are++
	associated with it, along with the hierarchy of each++
	alternative and tree.

*--list*++
	Show a brief list of information about all registered alternatives,++
	and which alternative or tree is currently fulfilling them.

*--remove-all* _name_++
	Remove the alternative named _name_ and all links and trees that may++
	be associated with it. Use with caution.

*--add-branch* _name_ _path_ _branch-link_ _branch-name_ _branch-path_++
	Add a _branch_ to the alternative tree named _name_ - which is denoted++
	by it's *trunk* at _path_. This should be followed by the path to the++
	link that this branch should be fulfilling, its' generic name++
	and the absolute path to the _real_ file the link points to.

*--remove-branch* _name_ _path_ _branch-name_++
	Remove branch from alternative _name_ which is identified by _path_ ++
	and _branch-name_.

# EXAMPLES
*NOTE* the use of "\\" character shell syntax for long++
command strings, which is useful (and recommended).

*Alternatives for multiple of the same programming language*

Adding a tree for version 1.4:

```
altmngr --install         \\ # ACTION
	/usr/bin/foolang     \\ # LINK
	foolang              \\ # NAME
	/usr/bin/foolang-1.4 \\ # DESTINATION
	50                     # PRIORITY

altmngr --add-branch      \\ # ACTION
	foolang              \\ # NAME
	/usr/bin/foolang-1.4 \\ # TRUNK DESTINATION
	/usr/lib/foo         \\ # BRANCH LINK
	foo-lib              \\ # BRANCH NAME
	/usr/lib/foo-1.4       # BRANCH DESTINATION
```

Adding a tree for version 1.3:

```
altmngr --install         \\ # ACTION
	/usr/bin/foolang     \\ # LINK
	foolang              \\ # NAME
	/usr/bin/foolang-1.3 \\ # DESTINATION
	25                     # PRIORITY

altmngr --add-branch      \\ # ACTION
	foolang              \\ # NAME
	/usr/bin/foolang-1.3 \\ # TRUNK DESTINATION
	/usr/lib/foo         \\ # BRANCH LINK
	foo-lib              \\ # BRANCH NAME
	/usr/lib/foo-1.3       # BRANCH DESTINATION
```

In this example to switch between using imaginary language _foo_++
and its standard library (of version 1.3) to version 1.4, the only ++
action needed is to configure the link to /usr/bin/foo, and the++
_foo-lib_ branch will follow accordingly.

Alternatives for a generic *terminal*++
altmngr --install /usr/bin/terminal terminal /usr/bin/kitty 100++
altmngr --install /usr/bin/terminal terminal /usr/bin/ghostty 75++
altmngr --install /usr/bin/terminal terminal /usr/bin/wezterm 50++
altmngr --install /usr/bin/terminal terminal /usr/bin/foot 25

In this example, the command *terminal* can now be used to launch++
whichever of the 4 alternatives has the greatest priority, or++
manually set with *--config*.

# FILES
_/etc/altmngr_
	The default location of the *alternatives directory*. To overried, use
	the *--altdir* flag.
_/var/lib/altmngr_
	The default location of the *state directory*. To overried, use the
	*--statedir* flag.

# EXIT STATUS
*0*
	The action was performed successfully.
*2*
	An issue was encountered while parsing command line arguments
	or while performing the requested action.



# SEE ALSO
_ln_(1), _link_(1), _unlink_(1), _readlink_(1), _symlink_(7)

# COPYRIGHT
Copyright (C) 2025 Will Reed, Licensed under the GNU GPL version ++
3 or later. This is free software: you are free to change and ++
redistribute it. There is NO WARRANTY, to the extent ++
permitted by law.

# VERSION
*altmngr* version _0.1.0_

# AUTHOR
Maintained by Will Reed <_https://github.com/wreedb_>. Source++
code can be found at _https://github.com/wreedb/altmngr_.