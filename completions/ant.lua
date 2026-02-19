-- argument completion for ant
arghelper = require("arghelper")

local file_matches   = clink.argmatcher():addarg(clink.filematches)
local dir_matches    = clink.argmatcher():addarg(clink.dirmatches)
local class_matches  = clink.argmatcher():addarg({fromhistory=true})
local define_matches = clink.argmatcher():addarg({fromhistory=true})
local nice_matches   = clink.argmatcher():addarg({'1', '2', '3', '4', '5', '6', '7', '8', '9', '10'})


clink.argmatcher("ant")
  :_addexflags(arghelper.make_exflags({
      { "-h", "-help",                                             "Print help message and exit" },
      { "-p", "-projecthelp",                                      "Print project help information and exit" },
      { nil,  "-version",                                          "Print the version information and exit" },
      { nil,  "-diagnostics",                                      "Print information that might be helpful to diagnose or report problems and exit" },
      { "-q", "-quiet",                                            "Be extra quiet" },
      { "-S", "-silent",                                           "Print nothing but task outputs and build failures" },
      { "-v", "-verbose",                                          "Be extra verbose" },
      { "-d", "-debug",                                            "Print debugging information" },
      { "-e", "-emacs",                                            "Produce logging information without adornments" },
      { nil,  "-lib",            dir_matches,    " <dir>",         "Specifies a path to search for jars and classes" },
      { "-l", "-logfile",        file_matches,   " <file>",        "Use given file for log" },
      { nil,  "-logger",         class_matches,  " <classname>",   "The class which is to perform logging" },
      { nil,  "-listener",       class_matches,  " <classname>",   "Add an instance of class as a project listener" },
      { nil,  "-noinput",                                          "Do not allow interactive input" },
      { "-f", "-file",           file_matches,   " <file>",        "Use given buildfile" },
      { nil,  "-buildfile",      file_matches,   " <file>",        "Use given buildfile" },
      { "-D", nil,               define_matches, "<name>=<value>", "Use value for given property [-D<property>=<value>]" },
      { "-k", "-keep-going",                                       "Execute all targets that do not depend on failed target(s)" },
      { nil,  "-propertyfile",   file_matches,   " <file>",        "Load all properties from file with -D properties taking precedence" },
      { nil,  "-inputhandler",   class_matches,  " <classname>",   "The class which will handle input requests" },
      { "-s", "-find",           file_matches,   " <file>",        "Search for buildfile towards the root of the filesystem and use it" },
      { nil,  "-nice",           nice_matches,   " <n>",           "A niceness value for the main thread: 1 (lowest) to 10 (highest); 5 is the default" },
      { nil,  "-nouserlib",                                        "Run ant without using the jar files from ${user.home}/.ant/lib" },
      { nil,  "-noclasspath",                                      "Run ant without using CLASSPATH" },
      { nil,  "-autoproxy",                                        "Java1.5+: use the OS proxy settings" },
      { nil,  "-main",           class_matches,  " <classname>",   "Override Ant's normal entry point" },
    })
  )
  :nofiles()
