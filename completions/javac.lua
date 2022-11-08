-- argument completion for javac
require("arghelper")

local file_matches    = clink.argmatcher():addarg({ clink.filematches })
local dir_matches     = clink.argmatcher():addarg({ clink.dirmatches })
local flag_matches    = clink.argmatcher():addarg({fromhistory=true})
local module_matches  = clink.argmatcher():addarg({fromhistory=true})
local class_matches   = clink.argmatcher():addarg({fromhistory=true})
local version_matches = clink.argmatcher():addarg({fromhistory=true})
local profile_matches = clink.argmatcher():addarg({fromhistory=true})
local release_matches = clink.argmatcher():addarg({fromhistory=true})
local info_parser     = clink.argmatcher():addarg("lines", "vars", "source", "none")
local implicit_parser = clink.argmatcher():addarg("none", "class")
local proc_parser     = clink.argmatcher():addarg("none", "only")
local system_parser   = clink.argmatcher():addarg("none", {fromhistory=true})

clink.argmatcher("javac")
  :_addexflags({
    { "@"                       .. file_matches,    "<file>",               "Read options and filenames from file (@<file>)" },
    { "-A",                                         " <key>=<value>",       "Options to pass to annotation processors (<key>=<value>)" },
    { "--add-modules",                                                      "Root modules to resolve in addition to the initial modules" },
    { "-bootclasspath"          ..dir_matches,      hide=true },
    { "--boot-class-path"       ..dir_matches,      " <dir>",               "Override location of bootstrap class files" },
    { "-classpath"              ..dir_matches,      hide=true },
    { "--class-path"            ..dir_matches,      " <dir>",               "Specify where to find user class files and annotation processors" },
    { "-d"                      ..dir_matches,      " <dir>",               "Specify where to place generated class files" },
    { "-deprecation",                                                       "Output source locations where deprecated APIs are used" },
    { "--enable-preview",                                                   "Enable preview language features." },
    { "-encoding",                                                          "Specify character encoding used by source files" },
    { "-endorseddirs"           .. dir_matches,                             "Override location of endorsed standards path" },
    { "-extdirs"                .. dir_matches,                             "Override location of installed extensions" },
    { "-g",                                                                 "Generate debugging info" },
    { "-g:"                     .. info_parser,                             "Generate only some debugging info" },
    { "-h"                      .. dir_matches,                             "Specify where to place generated native header files" },
    { "-?",                                         hide=true },
    { "-help",                                      hide=true },
    { "--help",                                                             "Print help message" },
    { "-X",                                         hide=true },
    { "--help-extra",                                                       "Print help on extra options" },
    { "-implicit:"              .. implicit_parser,                         "Specify whether or not to generate class files for implicitly referenced files" },
    { "-J"                      .. flag_matches,    "<flag>",               "Pass <flag> directly to the runtime system (-J<flag>)" },
    { "--limit-modules"         .. module_matches,  " <module>[,<module>]", "Limit the universe of observable modules" },
    { "-m"                      .. module_matches,  hide=true },
    { "--module"                .. module_matches,  " <module>[,<module>]", "Compile only the specified module(s), check timestamps" },
    { "-p"                      .. dir_matches,     hide=true },
    { "--module-path"           .. dir_matches,     " <path>",              "Specify where to find application modules" },
    { "--module-source-path"    .. dir_matches,     " <path>",              "Specify where to find input source files for multiple modules" },
    { "--module-version"        .. version_matches, " <version>",           "Specify version of modules that are being compiled" },
    { "-nowarn",                                                            "Generate no warnings" },
    { "-parameters",                                                        "Generate metadata for reflection on method parameters" },
    { "-proc:"                  .. proc_parser,     " <proc>",              "Control whether annotation processing and/or compilation is done." },
    { "-processor"              .. class_matches,   " <class>[,<class>]",   "Names of the annotation processors to run; bypasses default discovery process" },
    { "--processor-module-path" .. dir_matches,     " <dir>",               "Specify a module path where to find annotation processors" },
    { "-processorpath"          .. dir_matches,     hide=true },
    { "---processor-path"       .. dir_matches,     " <dir>",               "Specify where to find annotation processors" },
    { "-profile"                .. profile_matches, " <profile>",           "Check that API used is available in the specified profile" },
    { "--release"               .. release_matches, " <release>",           "Compile for the specified Java SE release." },
    { "-s"                      .. dir_matches,     " <dir>",               "Specify where to place generated source files" },
    { "-source"                 .. release_matches, hide=true },
    { "--source"                .. release_matches, " <release>",           "Provide source compatibility with the specified Java SE release." },
    { "-sourcepath"             .. dir_matches,     hide=true },
    { "--source-path"           .. dir_matches,     " <dir>",               "Specify where to find input source files" },
    { "--system"                .. system_parser,   " <system>",            "Override location of system modules (<jdk>|none)" },
    { "-target"                 .. release_matches, hide=true },
    { "--target"                .. release_matches, " <release>",           "Generate class files suitable for the specified Java SE release." },
    { "--upgrade-module-path"   .. dir_matches,     " <dir>",               "Override location of upgradeable modules" },
    { "-verbose",                                                           "Output messages about what the compiler is doing" },
    { "-version",                                   hide=true },
    { "--version",                                                          "Version information" },
    { "-Werror",                                                            "Terminate compilation if warnings occur" },
  })
