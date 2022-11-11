-- argument completion for ant
require("arghelper")

local file_matches   = clink.argmatcher():addarg(clink.filematches)
local dir_matches    = clink.argmatcher():addarg(clink.dirmatches)
local class_matches  = clink.argmatcher():addarg({fromhistory=true})
local define_matches = clink.argmatcher():addarg({fromhistory=true})
local nice_matches   = clink.argmatcher():addarg()


clink.argmatcher("ant")
  :_addexflags({
    { hide=true, "-h",                                                "Print help message and exit" },
    {            "-help",                                             "Print help message and exit" },
    { hide=true, "-p",                                                "Print project help information and exit" },
    {            "-projecthelp",                                      "Print project help information and exit" },
    {            "-version",                                          "Print the version information and exit" },
    {            "-diagnostics",                                      "Print information that might be helpful to diagnose or report problems and exit" },
    { hide=true, "-q",                                                "Be extra quiet" },
    {            "-quiet",                                            "Be extra quiet" },
    { hide=true, "-S",                                                "Print nothing but task outputs and build failures" },
    {            "-silent",                                           "Print nothing but task outputs and build failures" },
    { hide=true, "-v",                                                "Be extra verbose" },
    {            "-verbose",                                          "Be extra verbose" },
    { hide=true, "-d",                                                "Print debugging information" },
    {            "-debug",                                            "Print debugging information" },
    { hide=true, "-e",                                                "Produce logging information without adornments" },
    {            "-emacs",                                            "Produce logging information without adornments" },
    {            "-lib"          .. dir_matches,    " <dir>",         "Specifies a path to search for jars and classes" },
    { hide=true, "-l"            .. file_matches,   " <file>",        "Use given file for log" },
    {            "-logfile"      .. file_matches,   " <file>",        "Use given file for log" },
    {            "-logger"       .. class_matches,  " <classname>",   "The class which is to perform logging" },
    {            "-listener"     .. class_matches,  " <classname>",   "Add an instance of class as a project listener" },
    {            "-noinput",                                          "Do not allow interactive input" },
    { hide=true, "-f"            .. file_matches,   " <file>",        "Use given buildfile" },
    { hide=true, "-file"         .. file_matches,   " <file>",        "Use given buildfile" },
    {            "-buildfile"    .. file_matches,   " <file>",        "Use given buildfile" },
    {            "-D"            .. define_matches, "<name>=<value>", "Use value for given property [-D<property>=<value>]" },
    { hide=true, "-k",                                                "Execute all targets that do not depend on failed target(s)" },
    {            "-keep-going",                                       "Execute all targets that do not depend on failed target(s)" },
    {            "-propertyfile" .. file_matches,   " <file>",        "Load all properties from file with -D properties taking precedence" },
    {            "-inputhandler" .. class_matches,  " <classname>",   "The class which will handle input requests" },
    { hide=true, "-s"            .. file_matches,   " <file>",        "Search for buildfile towards the root of the filesystem and use it" },
    { hide=true, "-find"         .. file_matches,   " <file>",        "Search for buildfile towards the root of the filesystem and use it" },
    {            "-nice"         .. nice_matches,   " <n>",           "A niceness value for the main thread: 1 (lowest) to 10 (highest); 5 is the default" },
    {            "-nouserlib",                                        "Run ant without using the jar files from ${user.home}/.ant/lib" },
    {            "-noclasspath",                                      "Run ant without using CLASSPATH" },
    {            "-autoproxy",                                        "Java1.5+: use the OS proxy settings" },
    {            "-main"         .. class_matches,  " <classname>",   "Override Ant's normal entry point" },
  })
  :nofiles()
