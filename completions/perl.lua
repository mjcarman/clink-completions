-- argument completion for perl
clink.argmatcher("perl")
require("arghelper")

local file_matches       = clink.argmatcher():addarg(clink.filematches)
local dir_matches        = clink.argmatcher():addarg(clink.dirmatches)
local rs_matches         = clink.argmatcher():addarg()
local features_matches   = clink.argmatcher():addarg()
local debugger_matches   = clink.argmatcher():addarg({fromhistory=true})
local debug_flag_matches = clink.argmatcher():addarg({fromhistory=true})
local program_matches    = clink.argmatcher():addarg()
local split_matches      = clink.argmatcher():addarg({fromhistory=true})
local extension_matches  = clink.argmatcher():addarg({fromhistory=true})
local module_matches     = clink.argmatcher():addarg({fromhistory=true})
local var_matches        = clink.argmatcher():addarg()

clink.argmatcher("perl")
  :_addexflags({
    { "-0"  .. rs_matches,         "<octal>",       "specify record separator (\0, if no argument)" },
    { "-a",                                         "autosplit mode with -n or -p (splits $_ into @F)" },
    { "-C"  .. features_matches,   "<number|list>", "enables the listed Unicode features" },
    { "-c",                                         "check syntax only (runs BEGIN and CHECK blocks)" },
    { "-d"  .. debugger_matches,   ":<debugger>",   "run program under debugger" },
    { "-D"  .. debug_flag_matches, "<number|list>", "set debugging flags (argument is a bit mask or alphabets)" },
    { "-e"  .. program_matches,    " <program>",    "one line of program (several -e's allowed, omit programfile)" },
    { "-E"  .. program_matches,    " <program>",    "like -e, but enables all optional features" },
    { "-f",                                         "don't do $sitelib/sitecustomize.pl at startup" },
    { "-F"  .. split_matches,      "<pattern>",     "split() pattern for -a switch (//'s are optional)" },
    { "-i"  .. extension_matches,  "<extension>",   "edit <> files in place (makes backup if extension supplied)" },
    { "-I"  .. dir_matches,        "<dir>",         "specify @INC/#include directory (several -I's allowed)" },
    { "-l"  .. rs_matches,         "<octal>",       "enable line ending processing, specifies line terminator" },
    { "-m"  .. module_matches,     "[-]<module>",   "execute \"use/no module...\" before executing program" },
    { "-M"  .. module_matches,     "[-]<module>",   "execute \"use/no module...\" before executing program" },
    { "-n",                                         "assume \"while (<>) { ... }\" loop around program" },
    { "-p",                                         "assume loop like -n but print line also, like sed" },
    { "-s",                                         "enable rudimentary parsing for switches after programfile" },
    { "-S",                                         "look for programfile using PATH environment variable" },
    { "-t",                                         "enable tainting warnings" },
    { "-T",                                         "enable tainting checks" },
    { "-u",                                         "dump core after parsing program" },
    { "-U",                                         "allow unsafe operations" },
    { "-v",                                         "print version, patchlevel and license" },
    { "-V" .. var_matches,        ":<variable>",    "print configuration summary (or a single Config.pm variable)" },
    { "-w",                                         "enable many useful warnings" },
    { "-W",                                         "enable all warnings" },
    { "-x" .. dir_matches,        "<dir>",          "ignore text before #!perl line (optionally cd to directory)" },
    { "-X",                                         "disable all warnings" },
  })
