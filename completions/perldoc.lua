-- argument completion for perldoc
require("arghelper")

local file_matches      = clink.argmatcher():addarg(clink.filematches)
local module_matches    = clink.argmatcher():addarg()
local function_matches  = clink.argmatcher():addarg()
local api_matches       = clink.argmatcher():addarg()
local variable_matches  = clink.argmatcher():addarg()
local regex_matches     = clink.argmatcher():addarg()
local option_matches    = clink.argmatcher():addarg({fromhistory=true})
local language_matches  = clink.argmatcher():addarg({fromhistory=true})
local formatter_matches = clink.argmatcher():addarg({fromhistory=true})


clink.argmatcher("perldoc")
  :_addexflags({
    { "-h",                                       "Prints out a brief help message." },
    { "-D",                                       "Describes search for the item in detail." },
    { "-t",                                       "Display docs using plain text converter, instead of nroff." },
    { "-u",                                       "Skip the real Pod formatting, and just show the raw Pod source" },
    { "-m" .. module_matches,     " <module>",    "Display the entire module: both code and unformatted pod documentation." },
    { "-l",                                       "Display only the file name of the module found." },
    { "-U",                                       "When running as the superuser, don't attempt drop privileges for security." },
    { "-F",                                       "Consider arguments as file names." },
    { "-f" .. function_matches,   " <function>",  "Extract documentation for function from perlfunc." },
    { "-q" .. regex_matches,      " <regex>",     "Search the question headings in perlfaq and print the entries matching the regular expression." },
    { "-a" .. api_matches,        " <function>",  "Extract the documentation of this function from perlapi." },
    { "-v" .. variable_matches,   " <variable>",  "Extract the documentation of this variable from perlvar." },
    { "-T",                                       "Send output directly to STDOUT instead of to a pager." },
    { "-d" .. file_matches,       " <file>",      "Send output to filename." },
    { "-o",                                       "Use specified class for POD formatting." },
    { "-M" .. module_matches,     " <module>",    "Use specified module for POD formatting." },
    { "-w" .. option_matches,     " <option>",    "Pass options to formatter. (<option>:<value> or <option>)" },
    { "-X",                                       "Use an index if it is present." },
    { "-L" .. language_matches,   " <code>",      "Specify the language code for the desired language translation." },
    { "-n" .. formatter_matches,  " <formatter>", "Specify replacement for groff formatter" },
    { "-r",                                       "Recursive search." },
    { "-i",                                       "Ignore case." },
    { "-V",                                       "Displays the version of perldoc you're running." },
  })
