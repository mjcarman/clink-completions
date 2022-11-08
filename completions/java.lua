-- argument completion for java
require("arghelper")

local file_matches      = clink.argmatcher():addarg({ clink.filematches })
local dir_matches       = clink.argmatcher():addarg({ clink.dirmatches })
local classpath_matches = clink.argmatcher():addarg({ clink.dirmatches, clink.filematches })
local package_matches   = clink.argmatcher():addarg({fromhistory=true})
local module_matches    = clink.argmatcher():addarg({fromhistory=true})
local libname_matches   = clink.argmatcher():addarg({fromhistory=true})
local pathname_matches  = clink.argmatcher():addarg({fromhistory=true})
local jarpath_matches   = clink.argmatcher():addarg({fromhistory=true})
local property_matches  = clink.argmatcher():addarg({fromhistory=true})
local verbose_parser    = clink.argmatcher():addarg("class", "module", "gc", "jni")


clink.argmatcher("java")
  :_addexflags({
    {            "-jar"                      .. file_matches,      " <file>",                 "Executable JAR file"                                                          },
    { hide=true, "-cp"                       .. classpath_matches, " <dir|zip|jar>[;...]",    "Directories, JAR archives, and ZIP archives to search for class files."       },
    { hide=true, "-classpath"                .. classpath_matches, " <dir|zip|jar>[;...]",    "Directories, JAR archives, and ZIP archives to search for class files."       },
    {            "--class-path"              .. classpath_matches, " <dir|zip|jar>[;...]",    "Directories, JAR archives, and ZIP archives to search for class files."       },
    { hide=true, "-p"                        .. dir_matches,       " <dir>[;<dir>]",          "Directories of modules"                                                       },
    {            "--module-path"             .. dir_matches,       " <dir>[;<dir>]",          "Directories of modules"                                                       },
    {            "--upgrade-module-path"     .. dir_matches,       " <dir>[;<dir>]",          "Directories of modules that replace upgradeable modules in the runtime image" },
    {            "--add-modules"             .. module_matches,    " <module>[,<module>]",    "Root modules to resolve in addition to the initial module."                   },
    {            "--enable-native-access"    .. module_matches,    " <module>[,<module>]",    "Modules that are permitted to perform restricted native operations."          },
    {            "--list-modules",                                                            "List observable modules and exit"                                             },
    { hide=true, "-d"                        .. module_matches,    " <module>",               "Describe a module and exit"                                                   },
    {            "--describe-module"         .. module_matches,    " <module>",               "Describe a module and exit"                                                   },
    {            "--dry-run",                                                                 "Create VM and load main class but do not execute main method."                },
    {            "--validate-modules",                                                        "Validate all modules and exit"                                                },
    {            "-D"                        .. property_matches,  "<name>=<value>",          "Set a system property (<name>=<value>)"                                       },
    {            "-verbose:"                 .. verbose_parser,                               "Enable verbose output for the given subsystem"                                },
    { hide=true, "-version",                                                                  "Print product version to the error stream and exit"                           },
    {            "--version",                                                                 "Print product version to the output stream and exit"                          },
    { hide=true, "-showversion",                                                              "Print product version to the error stream and continue"                       },
    {            "--show-version",                                                            "Print product version to the output stream and continue"                      },
    {            "--show-module-resolution",                                                  "Show module resolution output during startup"                                 },
    { hide=true, "-?",                                                                        "Print help message to the error stream"                                       },
    { hide=true, "-h",                                                                        "Print help message to the error stream"                                       },
    { hide=true, "-help",                                                                     "Print help message to the error stream"                                       },
    {            "--help",                                                                    "Print help message to the output stream"                                      },
    { hide=true, "-X",                                                                        "Print help on extra options to the error stream"                              },
    {            "--help-extra",                                                              "Print help on extra options to the output stream"                             },
    { hide=true, "-ea"                       .. package_matches,   " [:<package>|:<class>]",  "Enable assertions with specified granularity"                                 },
    {            "-enableassertions"         .. package_matches,   " [:<package>|:<class>]",  "Enable assertions with specified granularity"                                 },
    { hide=true, "-da"                       .. package_matches,   " [:<package>|:<class>]",  "Disable assertions with specified granularity"                                },
    {            "-disableassertions"        .. package_matches,   " [:<package>|:<class>]",  "Disable assertions with specified granularity"                                },
    { hide=true, "-esa",                                                                      "Enable system assertions"                                                     },
    {            "-enablesystemassertions",                                                   "Enable system assertions"                                                     },
    { hide=true, "-dsa",                                                                      "Disable system assertions"                                                    },
    {            "-disablesystemassertions",                                                  "Disable system assertions"                                                    },
    {            "-agentlib:"                .. libname_matches,   " <libname>[=<options>]",  "Load native agent library"                                                    },
    {            "-agentpath:"               .. pathname_matches,  " <pathname>[=<options>]", "Load native agent library by full pathname"                                   },
    {            "-javaagent:"               .. jarpath_matches,   " <jarpath>[=<options>]",  "Load Java programming language agent"                                         },
    {            "-splash:"                  .. file_matches,      " <imagepath>",            "Show splash screen with specified image"                                      },
    {            "@"                         .. file_matches,      " <file>",                 "argument file(s)"                                                             },
    {            "-disable-@files",                                                           "Prevent further argument file expansion"                                      },
    {            "--enable-preview",                                                          "Allow classes to depend on preview features of this release"                  },
  })
