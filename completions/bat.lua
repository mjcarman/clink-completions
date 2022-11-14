-- argument completion for bat 0.21
require("arghelper")

local file_matches   = clink.argmatcher():addarg(clink.filematches)
local dir_matches    = clink.argmatcher():addarg(clink.dirmatches)
local mode_parser    = clink.argmatcher():addarg("auto", "never", "always")
local when_parser    = clink.argmatcher():addarg("auto", "never", "always")
local when_parser_AN = clink.argmatcher():addarg("always", "never")

local cache_parser = clink.argmatcher()
  :_addexflags({
    { "-b", hide=true }, { "--build",                         "Initialize (or update) the syntax/theme cache by loading from the source directory"      },
    { "-c", hide=true }, { "--clear",                         "Remove the cached syntax definitions and themes."                                        },
                         { "--source"..dir_matches, " <dir>", "Use a different directory to load syntaxes and themes from."                             },
                         { "--target"..dir_matches, " <dir>", "Use a different directory to store the cached syntax and theme set."                     },
                         { "--blank",                         "Create completely new syntax and theme sets (instead of appending to the default sets)." },
                         { "--acknowledgements",              "Build acknowledgements.bin."                                                             },
    { "-h", hide=true }, { "--help",                          "Prints help information"                                                                 },
  })

local style_parser = clink.argmatcher()
  :_addexarg({
    { "default",         "enables recommended style components (default)."                                 },
    { "full",            "enables all available components."                                               },
    { "auto",            "same as 'default', unless the output is piped."                                  },
    { "plain",           "disables all available components."                                              },
    { "changes",         "show Git modification markers."                                                  },
    { "header",          "alias for 'header-filename'."                                                    },
    { "header-filename", "show filenames before the content."                                              },
    { "header-filesize", "show file sizes before the content."                                             },
    { "grid",            "vertical/horizontal lines to separate side bar and the header from the content." },
    { "rule",            "horizontal lines to delimit files."                                              },
    { "numbers",         "show line numbers in the side bar."                                              },
    { "snip",            "draw separation lines between distinct line ranges."                             },
  })


clink.argmatcher("bat")
  :_addexarg({
    { "cache"..cache_parser, "Modify the syntax-definition and theme cache" },
    { file_matches },
  })
  :_addexflags({
    { "-A", hide=true }, { "--show-all",                                     "Show non-printable characters like space, tab or newline."                            },
    { "-p", hide=true }, { "--plain",                                        "Only show plain style, no decorations."                                               },
    { "-l", hide=true }, { "--language",                    " <language>",   "Explicitly set the language for syntax highlighting."                                 },
    { "-H", hide=true }, { "--highlight-line",              " <N:M>",        "Highlight the specified line ranges with a different background color."               },
                         { "--file-name",                   " <name>",       "Specify the name to display for a file."                                              },
    { "-d", hide=true }, { "--diff",                                         "Only show lines that have been added/removed/modified with respect to the Git index." },
                         { "--diff-context",                " <N>",          "Include N lines of context around added/removed/modified lines when using '--diff'."  },
                         { "--tabs",                        " <T>",          "Set the tab width to T spaces."                                                       },
                         { "--wrap"       ..mode_parser,    " <mode>",       "Specify the text-wrapping mode (*auto*, never, character)."                           },
                         { "--terminal-width",              " <width>",      "Explicitly set the width of the terminal instead of determining it automatically."    },
    { "-n", hide=true }, { "--number",                                       "Only show line numbers, no other decorations."                                        },
                         { "--color"      ..when_parser,    " <when>",       "Specify when to use colored output."                                                  },
                         { "--italic-text"..when_parser_AN, " <when>",       "Specify when to use ANSI sequences for italic text in the output."                    },
                         { "--decorations"..when_parser,    " <when>",       "Specify when to use the decorations that have been specified via '--style'."          },
    { "-f", hide=true }, { "--force-colorization",                           "Alias for '--decorations=always --color=always'."                                     },
    { "-P", hide=true }, { "--paging"     ..when_parser,    " <when>",       "Specify when to use the pager, or use '-P' to disable."                               },
                         { "--pager",                       " <command>",    "Determine which pager is used."                                                       },
    { "-m", hide=true }, { "--map-syntax",                  " <glob>",       "Map a glob pattern to an existing syntax name."                                       },
                         { "--ignored-suffix",              " <suffix>",     "Ignore extension."                                                                    },
                         { "--theme",                       " <theme>",      "Set the theme for syntax highlighting."                                               },
                         { "--list-themes",                                  "Display a list of supported themes for syntax highlighting."                          },
                         { "--style"      ..style_parser,   " <components>", "Comma-separated list of style elements to display."                                   },
    { "-r", hide=true }, { "--line-range",                  " <N:M>",        "Only print the lines from N to M."                                                    },
    { "-L", hide=true }, { "--list-languages",                               "Display a list of supported languages for syntax highlighting."                       },
    { "-u", hide=true }, { "--unbuffered",                                   "This option exists for POSIX-compliance reasons ('u' is for 'unbuffered')."           },
                         { "--diagnostic",                                   "Show diagnostic information for bug reports."                                         },
                         { "--acknowledgements",                             "Show acknowledgements."                                                               },
    { "-h", hide=true }, { "--help",                                         "Print help message."                                                                  },
    { "-V", hide=true }, { "--version",                                      "Show version information."                                                            },
  })
