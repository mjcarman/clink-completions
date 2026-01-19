local arghelper = require("arghelper")

local file       = clink.argmatcher():addarg(clink.filematches)
local when       = clink.argmatcher():addarg("always", "auto", "never")
local theme      = clink.argmatcher():addarg("fancy", "unicode")
local permission = clink.argmatcher():addarg("rwx", "octal", "attributes", "disable")
local size       = clink.argmatcher():addarg("default", "short", "bytes")
local date       = clink.argmatcher():addarg("date", "locale", "relative", "date-time-format")
local sort       = clink.argmatcher():addarg("size", "time", "version", "extension", "git", "none")
local group      = clink.argmatcher():addarg("none", "first", "last")
local block      = clink.argmatcher():addarg("permission", "user", "group", "context", "size", "date", "name", "inode", "links", "git")
local num        = clink.argmatcher():addarg({})
local str        = clink.argmatcher():addarg({})
local glob       = clink.argmatcher():addarg({})

clink.argmatcher("lsd")
  :_addexflags({
    { hide=true, "-a" },       { "--all",                                  "Do not ignore entries starting with ." },
    { hide=true, "-A" },       { "--almost-all",                           "Do not list implied . and .." },
                               { "--color"..when,            " <MODE>",    "When to use terminal colours [default: auto] [possible values: always, auto, never]"  },
                               { "--icon"..when,             " <MODE>",    "When to print the icons [default: auto] [possible values: always, auto, never]" },
                               { "--icon-theme"..theme,      " <THEME>",   "Whether to use fancy or unicode icons [default: fancy] [possible values: fancy, unicode]" },
    { hide=true, "-F" },       { "--classify",                             "Append indicator (one of */=>@|) at the end of the file names" },
    { hide=true, "-l" },       { "--long",                                 "Display extended file metadata as a table" },
                               { "--config-file"..file,      " <PATH>",    "Provide a custom lsd configuration file" },
    { hide=true, "-1" },       { "--oneline",                              "Display one entry per line" },
    { hide=true, "-R" },       { "--recursive",                            "Recurse into directories" },
    { hide=true, "-h" },       { "--human-readable",                       "For ls compatibility purposes ONLY, currently set by default" },
                               { "--tree",                                 "Recurse into directories and present the result as a tree" },
                               { "--depth"..num,             " <NUM>",     "Stop recursing into directories after reaching specified depth" },
    { hide=true, "-d" },       { "--directory-only",                       "Display directories themselves, and not their contents (recursively when used with --tree)" },
                               { "--permission"..permission, " <MODE>",    "How to display permissions [default: rwx for linux, attributes for windows] [possible values: rwx, octal, attributes, disable]" },
                               { "--size"..size,             " <MODE>",    "How to display size [default: default] [possible values: default, short, bytes]" },
                               { "--total-size",                           "Display the total size of directories" },
                               { "--date"..date,             " <DATE>",    "How to display date [default: date] [possible values: date, locale, relative, +date-time-format]" },
    { hide=true, "-t" },       { "--timesort",                             "Sort by time modified" },
    { hide=true, "-S" },       { "--sizesort",                             "Sort by size" },
    { hide=true, "-X" },       { "--extensionsort",                        "Sort by file extension" },
    { hide=true, "-G" },       { "--gitsort",                              "Sort by git status" },
    { hide=true, "-v" },       { "--versionsort",                          "Natural sort of (version) numbers within text" },
                               { "--sort"..sort,             " <TYPE>",    "Sort by TYPE instead of name [possible values: size, time, version, extension, git, none]" },
    { hide=true, "-U" },       { "--no-sort",                              "Do not sort. List entries in directory order" },
    { hide=true, "-r" },       { "--reverse",                              "Reverse the order of the sort" },
                               { "--group-dirs"..group,      " <MODE>",    "Sort the directories then the files [possible values: none, first, last]" },
                               { "--group-directories-first",              "Groups the directories at the top before the files. Same as --group-dirs=first" },
                               { "--blocks"..block,          " <BLOCKS>",  "Specify the blocks that will be displayed and in what order [possible values: permission, user, group, context, size, date, name, inode, links, git]" },
                               { "--classic",                              "Enable classic mode (display output similar to ls)" },
                               { "--no-symlink",                           "Do not display symlink target" },
    { hide=true, "-I"..glob }, { "--ignore-glob"..glob,      " <PATTERN>", "Do not display files/directories with names matching the glob pattern(s). More than one can be specified by repeating the argument" },
    { hide=true, "-i" },       { "--inode",                                "Display the index number of each file" },
    { hide=true, "-g" },       { "--git",                                  "Show git status on file and directory. Only when used with --long option" },
    { hide=true, "-L" },       { "--dereference",                          "When showing file information for a symbolic link, show information for the file the link references rather than for the link itself" },
    { hide=true, "-Z" },       { "--context",                              "Print security context (label) of each file" },
                               { "--hyperlink"..when,        " <MODE>",    "Attach hyperlink to filenames [default: never] [possible values: always, auto, never]" },
                               { "--header",                               "Display block headers" },
                               { "--truncate-owner-after"..num,  " <NUM>", "Truncate the user and group names if they exceed a certain number of characters" },
                               { "--truncate-owner-marker"..str, " <STR>", "Truncation marker appended to a truncated user or group name" },
                               { "--system-protected",                     "Includes files with the windows system protection flag set. This is the same as --all on other platforms" },
    { hide=true, "-N" },       { "--literal",                              "Print entry names without quoting" },
                               { "--help",                                 "Print help information" },
    { hide=true, "-V" },       { "--version",                              "Print version" },
  })
